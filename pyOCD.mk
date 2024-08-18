# pyOCD Debuger

TARGET := stm32-project

#######################################
# 工具
#######################################

PYOCD_PATH = /opt/stm32/pyocd/bin

PYOCD = $(PYOCD_PATH)/pyocd

#######################################
# 参数
#######################################
FIRMWARE    := ${TARGET}.elf

LOAD_FLAGS  := 
LOAD_FLAGS  += $(FIRMWARE) 
LOAD_FLAGS  += --target STM32F103RC

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

# target remote localhost:65533
