package com.example.nestedlayouts

import androidx.appcompat.app.AppCompatActivity
import android.os.Bundle
import android.widget.Button
import android.widget.TextView

class MainActivity : AppCompatActivity() {


    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_main)

        val btn = findViewById<Button>(R.id.button)

        val linHorTW1 = findViewById<TextView>(R.id.linHorTW1)
        val linHorTW2 = findViewById<TextView>(R.id.linHorTW2)
        val linHorTW3 = findViewById<TextView>(R.id.linHorTW3)

        val linVerTW1 = findViewById<TextView>(R.id.linVerTW1)
        val linVerTW2 = findViewById<TextView>(R.id.linVerTW2)
        val linVerTW3 = findViewById<TextView>(R.id.linVerTW3)

        val conTW1 = findViewById<TextView>(R.id.conTW1)
        val conTW2 = findViewById<TextView>(R.id.conTW2)
        val conTW3 = findViewById<TextView>(R.id.conTW3)

        fun changeText(elems: Array<TextView>, value: String) { for (elem in elems) elem.text = value }

        var num = 1
        btn.setOnClickListener {
            num += 1
            when (num % 3) {
                1 % 3 -> {
                    changeText(arrayOf(linHorTW3, linVerTW3, conTW3), "")
                    changeText(arrayOf(linHorTW1,linVerTW1,conTW1), num.toString())
                }
                2 % 3 -> {
                    changeText(arrayOf(linHorTW1, linVerTW1, conTW1), "")
                    changeText(arrayOf(linHorTW2, linVerTW2, conTW2), num.toString())
                }
                3 % 3 -> {
                    changeText(arrayOf(linHorTW2, linVerTW2, conTW2), "")
                    changeText(arrayOf(linHorTW3, linVerTW3, conTW3), num.toString())
                }
            }
        }
    }
}