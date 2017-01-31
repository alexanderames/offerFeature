package com.anagram.utils


/**
  * @author Peter Johnston
  * @since January 30, 2017
  */
object WordUtils {

  /**
    * A common definition for the method of storing a word by a "hash".
    *
    * This hash is the lower cased sorted character version of the given string.
    *
    * @param word The word to be converted to a hash
    * @return The hash string
    */
  def convertWordToHashable(word: String): String = {
    word.trim.toLowerCase.sorted
  }

}
