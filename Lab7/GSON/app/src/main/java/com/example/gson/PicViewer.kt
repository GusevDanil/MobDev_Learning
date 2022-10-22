package com.example.gson

import android.content.Intent
import androidx.appcompat.app.AppCompatActivity
import android.os.Bundle
import android.view.Menu
import android.view.MenuItem
import android.widget.ImageView
import androidx.appcompat.widget.Toolbar
import com.bumptech.glide.Glide

class PicViewer : AppCompatActivity() {

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)

        setContentView(R.layout.pic_viewer)
        findViewById<Toolbar>(R.id.toolbar)
            .apply { setSupportActionBar(this) }

        val img = findViewById<ImageView>(R.id.imageView)
        Glide
            .with(this)
            .load(intent.getStringExtra("imgSrc"))
            .into(img)
    }

    override fun onCreateOptionsMenu(menu: Menu?): Boolean {
        menuInflater
            .inflate(R.menu.toolbar_menu, menu)
        return true
    }

    override fun onOptionsItemSelected(item: MenuItem): Boolean {
        val backIntent = Intent(this, MainActivity::class.java)
        backIntent
            .putExtra("favImgLink", intent.getStringExtra("imgSrc"))
        setResult(RESULT_OK, backIntent)
        finish()
        return true
    }
}