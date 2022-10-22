package com.example.recyclerview

import android.content.Context
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import android.widget.TextView
import androidx.recyclerview.widget.RecyclerView

class MyRecyclerAdapter(private val context: Context,
                        private val colors: ArrayList<ColorData>,
                        private val cellClickListener: CellClickListener) :
    RecyclerView.Adapter<MyRecyclerAdapter.MyViewHolder>() {

    class MyViewHolder(itemView: View) : RecyclerView.ViewHolder(itemView) {
        val colorImg: View = itemView.findViewById(R.id.colorView)
        val colorName: TextView = itemView.findViewById(R.id.colorText)
    }

    override fun onCreateViewHolder(parent: ViewGroup, viewType: Int): MyViewHolder {
        val itemView = LayoutInflater.from(context)
            .inflate(R.layout.rview_item, parent, false)
        return MyViewHolder(itemView)
    }

    override fun onBindViewHolder(holder: MyViewHolder, position: Int) {
        holder.itemView.setOnClickListener {
            cellClickListener.onCellClickListener(data = colors[position])
        }
            holder.colorImg.setBackgroundColor(colors[position].colorHex)
            holder.colorName.text = colors[position].colorName
    }

    override fun getItemCount() = colors.size
}