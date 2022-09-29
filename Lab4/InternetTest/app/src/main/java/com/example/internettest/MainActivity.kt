package com.example.internettest

import androidx.appcompat.app.AppCompatActivity
import android.os.Bundle
import android.util.Log
import android.widget.Button
import java.lang.Exception
import java.net.HttpURLConnection
import java.lang.Thread
import java.net.URL


class MainActivity : AppCompatActivity() {

    private val url = URL("https://inlnk.ru/agejnk")

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_main)

        val reqBut = findViewById<Button>(R.id.btnHTTP)
        reqBut.setOnClickListener {
            Thread {
                val con = url.openConnection() as HttpURLConnection
                try {
                    val data = con.inputStream.bufferedReader().readText()
                    Log.d("Flickr cats", data)
                }
                catch (e: Exception) { e.printStackTrace() }
                finally { con.disconnect() }
            }
        }
    }
}

