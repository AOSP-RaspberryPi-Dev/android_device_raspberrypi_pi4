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

DEVICE_PATH := device/raspberrypi/pi4

# Inherit from generic products, most specific first
$(call inherit-product, $(SRC_TARGET_DIR)/product/core_64_bit.mk)
$(call inherit-product, $(SRC_TARGET_DIR)/product/full_base.mk)

# Setup dalvik vm configs
$(call inherit-product, frameworks/native/build/phone-xhdpi-4096-dalvik-heap.mk)

# Enable updating of APEXes
$(call inherit-product, $(SRC_TARGET_DIR)/product/updatable_apex.mk)

# Enable virtual A/B
$(call inherit-product, $(SRC_TARGET_DIR)/product/generic_ramdisk.mk)
$(call inherit-product, \
    $(SRC_TARGET_DIR)/product/virtual_ab_ota/android_t_baseline.mk)

PRODUCT_VIRTUAL_AB_COMPRESSION_METHOD := lz4

# Boot Animation
TARGET_SCREEN_HEIGHT := 1080
TARGET_SCREEN_WIDTH := 1920

# BootControl HAL
PRODUCT_PACKAGES += \
    android.hardware.boot-service.default \
    android.hardware.boot-service.default_recovery

# Device identifier, this must come after all inclusions
PRODUCT_NAME := pi4
PRODUCT_DEVICE := pi4
PRODUCT_BRAND := raspberrypi
PRODUCT_MODEL := 4 Model B
PRODUCT_MANUFACTURER := Raspberry Pi
PRODUCT_SHIPPING_API_LEVEL := 34

# Dynamic Partitions
PRODUCT_USE_DYNAMIC_PARTITIONS := true

# fastbootd
PRODUCT_PACKAGES += \
    fastbootd

# Gatekeeper
PRODUCT_PACKAGES += \
    android.hardware.gatekeeper@1.0-service.software

# init
PRODUCT_COPY_FILES += \
    $(DEVICE_PATH)/configs/init/fstab.pi4:$(TARGET_COPY_OUT_VENDOR_RAMDISK)/first_stage_ramdisk/fstab.pi4 \
    $(DEVICE_PATH)/configs/init/init.recovery.pi4.rc:$(TARGET_COPY_OUT_RECOVERY)/root/init.recovery.pi4.rc

# Keymint
PRODUCT_PACKAGES += \
    android.hardware.security.keymint-service

# Overlays
DEVICE_PACKAGE_OVERLAYS += $(DEVICE_PATH)/overlay
PRODUCT_ENFORCE_RRO_TARGETS := *
