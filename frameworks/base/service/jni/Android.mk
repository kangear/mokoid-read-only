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

LOCAL_PATH:= $(call my-dir)
include $(CLEAR_VARS)

# [optional, user, eng] 
# eng = required
# optinal = no install on target
LOCAL_MODULE_TAGS := eng

# This is the target being built.
LOCAL_MODULE:= libmokoid_runtime

# Target install path.
LOCAL_MODULE_PATH := $(TARGET_OUT_SHARED_LIBRARIES)

# All of the source files that we will compile.
LOCAL_SRC_FILES:= \
	onload.cpp \
	com_mokoid_server_LedService.cpp

# All of the shared libraries we link against.
LOCAL_SHARED_LIBRARIES := \
	libandroid_runtime \
	libnativehelper \
	libcutils \
	libutils \
	libhardware

# No static libraries.
LOCAL_STATIC_LIBRARIES :=

# Also need the JNI headers.
LOCAL_C_INCLUDES += \
	$(JNI_H_INCLUDE) \
	vendor/mokoid/hardware/modules/include/

# No specia compiler flags.
LOCAL_CFLAGS +=

# Don't prelink this library.  For more efficient code, you may want
# to add this library to the prelink map and set this to true.
LOCAL_PRELINK_MODULE := false

include $(BUILD_SHARED_LIBRARY)
