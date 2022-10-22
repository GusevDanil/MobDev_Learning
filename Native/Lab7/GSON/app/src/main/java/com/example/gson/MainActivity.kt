package com.example.gson


import android.app.Activity
import android.content.Intent
import android.net.Uri
import androidx.appcompat.app.AppCompatActivity
import android.os.Bundle
import androidx.recyclerview.widget.GridLayoutManager
import androidx.recyclerview.widget.RecyclerView
import com.google.android.material.snackbar.Snackbar
import com.google.gson.Gson
import okhttp3.*
import timber.log.Timber
import timber.log.Timber.Forest.plant
import java.io.IOException
import data.Photo
import data.PhotoPage
import data.Wrapper

interface CellClickListener{ fun onClick(data: String) }

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
        val intent = Intent(this, PicViewer::class.java)
        intent.putExtra("imgSrc", data)
        startActivityForResult(intent, 1)
    }

    override fun onActivityResult(requestCode: Int, resultCode: Int, data: Intent?) {
        super.onActivityResult(requestCode, resultCode, data)

        if (resultCode == Activity.RESULT_OK) {
            when (requestCode) {
                1 -> {
                    Snackbar
                        .make(
                            findViewById(R.id.mainLayout),
                            "Картинка добавлена в избраное",
                            Snackbar.LENGTH_SHORT
                        )
                        .setAction("Открыть") {
                            startActivity(
                                Intent(Intent.ACTION_VIEW)
                                    .setData(
                                        Uri.parse(data?.getStringExtra("favImgLink"))
                                    )
                            )
                        }
                        .show()
                }
            }
        }
    }
}




