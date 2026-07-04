#
# Copyright (C) 2021-2026 The LineageOS Project
#
# SPDX-License-Identifier: Apache-2.0
#

USE_PREBUILT_KERNEL ?= true

# Partitions
BOARD_SUPER_PARTITION_SIZE := 17062428672

# Include the common OEM chipset BoardConfig.
include device/oneplus/sm8850-common/BoardConfigCommon.mk

# Camera (Oplus camera port) — common camera board fragment (split topology)
# rearchv2 retired (empty sepolicy; sepolicy via vendor-common SEPolicy.mk): -include device/oneplus/sm8850-common-camera/BoardConfigCommonCamera.mk

DEVICE_PATH := device/oneplus/infiniti

# Assert
TARGET_OTA_ASSERT_DEVICE := OP60FFL1,OP611FL1

# Display
TARGET_SCREEN_DENSITY := 540

# Kernel
ifeq ($(USE_PREBUILT_KERNEL), true)
include device/oneplus/infiniti-kernel/BoardConfig.mk
else
TARGET_KERNEL_ADDITIONAL_FLAGS += CONFIG_INFINITI_DTB=y
endif

# Properties
TARGET_ODM_PROP += $(DEVICE_PATH)/odm.prop
TARGET_SYSTEM_EXT_PROP += $(DEVICE_PATH)/system_ext.prop
TARGET_VENDOR_PROP += $(DEVICE_PATH)/vendor.prop

# Recovery
TARGET_RECOVERY_UI_MARGIN_HEIGHT := 103

# Include the proprietary files BoardConfig.
include vendor/oneplus/infiniti/BoardConfigVendor.mk

# Camera (Oplus camera port) — OEM camera sets vendor props outside the standard namespace
BUILD_BROKEN_VENDOR_PROPERTY_NAMESPACE := true

# AI Unit — the stock app-dir JNI payloads (product/{priv-app,app}/*/lib/arm64)
# ship via PRODUCT_COPY_FILES: the apks embed no native libs and PM derives the
# app ABI from the bundled lib dir (the OOS-stock layout); no soong prebuilt
# module type can install into an app dir. Only disables the ELF-in-copy-files
# lint.
BUILD_BROKEN_ELF_PREBUILT_PRODUCT_COPY_FILES := true
