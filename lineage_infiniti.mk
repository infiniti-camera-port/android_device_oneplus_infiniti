#
# Copyright (C) 2026 The LineageOS Project
#
# SPDX-License-Identifier: Apache-2.0
#

# Dev/testbench root: bundle the su binary + adb_root package. Gated
# `ifneq ($(TARGET_BUILD_VARIANT),user)` + `ifeq ($(WITH_SU),true)` in
# vendor/lineage/config/common.mk, so it MUST be set before that inherit
# for the ifeq to see it. Pairs with ro.debuggable=1 for `adb root`, the
# LOS Rooted-debugging toggle, and app-level su.
WITH_SU := true

# Inherit from those products. Most specific first.
$(call inherit-product, $(SRC_TARGET_DIR)/product/core_64_bit_only.mk)
$(call inherit-product, $(SRC_TARGET_DIR)/product/full_base_telephony.mk)

# Inherit from infiniti device
$(call inherit-product, device/oneplus/infiniti/device.mk)

# Inherit some common Lineage stuff.
$(call inherit-product, vendor/lineage/config/common_full_phone.mk)

# Keep the userdebug build debuggable (ro.debuggable=1) so `adb root` + the LOS
# Rooted-debugging toggle work. common.mk sets PRODUCT_NOT_DEBUGGABLE_IN_USERDEBUG
# := true, forcing ro.debuggable=0. gen_build_prop gates ro.debuggable on
# config["ProductNotDebuggableInUserdebug"], fed via add_json_bool, which treats
# any non-empty string as true. Clear it after the common inherit so add_json_bool
# emits false.
PRODUCT_NOT_DEBUGGABLE_IN_USERDEBUG :=

PRODUCT_NAME := lineage_infiniti
PRODUCT_DEVICE := infiniti
PRODUCT_MANUFACTURER := OnePlus
PRODUCT_BRAND := OnePlus
PRODUCT_MODEL := CPH2745

PRODUCT_GMS_CLIENTID_BASE := android-oneplus

PRODUCT_BUILD_PROP_OVERRIDES += \
    BuildDesc="qssi_64-user 16 BP2A.250605.015 1779937534743 release-keys" \
    BuildFingerprint=OnePlus/CPH2745IN/OP611FL1:16/BP2A.250605.015/B.R4T3.2e4dd7d-a2e41f-a65541:user/release-keys \
    DeviceName=OP611FL1 \
    DeviceProduct=CPH2745 \
    SystemDevice=OP611FL1 \
    SystemName=CPH2745
