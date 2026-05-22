package com.notifyvisitors.flutter.sdkapp

import android.app.Application
import android.util.Log
import com.flutter.notifyvisitors.NotifyvisitorsPlugin


class MainApplication : Application() {
    
    val nvBrandID: Int = BuildConfig.nvBrandID
    val nvSecreKey: String = BuildConfig.nvSecretKey

    
    override fun onCreate() {
        super.onCreate()
        
        Log.i("rn-nv-android", "nvBrandID = " + nvBrandID + " nvSecreKey = " + nvSecreKey)
        NotifyvisitorsPlugin.register(this, 7577, "DB52A5B00BB0D3BF426639A1B9FCF2F7");
    
    }
}
