《简单的VIM上手》
可以先输出一期简单的使用体验，我现在已经使用一周多了， 逐渐的慢慢上手了。
先掌握基本的按键，然后根据需要去学习更多的键位操作。

======================= VIM
Ctrl + h j k l 切换左右侧缓冲区
leader + ff 快速打开文件
- 注意 tab 选择时多选，需要Ctrl + j k 上下移动

leader + fw 全局搜索文件中的内容
leader + b 会提示 缓冲区窗口相关

Ctrl + o 上一个位置
Ctrl + i 下一个位置

wq/q + a 都是将命令作用与当前打开的所有窗口

====================== 代码相关

- leader + / 注释当前行；
	- 选中后同理；
- doxygen插件；
	- leader d + f 文件说明头;
	- leader d + g 函数注释说明;
- leader l + a， 根据函数声明生成函数定义；

====================== 文字选中操作
v模式 ---> h j k l ---> y 复制
v模式 ---> x 剪贴
v模式 ---> p 粘贴

====================== 窗口操作
- Ctrl + w v 当前窗口查分到右侧
  - leader + ff 搜到文件后 Ctrl + v 同样右侧分屏打开
- Ctrl + 方向键，调整当前焦点所在的窗口大小

在已打开的缓冲区中指定切换
- leader + fb 加 Ctrl + j/k 

在一打开的缓冲区中滚动切换
- ] + b 
====================== 终端
- leader + tf 浮动窗口打开，退出编辑模式后重复按键退出；
- leader + tv 右侧垂直打开， Ctrl + h j k l 可以切换回缓冲区；
	- Ctrl + / 加 Ctrl + n，终端退出编辑模式；
- 使用 toggleterm.nvim 插件；
	- F7 可以快速隐藏打开终端；

====================== 其他
Ctrl + page up/dow ubuntu terminal窗口切换
Ctrl + shift + n 新建一个独立的terminal

Leader + S l加载上一次的工作区
 
====================== 非核心
i 模式下，连续按两次 j 退出编辑模式
（可以找一下astro vim默认自带的一些设置都在哪	）

H 关闭文件目录树隐藏文件
leader + ft 快速切换主题

====================== 小操作
大写都用Shift实现，而不是大写键，比如查找的N n切换
大写锁定键切换为ESC
切换按键映射 gsettings set org.gnome.desktop.input-sources xkb-options "['caps:escape']"
还原 gsettings reset org.gnome.desktop.input-sources xkb-options


====================== 辅助工具
- 窗口项目多开 Tabby，用于开多个终端；
