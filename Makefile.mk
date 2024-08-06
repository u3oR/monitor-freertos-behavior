######################################
# target
######################################
TARGET = stm32-project

#######################################
# paths
#######################################
BUILD_DIR = Build

######################################
# source
######################################
# C sources
C_SOURCES := 
# Core Files
C_SOURCES += Core/Src/main.c 
C_SOURCES += Core/Src/gpio.c 
C_SOURCES += Core/Src/tim.c 
C_SOURCES += Core/Src/usart.c 
C_SOURCES += Core/Src/stm32f1xx_it.c 
C_SOURCES += Core/Src/stm32f1xx_hal_msp.c 
C_SOURCES += Core/Src/stm32f1xx_hal_timebase_tim.c 
C_SOURCES += Core/Src/system_stm32f1xx.c 
C_SOURCES += Core/Src/sysmem.c 
C_SOURCES += Core/Src/syscalls.c 
# HAL
C_SOURCES += Drivers/STM32F1xx_HAL_Driver/Src/stm32f1xx_hal_gpio_ex.c  
C_SOURCES += Drivers/STM32F1xx_HAL_Driver/Src/stm32f1xx_hal_tim.c  
C_SOURCES += Drivers/STM32F1xx_HAL_Driver/Src/stm32f1xx_hal_tim_ex.c 
C_SOURCES += Drivers/STM32F1xx_HAL_Driver/Src/stm32f1xx_hal.c 
C_SOURCES += Drivers/STM32F1xx_HAL_Driver/Src/stm32f1xx_hal_rcc.c 
C_SOURCES += Drivers/STM32F1xx_HAL_Driver/Src/stm32f1xx_hal_rcc_ex.c 
C_SOURCES += Drivers/STM32F1xx_HAL_Driver/Src/stm32f1xx_hal_gpio.c 
C_SOURCES += Drivers/STM32F1xx_HAL_Driver/Src/stm32f1xx_hal_dma.c 
C_SOURCES += Drivers/STM32F1xx_HAL_Driver/Src/stm32f1xx_hal_cortex.c 
C_SOURCES += Drivers/STM32F1xx_HAL_Driver/Src/stm32f1xx_hal_pwr.c 
C_SOURCES += Drivers/STM32F1xx_HAL_Driver/Src/stm32f1xx_hal_flash.c 
C_SOURCES += Drivers/STM32F1xx_HAL_Driver/Src/stm32f1xx_hal_flash_ex.c 
C_SOURCES += Drivers/STM32F1xx_HAL_Driver/Src/stm32f1xx_hal_exti.c 
C_SOURCES += Drivers/STM32F1xx_HAL_Driver/Src/stm32f1xx_hal_uart.c 
# FreeRTOS Core
C_SOURCES += UserApp/Lib/FreeRTOS/croutine.c 
C_SOURCES += UserApp/Lib/FreeRTOS/event_groups.c 
C_SOURCES += UserApp/Lib/FreeRTOS/list.c 
C_SOURCES += UserApp/Lib/FreeRTOS/queue.c 
C_SOURCES += UserApp/Lib/FreeRTOS/stream_buffer.c 
C_SOURCES += UserApp/Lib/FreeRTOS/tasks.c 
C_SOURCES += UserApp/Lib/FreeRTOS/timers.c 
# FreeRTOS Port
C_SOURCES += UserApp/Lib/FreeRTOS/portable/GCC/ARM_CM3/port.c 
C_SOURCES += UserApp/Lib/FreeRTOS/portable/MemMang/heap_4.c 
# User Files
# C_SOURCES += UserApp/syscalls.c 
C_SOURCES += UserApp/user_main.c 


# ASM sources
ASM_SOURCES := 
ASM_SOURCES += startup_stm32f103xe.s

# ASM sources
ASMM_SOURCES = 


#######################################
# binaries
#######################################
GCC_PATH := /opt/stm32/gcc-arm-none-eabi-10.3-2021.10/bin/
# GCC_PATH := /bin/

CC  = $(GCC_PATH)arm-none-eabi-gcc
AS  = $(GCC_PATH)arm-none-eabi-gcc -x assembler-with-cpp
CP  = $(GCC_PATH)arm-none-eabi-objcopy
SZ  = $(GCC_PATH)arm-none-eabi-size

HEX = $(CP) -O ihex
BIN = $(CP) -O binary -S
 
#######################################
# CFLAGS
#######################################

# C includes
C_INCLUDES := 
C_INCLUDES += -ICore/Inc
C_INCLUDES += -IDrivers/STM32F1xx_HAL_Driver/Inc 
C_INCLUDES += -IDrivers/STM32F1xx_HAL_Driver/Inc/Legacy 
C_INCLUDES += -IDrivers/CMSIS/Device/ST/STM32F1xx/Include 
C_INCLUDES += -IDrivers/CMSIS/Include
C_INCLUDES += -IUserApp
C_INCLUDES += -IUserApp/Lib/CMSIS/DSP/include
C_INCLUDES += -IUserApp/Lib/FreeRTOS/include
C_INCLUDES += -IUserApp/Lib/FreeRTOS/portable/GCC/ARM_CM3


# Common compile flags
CFLAGS := 
CFLAGS += -mcpu=cortex-m3 
CFLAGS += -mthumb 
CFLAGS += -Wall 
CFLAGS += -fdata-sections 
CFLAGS += -ffunction-sections 
CFLAGS += -Og 

ASFLAGS := 
ASFLAGS += $(CFLAGS)

# Include folders
CFLAGS += $(C_INCLUDES)
# Defines
CFLAGS += -DSTM32F103xE
CFLAGS += -DUSE_HAL_DRIVER
CFLAGS += -DARM_MATH_CM3
# Generate dependency information
CFLAGS += -MMD -MP -MF"$(@:%.o=%.d)"
# Debug
CFLAGS += -g 
CFLAGS += -gdwarf-2

#######################################
# LDFLAGS
#######################################
LDFLAGS := 

LDFLAGS += -LUserApp/Lib/CMSIS/DSP/lib/GCC
# libraries
LDFLAGS += -lc
LDFLAGS += -lm
LDFLAGS += -lnosys
LDFLAGS += -larm_cortexM3l_math

LDFLAGS += -mcpu=cortex-m3 
LDFLAGS += -specs=nano.specs 
LDFLAGS += -Wl,-Map=$(BUILD_DIR)/$(TARGET).map,--cref 
LDFLAGS += -Wl,--gc-sections
# Link Scripts
LDFLAGS += -TSTM32F103RCTx_FLASH.ld



# default action: build all
all: $(BUILD_DIR)/$(TARGET).elf $(BUILD_DIR)/$(TARGET).hex $(BUILD_DIR)/$(TARGET).bin


#######################################
# build the application
#######################################
# list of objects
OBJECTS = $(addprefix $(BUILD_DIR)/,$(notdir $(C_SOURCES:.c=.o)))
vpath %.c $(sort $(dir $(C_SOURCES)))
# list of ASM program objects
OBJECTS += $(addprefix $(BUILD_DIR)/,$(notdir $(ASM_SOURCES:.s=.o)))
vpath %.s $(sort $(dir $(ASM_SOURCES)))
OBJECTS += $(addprefix $(BUILD_DIR)/,$(notdir $(ASMM_SOURCES:.S=.o)))
vpath %.S $(sort $(dir $(ASMM_SOURCES)))

$(BUILD_DIR)/%.o: %.c Makefile | $(BUILD_DIR) 
	@$(CC) -c $(CFLAGS) -Wa,-a,-ad,-alms=$(BUILD_DIR)/$(notdir $(<:.c=.lst)) $< -o $@
	@echo Compiling  $<

$(BUILD_DIR)/%.o: %.s Makefile | $(BUILD_DIR)
	@$(AS) -c $(ASFLAGS) $< -o $@
	@echo Compiling  $<

$(BUILD_DIR)/%.o: %.S Makefile | $(BUILD_DIR)
	@$(AS) -c $(ASFLAGS) $< -o $@
	@echo Compiling  $<

$(BUILD_DIR)/$(TARGET).elf: $(OBJECTS) Makefile
	@echo Generate $@
	@$(CC) $(OBJECTS) $(LDFLAGS) -o $@
	@echo File information
	@$(SZ) $@
	cp $(BUILD_DIR)/$(TARGET).elf $(TARGET).elf 
	

$(BUILD_DIR)/%.hex: $(BUILD_DIR)/%.elf | $(BUILD_DIR)
	@echo Generate $@
	@$(HEX) $< $@
	
$(BUILD_DIR)/%.bin: $(BUILD_DIR)/%.elf | $(BUILD_DIR)
	@echo Generate $@
	@$(BIN) $< $@	
	
$(BUILD_DIR):
	mkdir -p $@

#######################################
# clean up
#######################################
clean:
	-rm -fR $(BUILD_DIR)
	rm $(TARGET).elf
  
#######################################
# dependencies
#######################################
-include $(wildcard $(BUILD_DIR)/*.d)

# *** EOF ***

#######################################
# 工具
#######################################
GDB = $(GCC_PATH)arm-none-eabi-gdb

PYOCD_PATH = /opt/stm32/pyocd/bin

PYOCD = $(PYOCD_PATH)/pyocd


#######################################
# 参数
#######################################
FIRMWARE = ${TARGET}.elf

DOWNLOAD_FLAGS = $(FIRMWARE) --target STM32F103RC

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
	$(PYOCD) flash $(DOWNLOAD_FLAGS)

server:
	$(PYOCD) gdbserver $(DEBUG_FLAGS) 

debug:
	gdb-multiarch $(FIRMWARE) 
# $(GDB) $(FIRMWARE) 
# target remote localhost:65533

