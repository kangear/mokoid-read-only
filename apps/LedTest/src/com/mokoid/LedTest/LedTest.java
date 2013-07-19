/*
 * Copyright (C) 2009 Mokoid Open Source Project
 * Copyright (C) 2009,2010 Moko365 Inc.
 *
 * Author: Jollen Chen <jollen@moko365.com>
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


package com.mokoid.LedTest;
import mokoid.hardware.LedManager;
import com.mokoid.server.LedService;

import android.app.Activity;
import android.os.Bundle;
import android.util.Log;
import android.widget.TextView;
import android.widget.Button;
import android.content.Intent;
import android.view.View;

public class LedTest extends Activity implements View.OnClickListener {
    private LedManager mLedManager = null;

    @Override
    public void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);

        // Start LedService in a seperated process.
        startService(new Intent("com.mokoid.systemserver"));

        Button btn = new Button(this);
        btn.setText("Click to turn LED 1 On");
	btn.setOnClickListener(this);

        setContentView(btn);
    }

    public void onClick(View v) {

        // Get LedManager.
        if (mLedManager == null) {
	    Log.i("LedTest", "Creat a new LedManager object.");
	    mLedManager = new LedManager();
        }

        if (mLedManager != null) {
	    Log.i("LedTest", "Got LedManager object.");
	}

        /** Call methods in LedService via proxy object 
         * which is provided by LedManager. 
         */
        mLedManager.LedOn(1);

        TextView tv = new TextView(this);
        tv.setText("LED 1 is On.");
        setContentView(tv);
    }
}
