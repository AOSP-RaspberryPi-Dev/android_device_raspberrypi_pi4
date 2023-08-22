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
    boot \
    bootloader \
    dtbo \
    vbmeta \
    vendor_boot

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

## Audio
BOARD_USES_TINYHAL_AUDIO := true

## Boot Image
BOARD_BOOTCONFIG := androidboot.hardware=pi4 androidboot.boot_devices=emmc2bus/fe340000.mmc androidboot.console=ttyS0
BOARD_BOOTCONFIG += androidboot.wificountrycode=00
BOARD_BOOT_HEADER_VERSION := 4
BOARD_CUSTOM_BOOTIMG := true
BOARD_DTB_OFFSET := 0x3000000
BOARD_INCLUDE_DTB_IN_BOOTIMG := true
BOARD_INCLUDE_RECOVERY_RAMDISK_IN_VENDOR_BOOT := true
BOARD_KERNEL_BASE := 0x00000000
BOARD_KERNEL_CMDLINE := coherent_pool=1M 8250.nr_uarts=1 console=ttyS0,115200 console=tty1 root=/dev/ram0 rootwait vc_mem.mem_base=0x3ec00000 vc_mem.mem_size=0x40000000
BOARD_KERNEL_CMDLINE += firmware_class.path=/vendor/firmware
BOARD_KERNEL_OFFSET := 0x80000
BOARD_KERNEL_PAGESIZE := 4096
BOARD_RAMDISK_OFFSET := 0x3300000
BOARD_RAMDISK_USE_LZ4 := true

BOARD_MKBOOTIMG_ARGS := --base $(BOARD_KERNEL_BASE)
BOARD_MKBOOTIMG_ARGS += --pagesize $(BOARD_KERNEL_PAGESIZE)
BOARD_MKBOOTIMG_ARGS += --kernel_offset $(BOARD_KERNEL_OFFSET)
BOARD_MKBOOTIMG_ARGS += --header_version $(BOARD_BOOT_HEADER_VERSION)
BOARD_MKBOOTIMG_ARGS += --ramdisk_offset $(BOARD_RAMDISK_OFFSET)
BOARD_MKBOOTIMG_ARGS += --dtb_offset $(BOARD_DTB_OFFSET)

## Bootloader
BOARD_PACK_RADIOIMAGES += bootloader.img

## Display
TARGET_SCREEN_DENSITY := 160

## DTB
BOARD_DTB_CFG := $(DEVICE_PATH)/configs/kernel/dtb.cfg

## DTBO
BOARD_KERNEL_SEPARATED_DTBO := true
BOARD_DTBO_CFG := $(DEVICE_PATH)/configs/kernel/dtbo.cfg

## Dynamic Partitions
BOARD_SUPER_PARTITION_SIZE := $(shell echo $$(( 5 * 1024 * 1024 * 1024 )))
BOARD_SUPER_PARTITION_GROUPS := raspberrypi_dynamic_partitions
BOARD_RASPBERRYPI_DYNAMIC_PARTITIONS_SIZE := $(shell echo $$(( $(BOARD_SUPER_PARTITION_SIZE) - (4 * 1024 * 1024) )))
BOARD_RASPBERRYPI_DYNAMIC_PARTITIONS_PARTITION_LIST := \
    odm \
    odm_dlkm \
    product \
    system \
    system_dlkm \
    system_ext \
    vendor \
    vendor_dlkm

AB_OTA_PARTITIONS += \
    $(BOARD_RASPBERRYPI_DYNAMIC_PARTITIONS_PARTITION_LIST)

## Filesystem
BOARD_ODMIMAGE_FILE_SYSTEM_TYPE := ext4
BOARD_ODM_DLKMIMAGE_FILE_SYSTEM_TYPE := ext4
BOARD_PRODUCTIMAGE_FILE_SYSTEM_TYPE := ext4
BOARD_SYSTEMIMAGE_FILE_SYSTEM_TYPE := ext4
BOARD_SYSTEM_DLKMIMAGE_FILE_SYSTEM_TYPE := ext4
BOARD_SYSTEM_EXTIMAGE_FILE_SYSTEM_TYPE := ext4
BOARD_VENDORIMAGE_FILE_SYSTEM_TYPE := ext4
BOARD_VENDOR_DLKMIMAGE_FILE_SYSTEM_TYPE := ext4
TARGET_COPY_OUT_ODM := odm
TARGET_COPY_OUT_ODM_DLKM := odm_dlkm
TARGET_COPY_OUT_PRODUCT := product
TARGET_COPY_OUT_SYSTEM_DLKM := system_dlkm
TARGET_COPY_OUT_SYSTEM_EXT := system_ext
TARGET_COPY_OUT_VENDOR := vendor
TARGET_COPY_OUT_VENDOR_DLKM := vendor_dlkm
TARGET_USERIMAGES_USE_EXT4 := true

## Graphics
BOARD_MESA3D_BUILD_LIBGBM := true
BOARD_MESA3D_USES_MESON_BUILD := true
BOARD_MESA3D_GALLIUM_DRIVERS := vc4 v3d
BOARD_MESA3D_VULKAN_DRIVERS := broadcom
BOARD_USE_CUSTOMIZED_MESA := true

## Kernel
BOARD_KERNEL_IMAGE_NAME := Image
TARGET_KERNEL_CONFIG := bcm2711_defconfig
TARGET_KERNEL_NO_GCC := true
TARGET_KERNEL_SOURCE := kernel/raspberrypi/common

## Kernel Modules
BOARD_VENDOR_RAMDISK_KERNEL_MODULES_LOAD := $(strip $(shell cat $(DEVICE_PATH)/configs/kernel/modules.load))
BOOT_KERNEL_MODULES := $(BOARD_VENDOR_RAMDISK_KERNEL_MODULES_LOAD)

## Manifest
DEVICE_FRAMEWORK_COMPATIBILITY_MATRIX_FILE := \
    $(DEVICE_PATH)/device_framework_matrix.xml
DEVICE_MANIFEST_FILE := $(DEVICE_PATH)/manifest.xml

## Partitions
BOARD_BOOTIMAGE_PARTITION_SIZE := $(shell echo $$(( 64 * 1024 * 1024 )))
BOARD_BOOTLOADERIMAGE_PARTITION_SIZE := $(shell echo $$(( 256 * 1024 * 1024 )))
BOARD_DTBOIMG_PARTITION_SIZE := $(shell echo $$(( 8 * 1024 * 1024 )))
BOARD_VENDOR_BOOTIMAGE_PARTITION_SIZE := $(shell echo $$(( 32 * 1024 * 1024 )))
BOARD_FLASH_BLOCK_SIZE := 4096

BOARD_USES_METADATA_PARTITION := true

## Platform
TARGET_BOARD_PLATFORM := pi4
TARGET_BOOTLOADER_BOARD_NAME := rpi

## Properties
TARGET_VENDOR_PROP := $(DEVICE_PATH)/vendor.prop

## Recovery
BOARD_MOVE_RECOVERY_RESOURCES_TO_VENDOR_BOOT := true
TARGET_NO_RECOVERY := true
TARGET_RECOVERY_FSTAB := $(DEVICE_PATH)/configs/init/fstab.pi4
TARGET_RECOVERY_PIXEL_FORMAT := "RGBX_8888"

## Security
VENDOR_SECURITY_PATCH := $(PLATFORM_SECURITY_PATCH)

## SELinux
BOARD_VENDOR_SEPOLICY_DIRS += $(DEVICE_PATH)/sepolicy/vendor

## U-Boot
TARGET_U_BOOT_CONFIG := rpi_4_defconfig
TARGET_U_BOOT_SOURCE := bootable/raspberrypi/u-boot

## Verified Boot
BOARD_AVB_ENABLE := true
BOARD_AVB_ROLLBACK_INDEX := $(PLATFORM_SECURITY_PATCH_TIMESTAMP)

## Wi-Fi
BOARD_WLAN_DEVICE                := bcmdhd
BOARD_WPA_SUPPLICANT_DRIVER      := NL80211
BOARD_WPA_SUPPLICANT_PRIVATE_LIB := lib_driver_cmd_$(BOARD_WLAN_DEVICE)
BOARD_HOSTAPD_DRIVER             := NL80211
BOARD_HOSTAPD_PRIVATE_LIB        := lib_driver_cmd_$(BOARD_WLAN_DEVICE)
WIFI_HIDL_UNIFIED_SUPPLICANT_SERVICE_RC_ENTRY := true
WPA_SUPPLICANT_VERSION           := VER_0_8_X
