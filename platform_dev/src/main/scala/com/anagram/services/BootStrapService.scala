package com.anagram.services

import java.io.InputStream

import scala.io.Source

/**
  * This service is called on start of the application to build the initial data store.
  *
  * @author Peter Johnston
  * @since January 27, 2017
  */
object BootStrapService {

  private val wordService = new WordServiceImpl

  /**
    * On the start of the application, this method will iterate over every word found in the applied
    * text file and add it to the data store in the appropriate fashion.
    *
    * Close the stream after work is done
    */
  def onStart(): Unit = {

    val stream: InputStream = getClass.getResourceAsStream("/dictionary.txt")
    val lines = Source.fromInputStream(stream).getLines
    for (line <- lines) {
      hashWord(line)
    }

    stream.close() // Close our file stream
  }

  private def hashWord(word: String): Unit = {
    wordService.addWordToDataStore(word)
  }
}
