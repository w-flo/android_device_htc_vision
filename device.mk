#
# Copyright (C) 2011 The CyanogenMod Project
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

$(call inherit-product, $(SRC_TARGET_DIR)/product/languages_full.mk)

# The gps config appropriate for this device
PRODUCT_COPY_FILES += \
    device/htc/vision/gps.conf:system/etc/gps.conf

## (1) First, the most specific values, i.e. the aspects that are specific to GSM

PRODUCT_COPY_FILES += \
    device/htc/vision/init.vision.rc:root/init.vision.rc \
    device/htc/vision/ueventd.vision.rc:root/ueventd.vision.rc

## (2) Also get non-open-source GSM-specific aspects if available
$(call inherit-product-if-exists, vendor/htc/vision/device-vendor.mk)

## (3)  Finally, the least specific parts, i.e. the non-GSM-specific aspects
PRODUCT_PROPERTY_OVERRIDES += \
    ro.com.google.locationfeatures=1 \
    ro.com.google.networklocation=1 \
    ro.com.google.gmsversion=2.3_r3 \
    ro.setupwizard.enable_bypass=1 \
    dalvik.vm.lockprof.threshold=500 \
    dalvik.vm.dexopt-flags=m=y

# Override /proc/sys/vm/dirty_ratio on UMS
PRODUCT_PROPERTY_OVERRIDES += \
    ro.vold.umsdirtyratio=20

# Andromadus Version will find somewhere better for this....
PRODUCT_PROPERTY_OVERRIDES += \
    ro.modversion=Alpha11

DEVICE_PACKAGE_OVERLAYS += device/htc/vision/overlay

PRODUCT_COPY_FILES += \
    frameworks/base/data/etc/android.hardware.telephony.gsm.xml:system/etc/permissions/android.hardware.telephony.gsm.xml \

# gsm config xml file
PRODUCT_COPY_FILES += \
    device/htc/vision/voicemail-conf.xml:system/etc/voicemail-conf.xml

# Sensors, GPS, Lights
PRODUCT_PACKAGES += \
    gps.vision \
    lights.vision \
    sensors.vision

# Input device calibration files
PRODUCT_COPY_FILES += \
    device/htc/vision/idc/atmel-touchscreen.idc:system/usr/idc/atmel-touchscreen.idc \
    device/htc/vision/idc/curcial-oj.idc:system/usr/idc/curcial-oj.idc

# Keylayouts
PRODUCT_COPY_FILES += \
    device/htc/vision/keylayout/vision-keypad-ara.kl:system/usr/keylayout/vision-keypad-ara.kl \
    device/htc/vision/keylayout/vision-keypad-ell.kl:system/usr/keylayout/vision-keypad-ell.kl \
    device/htc/vision/keylayout/vision-keypad-esn.kl:system/usr/keylayout/vision-keypad-esn.kl \
    device/htc/vision/keylayout/vision-keypad-fra.kl:system/usr/keylayout/vision-keypad-fra.kl \
    device/htc/vision/keylayout/vision-keypad-ger.kl:system/usr/keylayout/vision-keypad-ger.kl \
    device/htc/vision/keylayout/vision-keypad-hk.kl:system/usr/keylayout/vision-keypad-hk.kl \
    device/htc/vision/keylayout/vision-keypad-ita.kl:system/usr/keylayout/vision-keypad-ita.kl \
    device/htc/vision/keylayout/vision-keypad.kl:system/usr/keylayout/vision-keypad.kl \
    device/htc/vision/keylayout/vision-keypad-nor.kl:system/usr/keylayout/vision-keypad-nor.kl \
    device/htc/vision/keylayout/vision-keypad-rus.kl:system/usr/keylayout/vision-keypad-rus.kl \
    device/htc/vision/keylayout/vision-keypad-sea.kl:system/usr/keylayout/vision-keypad-sea.kl \
    device/htc/vision/keylayout/vision-keypad-tur.kl:system/usr/keylayout/vision-keypad-tur.kl \
    device/htc/vision/keylayout/vision-keypad-wwe-bopomo.kl:system/usr/keylayout/vision-keypad-wwe-bopomo.kl \
    device/htc/vision/keylayout/vision-keypad-wwe.kl:system/usr/keylayout/vision-keypad-wwe.kl \
    device/htc/vision/keylayout/atmel-touchscreen.kl:system/usr/keylayout/atmel-touchscreen.kl 

# Keymaps
PRODUCT_COPY_FILES += \
    device/htc/vision/keychars/vision-keypad-ara.kcm:system/usr/keychars/vision-keypad-ara.kcm \
    device/htc/vision/keychars/vision-keypad-ell.kcm:system/usr/keychars/vision-keypad-ell.kcm \
    device/htc/vision/keychars/vision-keypad-esn.kcm:system/usr/keychars/vision-keypad-esn.kcm \
    device/htc/vision/keychars/vision-keypad-fra.kcm:system/usr/keychars/vision-keypad-fra.kcm \
    device/htc/vision/keychars/vision-keypad-ger.kcm:system/usr/keychars/vision-keypad-ger.kcm \
    device/htc/vision/keychars/vision-keypad-hk.kcm:system/usr/keychars/vision-keypad-hk.kcm \
    device/htc/vision/keychars/vision-keypad-ita.kcm:system/usr/keychars/vision-keypad-ita.kcm \
    device/htc/vision/keychars/vision-keypad.kcm:system/usr/keychars/vision-keypad.kcm \
    device/htc/vision/keychars/vision-keypad-nor.kcm:system/usr/keychars/vision-keypad-nor.kcm \
    device/htc/vision/keychars/vision-keypad-rus.kcm:system/usr/keychars/vision-keypad-rus.kcm \
    device/htc/vision/keychars/vision-keypad-sea.kcm:system/usr/keychars/vision-keypad-sea.kcm \
    device/htc/vision/keychars/vision-keypad-tur.kcm:system/usr/keychars/vision-keypad-tur.kcm \
    device/htc/vision/keychars/vision-keypad-wwe-bopomo.kcm:system/usr/keychars/vision-keypad-wwe-bopomo.kcm \
    device/htc/vision/keychars/vision-keypad-wwe.kcm:system/usr/keychars/vision-keypad-wwe.kcm 

# Device specific firmware
PRODUCT_COPY_FILES += \
    device/htc/vision/firmware/bcm4329.hcd:system/vendor/firmware/bcm4329.hcd \
    device/htc/vision/firmware/default.acdb:system/etc/firmware/default.acdb \
    device/htc/vision/firmware/default_org.acdb:system/etc/firmware/default_org.acdbi \
    device/htc/vision/firmware/default_org_WA.acdb:system/etc/firmware/default_org_WA.acdb \
    device/htc/vision/firmware/vidc_720p_mp2_dec_mc.fw:system/etc/firmware/vidc_720p_mp2_dec_mc.fw \
    device/htc/vision/firmware/Vision_SPK.acdb:system/etc/firmware/Vision_SPK.acdb 

# Audio DSP Profiles
PRODUCT_COPY_FILES += \
    device/htc/vision/dsp/AIC3254_REG.csv:system/etc/AIC3254_REG.csv \
    device/htc/vision/dsp/AIC3254_REG_XD.csv:system/etc/AIC3254_REG_XD.csv \
    device/htc/vision/dsp/AdieHWCodec.csv:system/etc/AdieHWCodec.csv \
    device/htc/vision/dsp/CodecDSPID.txt:system/etc/CodecDSPID.txt \
    device/htc/vision/dsp/HP_Audio.csv:system/etc/HP_Audio.csv \
    device/htc/vision/dsp/HP_Video.csv:system/etc/HP_Video.csv \
    device/htc/vision/dsp/SPK_Combination.csv:system/etc/SPK_Combination.csv \
    device/htc/vision/dsp/soundimage/Sound_Bass_Booster.txt:system/etc/soundimage/Sound_Bass_Booster.txt \
    device/htc/vision/dsp/soundimage/Sound_Blues.txt:system/etc/soundimage/Sound_Blues.txt \
    device/htc/vision/dsp/soundimage/Sound_Classical.txt:system/etc/soundimage/Sound_Classical.txt \
    device/htc/vision/dsp/soundimage/Sound_Country.txt:system/etc/soundimage/Sound_Country.txt \
    device/htc/vision/dsp/soundimage/Sound_Dolby_A_HP.txt:system/etc/soundimage/Sound_Dolby_A_HP.txt \
    device/htc/vision/dsp/soundimage/Sound_Dolby_A_SPK.txt:system/etc/soundimage/Sound_Dolby_A_SPK.txt \
    device/htc/vision/dsp/soundimage/Sound_Dolby_V_HP.txt:system/etc/soundimage/Sound_Dolby_V_HP.txt \
    device/htc/vision/dsp/soundimage/Sound_Dolby_V_SPK.txt:system/etc/soundimage/Sound_Dolby_V_SPK.txt \
    device/htc/vision/dsp/soundimage/Sound_Dualmic.txt:system/etc/soundimage/Sound_Dualmic.txt \
    device/htc/vision/dsp/soundimage/Sound_Dualmic_EP.txt:system/etc/soundimage/Sound_Dualmic_EP.txt \
    device/htc/vision/dsp/soundimage/Sound_Dualmic_SPK.txt:system/etc/soundimage/Sound_Dualmic_SPK.txt \
    device/htc/vision/dsp/soundimage/Sound_Jazz.txt:system/etc/soundimage/Sound_Jazz.txt \
    device/htc/vision/dsp/soundimage/Sound_Latin.txt:system/etc/soundimage/Sound_Latin.txt \
    device/htc/vision/dsp/soundimage/Sound_New_Age.txt:system/etc/soundimage/Sound_New_Age.txt \
    device/htc/vision/dsp/soundimage/Sound_Original.txt:system/etc/soundimage/Sound_Original.txt \
    device/htc/vision/dsp/soundimage/Sound_Original_SPK.txt:system/etc/soundimage/Sound_Original_SPK.txt \
    device/htc/vision/dsp/soundimage/Sound_Piano.txt:system/etc/soundimage/Sound_Piano.txt \
    device/htc/vision/dsp/soundimage/Sound_Pop.txt:system/etc/soundimage/Sound_Pop.txt \
    device/htc/vision/dsp/soundimage/Sound_R_B.txt:system/etc/soundimage/Sound_R_B.txt \
    device/htc/vision/dsp/soundimage/Sound_Rock.txt:system/etc/soundimage/Sound_Rock.txt \
    device/htc/vision/dsp/soundimage/Sound_SRS_A_HP.txt:system/etc/soundimage/Sound_SRS_A_HP.txt \
    device/htc/vision/dsp/soundimage/Sound_SRS_A_SPK.txt:system/etc/soundimage/Sound_SRS_A_SPK.txt \
    device/htc/vision/dsp/soundimage/Sound_SRS_V_HP.txt:system/etc/soundimage/Sound_SRS_V_HP.txt \
    device/htc/vision/dsp/soundimage/Sound_SRS_V_SPK.txt:system/etc/soundimage/Sound_SRS_V_SPK.txt \
    device/htc/vision/dsp/soundimage/Sound_Treble_Booster.txt:system/etc/soundimage/Sound_Treble_Booster.txt \
    device/htc/vision/dsp/soundimage/Sound_Vocal_Booster.txt:system/etc/soundimage/Sound_Vocal_Booster.txt

# Additional NAM Audio DSP Profiles to NAM Package
PRODUCT_COPY_FILES += \
    device/htc/vision/nam/default.acdb:system/etc/nam/default.acdb \
    device/htc/vision/nam/default_org.acdb:system/etc/nam/default_org.acdb \
    device/htc/vision/nam/AdieHWCodec.csv:system/etc/nam/AdieHWCodec.csv \
    device/htc/vision/nam/AIC3254_REG_DualMic_MCLK.csv:system/etc/nam/AIC3254_REG_DualMic_MCLK.csv \
    device/htc/vision/nam/CodecDSPID_MCLK.txt:system/etc/nam/CodecDSPID_MCLK.txt \
    device/htc/vision/nam/Sound_Treble_Booster_MCLK.txt:system/etc/nam/Sound_Treble_Booster_MCLK.txt \
    device/htc/vision/nam/Sound_Vocal_Booster_MCLK.txt:system/etc/nam/Sound_Vocal_Booster_MCLK.txt \
    device/htc/vision/nam/Sound_SRS_A_SPK_MCLK.txt:system/etc/nam/Sound_SRS_A_SPK_MCLK.txt \
    device/htc/vision/nam/Sound_SRS_V_HP_MCLK.txt:system/etc/nam/Sound_SRS_V_HP_MCLK.txt \
    device/htc/vision/nam/Sound_SRS_V_SPK_MCLK.txt:system/etc/nam/Sound_SRS_V_SPK_MCLK.txt \
    device/htc/vision/nam/Sound_Jazz_MCLK.txt:system/etc/nam/Sound_Jazz_MCLK.txt \
    device/htc/vision/nam/Sound_Latin_MCLK.txt:system/etc/nam/Sound_Latin_MCLK.txt \
    device/htc/vision/nam/Sound_New_Age_MCLK.txt:system/etc/nam/Sound_New_Age_MCLK.txt \
    device/htc/vision/nam/Sound_Original_MCLK.txt:system/etc/nam/Sound_Original_MCLK.txt \
    device/htc/vision/nam/Sound_Piano_MCLK.txt:system/etc/nam/Sound_Piano_MCLK.txt \
    device/htc/vision/nam/Sound_Pop_MCLK.txt:system/etc/nam/Sound_Pop_MCLK.txt \
    device/htc/vision/nam/Sound_R_B_MCLK.txt:system/etc/nam/Sound_R_B_MCLK.txt \
    device/htc/vision/nam/Sound_Rock_MCLK.txt:system/etc/nam/Sound_Rock_MCLK.txt \
    device/htc/vision/nam/Sound_SRS_A_HP_MCLK.txt:system/etc/nam/Sound_SRS_A_HP_MCLK.txt \
    device/htc/vision/nam/Sound_Dualmic_SPK_MCLK.txt:system/etc/nam/Sound_Dualmic_SPK_MCLK.txt \
    device/htc/vision/nam/Sound_Dualmic_EP_MCLK.txt:system/etc/nam/Sound_Dualmic_EP_MCLK.txt \
    device/htc/vision/nam/Sound_Dualmic_MCLK.txt:system/etc/nam/Sound_Dualmic_MCLK.txt \
    device/htc/vision/nam/Sound_Dolby_A_SPK_MCLK.txt:system/etc/nam/Sound_Dolby_A_SPK_MCLK.txt \
    device/htc/vision/nam/Sound_Dolby_HP_MCLK.txt:system/etc/nam/Sound_Dolby_HP_MCLK.txt \
    device/htc/vision/nam/Sound_Dolby_Spk_MCLK.txt:system/etc/nam/Sound_Dolby_Spk_MCLK.txt \
    device/htc/vision/nam/Sound_Dolby_V_HP_MCLK.txt:system/etc/nam/Sound_Dolby_V_HP_MCLK.txt \
    device/htc/vision/nam/Sound_Dolby_V_SPK_MCLK.txt:system/etc/nam/Sound_Dolby_V_SPK_MCLK.txt \
    device/htc/vision/nam/Sound_Dolby_A_HP_MCLK.txt:system/etc/nam/Sound_Dolby_A_HP_MCLK.txt \
    device/htc/vision/nam/Sound_Bass_Booster_MCLK.txt:system/etc/nam/Sound_Bass_Booster_MCLK.txt \
    device/htc/vision/nam/Sound_Blues_MCLK.txt:system/etc/nam/Sound_Blues_MCLK.txt \
    device/htc/vision/nam/Sound_Classical_MCLK.txt:system/etc/nam/Sound_Classical_MCLK.txt \
    device/htc/vision/nam/Sound_Country_MCLK.txt:system/etc/nam/Sound_Country_MCLK.txt

# Alternate NAM gps.conf to NAM package
PRODUCT_COPY_FILES += device/common/gps/gps.conf_US:system/etc/nam/gps.conf

PRODUCT_COPY_FILES += \
    device/htc/vision/vold.fstab:system/etc/vold.fstab

PRODUCT_COPY_FILES += \
    vendor/htc/vision/proprietary/libcamera.so:obj/lib/libcamera.so

# Kernel modules
#PRODUCT_COPY_FILES += \

ifeq ($(TARGET_PREBUILT_KERNEL),)
LOCAL_KERNEL := device/htc/msm7x30-common/msm7230/kernel
else
LOCAL_KERNEL := $(TARGET_PREBUILT_KERNEL)
endif

PRODUCT_COPY_FILES += \
    $(LOCAL_KERNEL):kernel

PRODUCT_COPY_FILES += \
    device/htc/msm7x30-common/msm7230/bcm4329.ko:system/lib/modules/bcm4329.ko

# stuff common to all HTC phones
$(call inherit-product, device/htc/common/common.mk)

# common msm7x30 configs
$(call inherit-product, device/htc/msm7x30-common/msm7x30.mk)

# htc audio settings
$(call inherit-product, device/htc/vision/media_htcaudio.mk)

$(call inherit-product, frameworks/base/build/phone-hdpi-512-dalvik-heap.mk)

$(call inherit-product-if-exists, vendor/htc/vision/device-vendor.mk)
