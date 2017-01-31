package com.anagram.services

import com.anagram.data.MockDB
import com.anagram.utils.WordUtils
import com.anagram.{AnagramList, AnagramStatus}

/**
  * @author Peter Johnston
  * @since January 29, 2017
  */
trait AnagramService {

  /**
    * For the given word, return a List of all anagrams that exist inside the data store of words.
    * Also removes the original word from the result set, i.e. dare will not contain dare in the results.
    * This includes different capitalization in the word, i.e. dare will not contain Dare either.
    *
    * Note: First the word must be an actual word in the data store, i.e. searching for odg should not return
    * dog because odg is not a word in the store.
    *
    * If none are found, the result is an empty list.
    *
    * @param word The word being searched on for anagrams, i.e. words that exist that can be made with the same
    *             frequency of letters as in the original word.
    * @param maxResults An optional num representing the max number of results to return in the list.
    *                   If none, return all results
    * @return An [[AnagramList]] with the list filled with results
    */
  def findAnagramForWord(word: String,
                         maxResults: Option[Int] = None): AnagramList

  /**
    * Removes the given word, and every anagram of that word
    *
    * @param word The word to remove every anagram for
    */
  def removeAllAnagramsForWord(word: String): Unit

  /**
    * Find all anagram groups in the data store with the given size or greated.
    *
    * @param minSize The min size of the groups
    * @return A list of [[AnagramList]], as there can be multiple anagram groups of the same size
    */
  def findAnagramsByGroupSize(minSize: Int): List[AnagramList]

  /**
    * Check if all of the words in the given list are anagrams of each other.
    *
    * This will not access the data store.
    *
    * @param wordList The list of words
    * @return An [[AnagramStatus]] object containing a boolean if the words are anagrams (true) or not (false)
    */
  def checkIfAnagrams(wordList: List[String]): AnagramStatus

}

class AnagramServiceImpl extends AnagramService {
  override def findAnagramForWord(
      word: String,
      maxResults: Option[Int] = None): AnagramList = {
    val values = MockDB
      .findByKey(WordUtils.convertWordToHashable(word))
      .getOrElse(List())
    if (values.contains(word)) {
      val results = values.filterNot(_ == word)
      if (maxResults.isDefined) AnagramList(results.take(maxResults.get))
      else AnagramList(results)
    } else {
      AnagramList(List()) // No anagrams for a word that doesnt exist
    }

  }

  override def removeAllAnagramsForWord(word: String): Unit = {
    // Search on the hash
    MockDB.findByKey(WordUtils.convertWordToHashable(word)) match {
      case None =>
      // The word wasnt found so do nothing
      case Some(anagramsListAndWord) =>
        // IMPORTANT NOTE: This deletes all anagrams of a word only if that word exists so check for word first
        if (anagramsListAndWord.contains(word)) {
          // This list returned contains the word we searched for in the db
          // And all its anagrams, so remove each one
          // This could be done in one operation to save time
          anagramsListAndWord.foreach(each =>
            MockDB.removeOne(WordUtils.convertWordToHashable(each), each))
        }
    }
  }

  override def findAnagramsByGroupSize(minSize: Int): List[AnagramList] = {
    MockDB.findAll().foldLeft(List[AnagramList]()) { (list, wordGroup) =>
      if (wordGroup.size >= minSize) {
        AnagramList(wordGroup) :: list
      } else list
    }
  }

  override def checkIfAnagrams(wordList: List[String]): AnagramStatus = {
    if (wordList.isEmpty || wordList.size == 1) AnagramStatus(false)
    else {
      val sorted = wordList.map(WordUtils.convertWordToHashable)
      if (sorted.head == sorted.last) AnagramStatus(true)
      else AnagramStatus(false)
    }
  }
}
