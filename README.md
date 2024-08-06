# 在WSL上调试STM32

<img src="README.images/pyocd.png" style="zoom: 63%;"/>

## [0] 先决条件

0.1 > 一个人：良好的C语言能力；熟悉Makefile；基本的Linux能力；了解GDB

GDB 命令概览 https://linuxtools-rst.readthedocs.io/zh-cn/latest/tool/gdb.html

0.2 > 安装有 WSL2 的 Windows 11 PC 

0.3 > STM32 开发板 ST-LINK ( v2 )

## [1] 安装编译链工具，实现在WSL上正常编译工程

1.1 安装交叉编译链工具 

https://developer.arm.com/downloads/-/gnu-rm

## [2] 安装调试链所需工具，跑通调试流程

2.1 安装Mamba

https://mamba.readthedocs.io/en/latest/installation/mamba-installation.html

2.2 安装pyOCD

安装 https://pyocd.io/docs/installing

文档1 （GDB setup）https://pyocd.io/docs/gdb_setup.html

文档2 （gdb remote server）https://pyocd.io/docs/gdbserver.html

文档3 （Command reference）https://pyocd.io/docs/command_reference.html

2.3 安装ST-LINK驱动 （及问题解决）

驱动下载 https://github.com/stlink-org/stlink/releases/tag/v1.8.0

deb安装包 https://blog.csdn.net/u013541325/article/details/123933564

问题：lib/x86_64-linux-gnu/libc.so.6: version `GLIBC_2.34' not found

解决方案：https://blog.csdn.net/huazhang_001/article/details/128828999

2.4 安装gdb-multiarch

2.5 在WSL中识别到USB

连接USB设备 https://learn.microsoft.com/zh-cn/windows/wsl/connect-usb

2.6 添加Makefile命令

```makefile
#######################################
# 工具
#######################################

PYOCD_PATH = /opt/stm32/pyocd/bin

PYOCD = $(PYOCD_PATH)/pyocd

#######################################
# 参数
#######################################

# 程序文件
FIRMWARE    := ${TARGET}.elf
# 下载参数
LOAD_FLAGS  := 
LOAD_FLAGS  += $(FIRMWARE) 
LOAD_FLAGS  += --target STM32F103RC
# 调试参数
DEBUG_FLAGS := 
DEBUG_FLAGS += --elf $(FIRMWARE) 
DEBUG_FLAGS += --port 65533 
DEBUG_FLAGS += --target STM32F103RC 
DEBUG_FLAGS += --frequency 10M 
DEBUG_FLAGS += -O rtos.enable=false

#######################################
# 命令
#######################################

load:
	$(PYOCD) flash $(LOAD_FLAGS)

server:
	$(PYOCD) gdbserver $(DEBUG_FLAGS) 

debug:
	gdb-multiarch $(FIRMWARE) 
```

.

## [3] 更巴适的GDB界面(可选)

3.1 安装 gdb-dashboard

https://github.com/cyrus-and/gdb-dashboard



# --------- \3oR ---------

待定。。。

