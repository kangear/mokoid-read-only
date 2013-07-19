# Copyright (C) 2009 Mokoid Open Source Project
# Copyright (C) 2009,2010 Moko365 Inc.
#
# Author: Jollen Chen <jollen@moko365.com>
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


LOCAL_PATH := $(call my-dir)

# Goldfish LED
include $(CLEAR_VARS)

# Mokoid branch needs these headers
LOCAL_C_INCLUDES += \
	vendor/mokoid/hardware/modules/include/

# HAL module implemenation, not prelinked and stored in
# hw/<OVERLAY_HARDWARE_MODULE_ID>.<ro.product.board>.so
LOCAL_PRELINK_MODULE := false
LOCAL_MODULE_PATH := $(TARGET_OUT_SHARED_LIBRARIES)/hw
LOCAL_SHARED_LIBRARIES := liblog
LOCAL_SRC_FILES := led.goldfish.c
LOCAL_MODULE := led.goldfish
include $(BUILD_SHARED_LIBRARY)

# Mokoid LED
include $(CLEAR_VARS)

LOCAL_C_INCLUDES += \
	vendor/mokoid/hardware/modules/include/

LOCAL_PRELINK_MODULE := false
LOCAL_MODULE_PATH := $(TARGET_OUT_SHARED_LIBRARIES)/hw
LOCAL_SHARED_LIBRARIES := liblog
LOCAL_SRC_FILES := led.dma6410xp.c
LOCAL_MODULE := led.smdk6410
include $(BUILD_SHARED_LIBRARY)
