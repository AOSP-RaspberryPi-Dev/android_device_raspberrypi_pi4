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

DEVICE_PATH := device/raspberrypi/pi4

## A/B Updates
AB_OTA_UPDATER := true
AB_OTA_PARTITIONS += \
    boot

## APEX image
DEXPREOPT_GENERATE_APEX_IMAGE := true

## Architecture
TARGET_ARCH := arm64
TARGET_ARCH_VARIANT := armv8-a
TARGET_CPU_ABI := arm64-v8a
TARGET_CPU_ABI2 :=
TARGET_CPU_VARIANT := generic

## Architecture (Secondary)
TARGET_2ND_ARCH := arm
TARGET_2ND_ARCH_VARIANT := armv8-a
TARGET_2ND_CPU_ABI := armeabi-v7a
TARGET_2ND_CPU_ABI2 := armeabi
TARGET_2ND_CPU_VARIANT := generic

## Boot Image
BOARD_BOOTIMG_HEADER_VERSION := 2
BOARD_CUSTOM_BOOTIMG := true
BOARD_INCLUDE_DTB_IN_BOOTIMG := true
BOARD_KERNEL_BASE := 0x11ff800
BOARD_KERNEL_CMDLINE := androidboot.hardware=pi4 androidboot.boot_devices=emmc2bus/fe340000.mmc
BOARD_KERNEL_CMDLINE += console=serial0,115200 console=tty1
BOARD_KERNEL_OFFSET := 0x0000800
BOARD_KERNEL_PAGESIZE := 2048

BOARD_MKBOOTIMG_ARGS := --base $(BOARD_KERNEL_BASE)
BOARD_MKBOOTIMG_ARGS += --cmdline "$(BOARD_KERNEL_CMDLINE)"
BOARD_MKBOOTIMG_ARGS += --pagesize $(BOARD_KERNEL_PAGESIZE)
BOARD_MKBOOTIMG_ARGS += --kernel_offset $(BOARD_KERNEL_OFFSET)
BOARD_MKBOOTIMG_ARGS += --header_version $(BOARD_BOOTIMG_HEADER_VERSION)

## Display
TARGET_SCREEN_DENSITY := 560

## Filesystem
TARGET_USERIMAGES_USE_EXT4 := true

## Kernel
BOARD_KERNEL_IMAGE_NAME := Image
TARGET_KERNEL_CONFIG := bcm2711_defconfig
TARGET_KERNEL_NO_GCC := true
TARGET_KERNEL_SOURCE := kernel/raspberrypi/common

## Partitions
BOARD_BOOTIMAGE_PARTITION_SIZE  := 104857600 # 100 MB
BOARD_FLASH_BLOCK_SIZE := 4096

BOARD_USES_METADATA_PARTITION := true

## Platform
TARGET_BOARD_PLATFORM := pi4
TARGET_BOOTLOADER_BOARD_NAME := rpi

## Recovery
BOARD_USES_RECOVERY_AS_BOOT := true
TARGET_RECOVERY_FSTAB := $(DEVICE_PATH)/configs/init/fstab.pi4
TARGET_RECOVERY_PIXEL_FORMAT := "ABGR_8888"

## Security
VENDOR_SECURITY_PATCH := $(PLATFORM_SECURITY_PATCH)

## SELinux
BOARD_VENDOR_SEPOLICY_DIRS += $(DEVICE_PATH)/sepolicy/vendor

## Verified Boot
BOARD_AVB_ENABLE := true
BOARD_AVB_ROLLBACK_INDEX := $(PLATFORM_SECURITY_PATCH_TIMESTAMP)
