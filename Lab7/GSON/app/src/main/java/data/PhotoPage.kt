package data

import com.google.gson.JsonArray

data class PhotoPage (
    val page: Int,
    val pages: Int,
    val perpage: Int,
    val total: Int,
    val photo: JsonArray
)
