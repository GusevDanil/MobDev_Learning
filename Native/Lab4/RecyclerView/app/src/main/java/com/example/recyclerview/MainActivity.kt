package com.example.recyclerview

import androidx.appcompat.app.AppCompatActivity
import android.os.Bundle
import android.widget.Toast
import androidx.recyclerview.widget.LinearLayoutManager
import androidx.recyclerview.widget.RecyclerView

interface CellClickListener{
    fun onCellClickListener(data: ColorData)
}

data class ColorData(val colorName: String,
                     val colorHex: Int)

class MainActivity : AppCompatActivity(), CellClickListener {

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)

        setContentView(R.layout.activity_main)

        val white = ColorData("WHITE", getColor(R.color.white))
        val black = ColorData("BLACK", getColor(R.color.black))
        val green = ColorData("GREEN", getColor(R.color.green))
        val red = ColorData("RED", getColor(R.color.red))
        val purple = ColorData("PURPLE", getColor(R.color.purple))

        val recyclerView: RecyclerView = findViewById(R.id.rView)

        recyclerView.layoutManager = LinearLayoutManager(this)

        recyclerView.adapter = MyRecyclerAdapter(this,
            arrayListOf(white, black, green, red, purple),
            this)
    }

    override fun onCellClickListener(data: ColorData) {
        Toast.makeText(this, "IT'S " + data.colorName, Toast.LENGTH_SHORT).show()
    }
}




