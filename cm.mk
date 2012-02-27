$(call inherit-product, device/htc/vision/full_vision.mk)

PRODUCT_RELEASE_NAME := VISION 

# Inherit some common CM stuff.
$(call inherit-product, vendor/cm/config/common_full_phone.mk)

# Inherit some common CM stuff.
$(call inherit-product, vendor/cm/config/gsm.mk)

PRODUCT_BUILD_PROP_OVERRIDES += PRODUCT_NAME=htc_vision BUILD_ID=IML74K BUILD_FINGERPRINT=htc_wwe/htc_vision/vision:4.0.3/IML74K/87995:user/release-keys PRIVATE_BUILD_DESC="4.0.3 Andromadus release-keys"

PRODUCT_NAME := cm_vision
PRODUCT_DEVICE := vision
