package com.anagram.services

import com.anagram.utils.WordUtils
import com.anagram.data.MockDB

/**
  * @author Peter Johnston
  * @since January 29, 2017
  */
trait WordService {

  /**
    * Add a new word to the data store. This involves correctly "indexing" the word to partition it with relevant
    * anagrams
    *
    * @param word A string representation of a word given to add
    * @return The word that was successfully added to the data store
    */
  def addWordToDataStore(word: String): String

  /**
    * Removes all words from the data store.
    *
    * @return A boolean if the result was completed successfully
    */
  def removeAllWordsFromDataStore(): Boolean

  /**
    * Remove the given word from the data store if it exists, else do nothing
    *
    * @param word The word to remove
    * @return A boolean representing if a single word was removed or not
    */
  def removeSingleWordFromDataStore(word: String): Boolean

}

class WordServiceImpl extends WordService {

  override def addWordToDataStore(word: String): String = {
    val hash = WordUtils.convertWordToHashable(word)
    MockDB.findByKey(hash) match {
      case Some(existingWords) =>
        // When an existing word is entered, the addition is ignored
        // Initially this threw an exception, but some of the tests apply duplicate words
        if (!existingWords.contains(word)) MockDB.add(hash, word) // Add non dupes
      case None => MockDB.add(hash, word)
    }
    word
  }

  override def removeAllWordsFromDataStore(): Boolean = {
    try {
      MockDB.removeAll()
      true
    } catch {
      case _: Throwable =>
        false // Should log exception in a more defined application
    }
  }

  override def removeSingleWordFromDataStore(word: String): Boolean = {
    MockDB.removeOne(WordUtils.convertWordToHashable(word), word)
  }

}
