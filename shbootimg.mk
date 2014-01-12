LOCAL_PATH := $(call my-dir)

INTERNAL_BOOTIMAGE_ARGS_ANDROID := \
	$(addprefix --second ,$(INSTALLED_2NDBOOTLOADER_TARGET)) \
	--kernel $(INSTALLED_KERNEL_TARGET) \
	--ramdisk $(INSTALLED_RAMDISK_TARGET_ANDROID)

INTERNAL_BOOTIMAGE_FILES_ANDROID := $(filter-out --%,$(INTERNAL_BOOTIMAGE_ARGS_ANDROID))

INTERNAL_BOOTIMAGE_ARGS := \
	$(addprefix --second ,$(INSTALLED_2NDBOOTLOADER_TARGET)) \
	--kernel $(INSTALLED_KERNEL_TARGET) \
	--ramdisk $(INSTALLED_RAMDISK_TARGET)

INTERNAL_BOOTIMAGE_FILES := $(filter-out --%,$(INTERNAL_BOOTIMAGE_ARGS))

BOARD_KERNEL_CMDLINE := $(strip $(BOARD_KERNEL_CMDLINE))
ifdef BOARD_KERNEL_CMDLINE
  INTERNAL_BOOTIMAGE_ARGS_COMMON += --cmdline "$(BOARD_KERNEL_CMDLINE)"
endif

BOARD_KERNEL_BASE := $(strip $(BOARD_KERNEL_BASE))
ifdef BOARD_KERNEL_BASE
  INTERNAL_BOOTIMAGE_ARGS_COMMON += --base $(BOARD_KERNEL_BASE)
endif

BOARD_KERNEL_PAGESIZE := $(strip $(BOARD_KERNEL_PAGESIZE))
ifdef BOARD_KERNEL_PAGESIZE
  INTERNAL_BOOTIMAGE_ARGS_COMMON += --pagesize $(BOARD_KERNEL_PAGESIZE)
endif

ifneq ($(BOARD_FORCE_RAMDISK_ADDRESS),)
  $(error BOARD_FORCE_RAMDISK_ADDRESS has been deprecated. Use BOARD_MKBOOTIMG_ARGS.)
endif

INSTALLED_BOOTIMAGE_TARGET := $(PRODUCT_OUT)/boot.img
INSTALLED_BOOTIMAGE_TARGET_ANDROID := $(PRODUCT_OUT)/android-boot.img

$(INSTALLED_BOOTIMAGE_TARGET_ANDROID): $(MKBOOTIMG) $(INTERNAL_BOOTIMAGE_FILES_ANDROID)
	$(call pretty,"Target boot image for Android: $@")
	$(hide) $(MKBOOTIMG) $(INTERNAL_BOOTIMAGE_ARGS_ANDROID) $(BOARD_MKBOOTIMG_ARGS) --output $@
	$(hide) $(call assert-max-image-size,$@,$(BOARD_BOOTIMAGE_PARTITION_SIZE),raw)
	@echo -e ${CL_CYN}"Made boot image for Android: $@"${CL_RST}

$(INSTALLED_BOOTIMAGE_TARGET): $(MKBOOTIMG) $(INTERNAL_BOOTIMAGE_FILES)
# boot partition for vision is too small, so get rid of adbd and its crypto dependency
	cd $(TARGET_UBUNTU_ROOT_OUT) && rm lib/arm-linux-gnueabihf/libcrypto.so.1.0.0 && rm sbin/adbd
	cd $(TARGET_UBUNTU_ROOT_OUT) && find . | cpio -o -H newc | gzip > $(INSTALLED_RAMDISK_TARGET)
	$(call pretty,"Target boot image for Ubuntu Touch with adbd removed from initrd: $@")
	$(hide) $(MKBOOTIMG) $(INTERNAL_BOOTIMAGE_ARGS) $(BOARD_MKBOOTIMG_ARGS) --output $@
	$(hide) $(call assert-max-image-size,$@,$(BOARD_BOOTIMAGE_PARTITION_SIZE),raw)
	@echo -e ${CL_CYN}"Made boot image for Ubuntu Touch: $@"${CL_RST}


# Recovery
$(INSTALLED_RECOVERYIMAGE_TARGET): $(MKBOOTIMG) \
		$(recovery_ramdisk) \
		$(recovery_kernel)
	@echo -e ${CL_CYN}"----- Making recovery image ------"${CL_RST}
	$(hide) $(MKBOOTIMG) $(INTERNAL_RECOVERYIMAGE_ARGS) $(BOARD_MKBOOTIMG_ARGS) --output $@
	$(hide) $(call assert-max-image-size,$@,$(BOARD_RECOVERYIMAGE_PARTITION_SIZE),raw)
	@echo -e ${CL_CYN}"Made recovery image: $@"${CL_RST}
