package com.example.gson

import android.content.ClipData
import android.content.ClipboardManager
import androidx.appcompat.app.AppCompatActivity
import android.os.Bundle
import android.widget.Toast
import androidx.recyclerview.widget.GridLayoutManager
import androidx.recyclerview.widget.RecyclerView
import com.google.gson.Gson
import okhttp3.*
import timber.log.Timber
import timber.log.Timber.Forest.plant
import java.io.IOException
import com.google.gson.JsonArray
import com.google.gson.JsonObject

interface CellClickListener{ fun onClick(data: String) }

data class Photo (
    val id: Long,
    val owner: String,
    val secret: String,
    val server: Int,
    val farm: Int,
    val title: String,
    val ispublic: Int,
    val isfriend: Int,
    val isfamily: Int
)

data class PhotoPage (
    val page: Int,
    val pages: Int,
    val perpage: Int,
    val total: Int,
    val photo: JsonArray
)

data class Wrapper (
    val photos: JsonObject,
    val stat: String
)

class MainActivity : AppCompatActivity(), CellClickListener {
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_main)

        plant(Timber.DebugTree())

        val rView : RecyclerView = findViewById(R.id.rView)
        rView.layoutManager = GridLayoutManager(this, 2)

        val url = "https://api.flickr.com/services/rest/?method=flickr.photos.search&api_key=ff49fcd4d4a08aa6aafb6ea3de826464&tags=cat&format=json&nojsoncallback=1"
        val okHttpClient = OkHttpClient()
        val request: Request = Request.Builder()
            .url(url)
            .build()

        okHttpClient.newCall(request).enqueue(object : Callback {
            override fun onFailure(call: Call, e: IOException) {}

            override fun onResponse(call: Call, response: Response) {
                val gson = Gson()

                val wrapped = gson.fromJson(response.body!!.string(), Wrapper::class.java)
                val page = gson.fromJson(wrapped.photos, PhotoPage::class.java)
                val photos = gson.fromJson(page.photo, Array<Photo>::class.java)

                val links = List(photos.size) { "https://farm${photos[it].farm}.staticflickr.com/${photos[it].server}/${photos[it].id}_${photos[it].secret}_z.jpg" }

                runOnUiThread { rView.adapter = RecyclerAdapter(this@MainActivity, links, this@MainActivity) }
            }
        })
    }
    override fun onClick(data: String) {
        val clipboardManager = getSystemService(CLIPBOARD_SERVICE) as ClipboardManager
        clipboardManager.setPrimaryClip(ClipData.newPlainText("Скопировано", data))
        Toast.makeText(this, "Ссылка скопирована", Toast.LENGTH_SHORT).show()
        Timber.i(data)
    }
}




