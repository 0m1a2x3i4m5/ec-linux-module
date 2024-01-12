MODULE_NAME ?= ecdrv

THIS_FILE := $(lastword $(MAKEFILE_LIST))
THIS_DIR  := $(abspath $(dir $(THIS_FILE)))

obj-m += $(MODULE_NAME).o
ccflags-y := -Wall -O -Wmaybe-uninitialized -DLMOD_NAME="$(MODULE_NAME)"

ifneq ($(KERNELRELEASE),)
# call from kernel build system
else

KERNEL_VER ?= $(shell uname -r)
KERNEL_DIR := /lib/modules/$(KERNEL_VER)/build
PWD       := $(THIS_DIR)

default:
	$(MAKE) -C $(KERNEL_DIR) M=$(PWD) modules

clean:
	$(MAKE) -C $(KERNEL_DIR) M=$(PWD) clean
endif

install:
	sudo insmod $(MODULE_NAME).ko
	@echo '  [ INS ]  Install module in linux kernel!'

remove:
	sudo rmmod $(MODULE_NAME)
	@echo '  [ REM ]  Remove module from kernel!'
	@echo ' '

reinstall: remove install

ifeq (.depend,$(wildcard .depend))
include .depend
endif
