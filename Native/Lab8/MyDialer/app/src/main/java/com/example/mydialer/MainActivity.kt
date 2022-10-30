package com.example.mydialer

import android.content.Intent
import android.net.Uri
import androidx.appcompat.app.AppCompatActivity
import android.os.Bundle
import android.widget.EditText
import androidx.appcompat.widget.Toolbar
import androidx.core.widget.doAfterTextChanged
import androidx.core.widget.doOnTextChanged
import androidx.recyclerview.widget.LinearLayoutManager
import androidx.recyclerview.widget.RecyclerView
import com.example.mydialer.data.Contact
import com.google.gson.Gson
import okhttp3.*
import timber.log.Timber
import java.io.IOException

interface ContactClickListener { fun onClick(data: Contact) }

class MainActivity : AppCompatActivity(), ContactClickListener {
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_main)

        Timber.plant(Timber.DebugTree())

        findViewById<Toolbar>(R.id.toolbar)
            .apply { setSupportActionBar(this) }

        val searchField = findViewById<EditText>(R.id.et_search)
        val rView = findViewById<RecyclerView>(R.id.rView)
        val adapter = RecyclerAdapter(this)
        rView.adapter = adapter
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
                    adapter.submitList(contacts)
                    if (getSharedPreferences("APP_PREFERENCE", MODE_PRIVATE)
                            .contains("SEARCH_FILTER")) {
                        searchField
                            .setText(getPreferences(MODE_PRIVATE)
                                .getString("SEARCH_FILTER", "")
                            )
                        search(cachedCons, contacts, searchField.text.toString())
                        adapter.notifyDataSetChanged()
                    }
                    searchField
                        .doOnTextChanged {_, _, _, _ ->
                            search(cachedCons, contacts, searchField.text.toString())
                            adapter.notifyDataSetChanged()
                        }
                    searchField
                        .doAfterTextChanged {
                            getSharedPreferences("APP_PREFERENCE", MODE_PRIVATE)
                                .edit()
                                .putString("SEARCH_FILTER", searchField.text.toString())
                                .apply()
                        }
                }
            }
        })
    }
    fun search(cache : List<Contact>,
               data : MutableList<Contact>,
               inputText: String) {
        data.clear()
        if (inputText.isNotEmpty()) {
            data.addAll(cache.filter {
                    contact: Contact ->
                contact.toString()
                    .contains(inputText.trim(), true)
            })
        }
        else data.addAll(cache)
    }

    override fun onClick(data: Contact) {
        startActivity(
            Intent(Intent.ACTION_DIAL)
                .setData(
                    Uri.parse("tel:" + data.phone.trim())
                )
        )
    }
}
