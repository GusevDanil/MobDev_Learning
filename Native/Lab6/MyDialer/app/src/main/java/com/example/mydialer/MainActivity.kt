package com.example.mydialer

import androidx.appcompat.app.AppCompatActivity
import android.os.Bundle
import android.widget.Button
import android.widget.EditText
import androidx.recyclerview.widget.LinearLayoutManager
import androidx.recyclerview.widget.RecyclerView
import com.example.mydialer.data.Contact
import com.google.gson.Gson
import okhttp3.*
import timber.log.Timber
import java.io.IOException


class MainActivity : AppCompatActivity() {
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_main)

        Timber.plant(Timber.DebugTree())

        val rView = findViewById<RecyclerView>(R.id.rView)
        val searchBut = findViewById<Button>(R.id.btn_search)
        val searchField = findViewById<EditText>(R.id.et_search)

        rView.layoutManager = LinearLayoutManager(this)

        val url = "https://drive.google.com/u/0/uc?id=1-KO-9GA3NzSgIc1dkAsNm8Dqw0fuPxcR&export=download"
        val okHttpClient = OkHttpClient()
        val request: Request = Request.Builder()
            .url(url)
            .build()

        okHttpClient.newCall(request).enqueue(object : Callback {
            override fun onFailure(call: Call, e: IOException) {}

            override fun onResponse(call: Call, response: Response) {
                val gson = Gson()
                val contacts = gson.fromJson(response.body?.string(), Array<Contact>::class.java)
                    .toMutableList()
                val cachedCons = contacts.toList()
                runOnUiThread {
                    val adapter = RecyclerAdapter(this@MainActivity, contacts)
                    rView.adapter = adapter
                    searchBut.setOnClickListener {
                        contacts.clear()
                        if (searchField.text.isEmpty()) contacts.addAll(cachedCons)
                        contacts.addAll(cachedCons.filter {
                                contact: Contact ->
                            contact.toString().lowercase().contains(searchField.text.toString().lowercase().trim())
                        })
                        adapter.notifyDataSetChanged()
                    }
                }
            }
        })
    }
}
