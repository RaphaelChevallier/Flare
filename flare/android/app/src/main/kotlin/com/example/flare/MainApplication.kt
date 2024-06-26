package com.example.flare

import android.app.Application
import io.radar.sdk.Radar

class MainApplication : Application() {
    override fun onCreate() {
        super.onCreate()
        val radarApiKey = BuildConfig.RADAR_PK
        // Initialize Radar SDK with your publishable API key
        Radar.initialize(this, radarApiKey)
    }
}