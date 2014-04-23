LOCAL_PATH := $(call my-dir)

include $(CLEAR_VARS)
LOCAL_MODULE := hcitool
LOCAL_SRC_FILES := hcitool.c
LOCAL_SRC_FILES += lib/bluetooth.c lib/hci.c lib/sdp.c
LOCAL_C_INCLUDES := $(KERNEL_HEADERS) $(LOCAL_PATH)/lib
LOCAL_MODULE_TAGS := optional
include $(BUILD_EXECUTABLE)

include $(CLEAR_VARS)
LOCAL_MODULE := hciconfig
LOCAL_SRC_FILES := hciconfig.c csr.c
LOCAL_SRC_FILES += lib/bluetooth.c lib/hci.c lib/sdp.c
LOCAL_C_INCLUDES := $(KERNEL_HEADERS) $(LOCAL_PATH)/lib
LOCAL_MODULE_TAGS := optional
include $(BUILD_EXECUTABLE)

include $(CLEAR_VARS)

LOCAL_MODULE := btmon
LOCAL_SRC_FILES := monitor/main.c monitor/mainloop.c \
		monitor/display.c  monitor/hcidump.c \
		monitor/btsnoop.c monitor/control.c \
		monitor/packet.c monitor/vendor.c \
		monitor/lmp.c  monitor/l2cap.c \
		monitor/uuid.c monitor/sdp.c \
		monitor/crc.c monitor/ll.c
LOCAL_SRC_FILES += lib/bluetooth.c lib/hci.c lib/sdp.c
LOCAL_CFLAGS += -DVERSION=\"5.10\"
LOCAL_C_INCLUDES := $(KERNEL_HEADERS) $(LOCAL_PATH)/lib
LOCAL_MODULE_TAGS := optional
include $(BUILD_EXECUTABLE)

include $(CLEAR_VARS)

LOCAL_MODULE := hciattach
LOCAL_SRC_FILES := hciattach.c hciattach.h \
		hciattach_st.c hciattach_ti.c \
		hciattach_tialt.c hciattach_ath3k.c \
		hciattach_qualcomm.c hciattach_intel.c
LOCAL_SRC_FILES += lib/bluetooth.c lib/hci.c lib/sdp.c
LOCAL_C_INCLUDES := $(KERNEL_HEADERS) $(LOCAL_PATH)/lib
LOCAL_MODULE_TAGS := optional
include $(BUILD_EXECUTABLE)

include $(CLEAR_VARS)

HCITOOLS_GPL_SRC_TARGET: $(HOST_OUT_EXECUTABLES)/pigz
	@echo "Copying hcitools source code to system/vendor/gpl"
	@mkdir -p $(TARGET_OUT)/vendor/gpl
	find external/bluetooth/hcitools | grep -v "\.git" | sort > $(TARGET_OUT)/../hcitools.files
	tar --exclude=".git" --no-recursion -S -T $(TARGET_OUT)/../hcitools.files --mtime="01/01/2014" -cf  $(TARGET_OUT)/vendor/gpl/hcitools.tar
	$(HOST_OUT_EXECUTABLES)/pigz -9 -f --no-time -R $(TARGET_OUT)/vendor/gpl/hcitools.tar

ALL_DEFAULT_INSTALLED_MODULES += HCITOOLS_GPL_SRC_TARGET
