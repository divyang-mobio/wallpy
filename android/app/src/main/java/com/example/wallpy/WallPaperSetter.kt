package com.example.wallpy

import android.app.Service
import android.content.Context
import android.content.Intent
import android.os.Handler
import android.os.IBinder
import android.os.Looper
import android.util.Log
import android.widget.Toast
import java.util.*

class WallPaperSetter : Service() {
    var mContext: Context = this
    override fun onCreate() {
        super.onCreate()
        Timer().scheduleAtFixedRate(object : TimerTask() {
            override fun run() {
                toast()
                Log.d("hello", "hello string")
            }
        }, 0, 1000)
    }

    fun toast() {
        Handler(Looper.getMainLooper()).post {
            Toast.makeText(mContext, "Toast", Toast.LENGTH_SHORT).show()
        }
    }

    override fun onBind(intent: Intent): IBinder {
        throw UnsupportedOperationException("error")
    }
}