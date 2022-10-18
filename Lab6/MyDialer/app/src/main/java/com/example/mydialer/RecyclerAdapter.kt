package com.example.mydialer

import android.content.Context
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import android.widget.TextView
import androidx.recyclerview.widget.RecyclerView
import com.example.mydialer.data.Contact


class RecyclerAdapter(private val context: Context,
                      private val contacts: List<Contact>) :
    RecyclerView.Adapter<RecyclerAdapter.MyViewHolder>() {
        class MyViewHolder(itemView: View) : RecyclerView.ViewHolder(itemView) {
            val name: TextView = itemView.findViewById(R.id.textName)
            val phone: TextView = itemView.findViewById(R.id.textPhone)
            val type: TextView = itemView.findViewById(R.id.textType)
        }

    override fun onCreateViewHolder(parent: ViewGroup, viewType: Int): MyViewHolder {
        val itemView = LayoutInflater.from(context).
                inflate(R.layout.rview_item, parent, false)
        return MyViewHolder(itemView)
    }

    override fun onBindViewHolder(holder: MyViewHolder, position: Int) {
        holder.name.text = contacts[position].name
        holder.phone.text = contacts[position].phone
        holder.type.text = contacts[position].type
    }

    override fun getItemCount() = contacts.size
}
