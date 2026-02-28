#!/bin/bash

# ==========================================================
# 脚本名称: ssh_auto_auth.sh
# 功能: 自动检测安装sshpass，并配置SSH免密登录
# ==========================================================

REMOTE_IP=$1
PASSWORD=$2
REMOTE_USER=${3:-root}

# 1. 参数检查
if [ $# -lt 2 ]; then
    echo "用法: $0 <远程IP> <密码> [用户名(可选,默认root)]"
    exit 1
fi

# 2. 检查并安装 sshpass
check_sshpass() {
    if ! command -v sshpass &> /dev/null; then
        echo "检测到未安装 sshpass，正在尝试安装..."
        
        # 识别操作系统
        if [ -f /etc/debian_version ]; then
            # Debian/Ubuntu 系列
            sudo apt-get update && sudo apt-get install -y sshpass
        elif [ -f /etc/redhat-release ] || [ -f /etc/system-release ]; then
            # CentOS/RHEL/Fedora 系列
            # CentOS 需要先安装 epel-release
            sudo yum install -y epel-release && sudo yum install -y sshpass
        elif [ -f /etc/arch-release ]; then
            # Arch Linux 系列
            sudo pacman -S --noconfirm sshpass
        else
            echo "无法识别的操作系统，请手动安装 sshpass 后重试。"
            exit 1
        fi

        # 二次检查安装是否成功
        if ! command -v sshpass &> /dev/null; then
            echo "sshpass 安装失败，请检查网络或软件源。"
            exit 1
        fi
        echo "sshpass 安装成功！"
    fi
}

# 执行安装检查
check_sshpass

# 3. 检查并生成本地 SSH 密钥
# 即使已有密钥也不会重复生成，避免覆盖原有密钥对
if [ ! -f ~/.ssh/id_rsa ]; then
    echo "正在生成本地 SSH 密钥 (RSA 4096位)..."
    # -q: 静默模式; -t: 算法; -N: 空密码; -f: 保存路径
    ssh-keygen -t rsa -b 4096 -N "" -f ~/.ssh/id_rsa
fi

# 4. 使用 sshpass 发送公钥
echo "正在尝试将公钥发送至 $REMOTE_IP (请稍候)..."

# 关键参数解释：
# -o StrictHostKeyChecking=no: 自动接受新主机的指纹，防止脚本被阻断
# -o ConnectTimeout=10: 设置连接超时时间
sshpass -p "$PASSWORD" ssh-copy-id -o StrictHostKeyChecking=no -o ConnectTimeout=10 "$REMOTE_USER@$REMOTE_IP"

# 5. 检查执行结果
if [ $? -eq 0 ]; then
    echo "------------------------------------------------"
    echo "成功: 免密配置完成！"
    echo "测试连接: ssh $REMOTE_USER@$REMOTE_IP"
    echo "------------------------------------------------"
else
    echo "------------------------------------------------"
    echo "失败: 请检查以下原因："
    echo "1. 远程服务器 IP 是否正确"
    echo "2. 密码是否正确"
    echo "3. 远程服务器是否开启了 SSH 服务（默认22端口）"
    echo "4. 远程服务器是否禁用了 root 登录"
    echo "------------------------------------------------"
    exit 1
fi