package com.example.complexevent

import androidx.appcompat.app.AppCompatActivity
import android.os.Bundle
import android.widget.*

class MainActivity : AppCompatActivity() {
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_main)

        val btn = findViewById<Button>(R.id.button)
        val input = findViewById<EditText>(R.id.textInput)
        val flag = findViewById<CheckBox>(R.id.flag)
        val saved = findViewById<TextView>(R.id.textSaved)
        val pBar = findViewById<ProgressBar>(R.id.progressBar)

        btn.setOnClickListener {
            pBar.incrementProgressBy(10)
            if (flag.isChecked) saved.text = input.text
        }
    }
}