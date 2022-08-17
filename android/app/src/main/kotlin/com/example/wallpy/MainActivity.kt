package com.example.wallpy

import android.content.Intent
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel

class MainActivity : FlutterActivity() {
    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        MethodChannel(
            flutterEngine.dartExecutor.binaryMessenger,
            "wallpyBackgroundService"
        ).setMethodCallHandler { call, result ->
            if (call.method == "StartService") {
                val intent = Intent(this, WallPaperSetter::class.java)
                startService(intent)
                result.success("start service")
            } else if (call.method == "StopService") {
                val intent = Intent(this, WallPaperSetter::class.java)
                stopService(intent)
                result.success("stop service")
            }
        }
    }
}
