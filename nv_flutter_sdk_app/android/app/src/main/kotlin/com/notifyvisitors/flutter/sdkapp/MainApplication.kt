package com.notifyvisitors.flutter.sdkapp

import android.app.Application
import android.util.Log
import com.flutter.notifyvisitors.NotifyvisitorsPlugin


class MainApplication : Application() {
    
    val nvBrandID: Int = BuildConfig.nvBrandID
    val nvSecreKey: String = BuildConfig.nvSecretKey

    
    override fun onCreate() {
        super.onCreate()
        
        Log.d("rn-nv-android", "nvBrandID = " + nvBrandID + " nvSecreKey = " + nvSecreKey)
        NotifyvisitorsPlugin.register(this, nvBrandID, nvSecreKey);
    
    }
}
