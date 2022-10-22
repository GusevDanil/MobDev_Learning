package com.example.newactivity

import android.content.Intent
import androidx.appcompat.app.AppCompatActivity
import android.os.Bundle
import android.widget.Button
import android.widget.ImageView
import com.bumptech.glide.Glide

class MainActivity : AppCompatActivity() {
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_main)

        val jumpBut = findViewById<Button>(R.id.btn_show_pic)
        jumpBut.setOnClickListener{
            val intent = Intent(this, PicActivity::class.java)

            intent.putExtra("picLink",
                "https://cs11.pikabu.ru/images/big_size_comm/2019-09_6/156959272019333737.jpg")

            startActivity(intent)
        }
    }
}