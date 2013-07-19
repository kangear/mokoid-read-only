/*
 * Copyright (C) 2009 Mokoid Open Source Project
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *      http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

#define LOG_TAG "Mokoid"
#include "utils/Log.h"

#include <stdlib.h>
#include <string.h>
#include <unistd.h>
#include <assert.h>

#include <jni.h>
#include <mokoid/led.h>

// ----------------------------------------------------------------------------

struct led_control_device_t *sLedDevice = NULL;

static jboolean mokoid_setOn(JNIEnv* env, jobject thiz, jint led) 
{
    LOGI("LedService JNI: mokoid_setOn() is invoked.");

    if (sLedDevice == NULL) {
        LOGI("LedService JNI: sLedDevice was not fetched correctly.");
        return -1;
    } else {
        return sLedDevice->set_on(sLedDevice, led);
    }
}

static jboolean mokoid_setOff(JNIEnv* env, jobject thiz, jint led) 
{
    LOGI("LedService JNI: mokoid_setOff() is invoked.");


    if (sLedDevice == NULL) {
        LOGI("LedService JNI: sLedDevice was not fetched correctly.");
        return -1;
    } else {
        return sLedDevice->set_off(sLedDevice, led);
    }
}

/** helper APIs */
static inline int led_control_open(const struct hw_module_t* module,
        struct led_control_device_t** device) {
    return module->methods->open(module,
            LED_HARDWARE_MODULE_ID, (struct hw_device_t**)device);
}

static jboolean mokoid_init(JNIEnv *env, jclass clazz)
{
    led_module_t* module;

    if (hw_get_module(LED_HARDWARE_MODULE_ID, (const hw_module_t**)&module) == 0) {
        LOGI("LedService JNI: LED Stub found.");
        if (led_control_open(&module->common, &sLedDevice) == 0) {
    	    LOGI("LedService JNI: Got Stub operations.");
            return 0;
        }
    }

    LOGE("LedService JNI: Get Stub operations failed.");
    return -1;
}

// --------------------------------------------------------------------------

/*
 * Array of methods.
 *
 * Each entry has three fields: the name of the method, the method
 * signature, and a pointer to the native implementation.
 */
static const JNINativeMethod gMethods[] = {
    { "_init",	  	"()Z",	(void *)mokoid_init },
    { "_set_on",        "(I)Z", (void *)mokoid_setOn },
    { "_set_off",       "(I)Z", (void *)mokoid_setOff },
};

int register_mokoid_server_LedService(JNIEnv* env) {
    static const char* const kClassName =
        "com/mokoid/server/LedService";
    jclass clazz;

    /* look up the class */
    clazz = env->FindClass(kClassName);
    if (clazz == NULL) {
        LOGE("Can't find class %s\n", kClassName);
        return -1;
    }

    /* register all the methods */
    if (env->RegisterNatives(clazz, gMethods,
            sizeof(gMethods) / sizeof(gMethods[0])) != JNI_OK)
    {
        LOGE("Failed registering methods for %s\n", kClassName);
        return -1;
    }

    /* fill out the rest of the ID cache */
    return 0;
}
