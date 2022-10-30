package com.example.mydialer

import androidx.recyclerview.widget.DiffUtil
import com.example.mydialer.data.Contact

class ContactDiffCallback :
    DiffUtil.ItemCallback<Contact>() {

    override fun areItemsTheSame(oldItem: Contact,
                                 newItem: Contact) :
            Boolean { return oldItem === newItem }

    override fun areContentsTheSame(oldItem: Contact,
                                    newItem: Contact) :
            Boolean { return oldItem == newItem }
}