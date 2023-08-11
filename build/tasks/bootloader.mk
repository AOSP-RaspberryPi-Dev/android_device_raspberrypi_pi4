#
# Copyright (C) 2023 The LineageOS Project
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

ifneq ($(TARGET_NO_BOOTLOADER),true)
ifneq ($(BOARD_BOOTLOADERIMAGE_PARTITION_SIZE),)
ifneq ($(TARGET_U_BOOT_SOURCE),)

U_BOOT_OUT := $(TARGET_OUT_INTERMEDIATES)/U_BOOT_OBJ
U_BOOT_BIN := $(U_BOOT_OUT)/u-boot.bin

U_BOOT_BUILD_TOOLS_PATH := $(BUILD_TOP)/prebuilts/build-tools/$(HOST_PREBUILT_TAG)/bin
U_BOOT_CLANG_PATH := $(shell find $(BUILD_TOP)/prebuilts/clang/host/$(HOST_PREBUILT_TAG)/clang-*[0-9]* -maxdepth 0 | tail -n1)
U_BOOT_MAKE_FLAGS := -C $(BUILD_TOP)/$(TARGET_U_BOOT_SOURCE) O=$(BUILD_TOP)/$(U_BOOT_OUT)
U_BOOT_MAKE_FLAGS += -j$(shell getconf _NPROCESSORS_ONLN)
U_BOOT_MAKE_FLAGS += ARCH=arm CROSS_COMPILE=aarch64-linux-gnu- LLVM=1
U_BOOT_PATH_OVERRIDE := PATH=$(U_BOOT_CLANG_PATH)/bin:$(U_BOOT_BUILD_TOOLS_PATH):$$PATH
U_BOOT_PATH_OVERRIDE += BISON_PKGDATADIR=$(BUILD_TOP)/prebuilts/build-tools/common/bison

$(U_BOOT_BIN): $(TARGET_U_BOOT_SOURCE)
	@echo "Building u-boot.bin"
	$(hide) $(U_BOOT_PATH_OVERRIDE) make $(U_BOOT_MAKE_FLAGS) $(TARGET_U_BOOT_CONFIG)
	$(hide) $(U_BOOT_PATH_OVERRIDE) make $(U_BOOT_MAKE_FLAGS)

MTOOLS := $(HOST_OUT_EXECUTABLES)/mtools$(HOST_EXECUTABLE_SUFFIX)

BOOTLOADER_FILES := $(PRODUCT_OUT)/bootloader_files
BOOTLOADER_SIZE_MB := $(shell echo $$(( $(BOARD_BOOTLOADERIMAGE_PARTITION_SIZE) / 1024 / 1024 )))
DTB_OUT := $(KERNEL_OUT)/arch/$(KERNEL_ARCH)/boot/dts
FIRMWARE_DIR := vendor/raspberrypi/rpi-firmware

$(BOOTLOADER_FILES): $(TARGET_PREBUILT_INT_KERNEL) $(FIRMWARE_DIR) $(U_BOOT_BIN)
	$(hide) mkdir -p $@
	cp $(DEVICE_PATH)/configs/bootloader/* $@
	cp $(DTB_OUT)/broadcom/*.dtb $@
	$(hide) mkdir -p $@/overlays
	cp $(DTB_OUT)/overlays/*.dtbo $@/overlays
	cp $(FIRMWARE_DIR)/*.bin $@
	cp $(FIRMWARE_DIR)/*.dat $@
	cp $(FIRMWARE_DIR)/*.elf $@
	cp $(U_BOOT_BIN) $@

$(INSTALLED_BOOTLOADER_MODULE): $(MTOOLS) $(BOOTLOADER_FILES)
	@echo "Building bootloader.img"
	$(hide) dd if=/dev/zero of=$@ bs=1M count=$(BOOTLOADER_SIZE_MB)
	$(hide) $(MTOOLS) -c mformat -F -i $@
	$(hide) $(MTOOLS) -c mcopy -s -i $@ $(BOOTLOADER_FILES)/* ::

.PHONY: bootloaderimage
bootloaderimage: $(INSTALLED_BOOTLOADER_MODULE)

endif # TARGET_U_BOOT_SOURCE
endif # BOARD_BOOTLOADERIMAGE_PARTITION_SIZE
endif # TARGET_NO_BOOTLOADER
