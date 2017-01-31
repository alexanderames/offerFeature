package com.anagram

import spray.httpx.SprayJsonSupport
import spray.json.DefaultJsonProtocol

/**
  * @author Peter Johnston
  * @since January 15, 2017
  */
case class WordList(words: List[String])
case class AnagramList(anagrams: List[String])
case class AnagramStatus(isAnagramGroup: Boolean)

// Implicitly format our JSON conversions
object JsonFormatter extends DefaultJsonProtocol with SprayJsonSupport {
  implicit val wordListFormat = jsonFormat1(WordList)
  implicit val anagramsFormat = jsonFormat1(AnagramList)
  implicit val anagramStatusFormat = jsonFormat1(AnagramStatus)
}
