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

$(call inherit-product, $(SRC_TARGET_DIR)/product/generic.mk)

PRODUCT_PACKAGES += \
	LedClient \
	LedTest

#
# System configurations.
#
PRODUCT_COPY_FILES += \
    vendor/mokoid/frameworks/base/service/com.mokoid.server.xml:system/etc/permissions/com.mokoid.server.xml

#
# Kernel modules.
#
PRODUCT_COPY_FILES += \
    vendor/mokoid/dma6410xp/led.ko:system/lib/modules/led.ko

#
# Initial scripts.
#
PRODUCT_COPY_FILES += \
    vendor/mokoid/dma6410xp/init.rc:root/init.rc \
    vendor/mokoid/dma6410xp/init.dma6410xp.rc:root/init.dma6410xp.rc

#
# Bundled applications.
#
PRODUCT_COPY_FILES += \
    vendor/mokoid/dma6410xp/bundle/ApiDemos.apk:system/app/ApiDemos.apk

# Overrides (see build.prop for results)
PRODUCT_NAME := dma6410xp
PRODUCT_DEVICE := dma6410xp
