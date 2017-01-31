package com.anagram.data

/**
  * This singleton object is used to mock a database using a mutable hashmap.
  * Adds and removes are synchronized to avoid race conditions.
  *
  * This class should be devoid of business logic and just add/remove/read from the map
  *
  * @author Peter Johnston
  * @since January 14, 2017
  */
object MockDB {

  /**
    * This var represents a mutable version of our data store, it will store a "hash" of sorts as the key.
    * The values are a list comprised of each words matching anagram.
    *
    * To convert this into a relational database, the "hash" key could be stored as a column, and each word
    * itself in a column.
    *
    * i.e.
    * Row 1 - Hash = ader Word = dear
    * Row 2 - Hash = ader Word = dare
    * Row 3 - Hash = deer Word = deer
    */
  private var ANAGRAMS =
    scala.collection.mutable.HashMap[String, List[String]]()

  def add(key: String, word: String): Unit = {
    val currentHashedWords = ANAGRAMS.getOrElse(key, List())
    val newList = word :: currentHashedWords
    synchronized { // We lock to update
      ANAGRAMS += (key -> newList)
    }
  }

  def findAll(): Iterable[List[String]] = {
    ANAGRAMS.values
  }

  def findByKey(key: String): Option[List[String]] = {
    ANAGRAMS.get(key)
  }

  def removeAll(): Unit = {
    ANAGRAMS = scala.collection.mutable.HashMap.empty
  }

  def removeOne(key: String, value: String): Boolean = {
    ANAGRAMS.get(key) match {
      case None => false // Do nothing, key doesnt exist
      case Some(wordList) =>
        ANAGRAMS.synchronized {
          ANAGRAMS += (key -> wordList.filterNot(_ == value))
        }
        true
    }
  }
}
