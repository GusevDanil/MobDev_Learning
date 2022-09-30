package com.example.internettest

import androidx.appcompat.app.AppCompatActivity
import android.os.Bundle
import android.util.Log
import android.widget.Button
import okhttp3.OkHttpClient
import okhttp3.Request
import okhttp3.Callback
import okhttp3.Call
import okhttp3.Response
import java.io.IOException
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
            }.start()
        }

        val reqOkBut = findViewById<Button>(R.id.btnOkHTTP)
        reqOkBut.setOnClickListener { asyncRequest() }
    }

    private fun asyncRequest()  {
        val okHttpClient = OkHttpClient()
        val request: Request = Request.Builder().url(url).build()

        okHttpClient.newCall(request).enqueue(object : Callback {
            override fun onFailure(call: Call, e: IOException) {}
            override fun onResponse(call: Call, response: Response) {
                val data = response.body?.string().toString()
                Log.i("Flickr OkCats", data)
            }
        })
    }
}
