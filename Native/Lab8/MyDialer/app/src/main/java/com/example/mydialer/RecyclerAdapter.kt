package com.example.mydialer

import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import android.widget.TextView
import androidx.recyclerview.widget.ListAdapter
import androidx.recyclerview.widget.RecyclerView
import com.example.mydialer.data.Contact


class RecyclerAdapter(private val clickListener: ContactClickListener) :
    ListAdapter<Contact, RecyclerAdapter.MyViewHolder>(ContactDiffCallback()) {

        class MyViewHolder(itemView: View) : RecyclerView.ViewHolder(itemView) {
            val name : TextView = itemView.findViewById(R.id.textName)
            val phone : TextView = itemView.findViewById(R.id.textPhone)
            val type : TextView = itemView.findViewById(R.id.textType)

        }



    override fun onCreateViewHolder(parent: ViewGroup, viewType: Int): MyViewHolder {
        val itemView = LayoutInflater.from(parent.context).
                inflate(R.layout.rview_item, parent, false)
        return MyViewHolder(itemView)
    }

    override fun onBindViewHolder(holder: MyViewHolder, position: Int) {
        holder.itemView.setOnClickListener {
            clickListener.onClick(data = currentList[position])
        }
        holder.name.text = currentList[position].name
        holder.phone.text = currentList[position].phone
        holder.type.text = currentList[position].type
    }

}
