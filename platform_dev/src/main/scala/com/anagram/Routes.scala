package com.anagram

import akka.actor.Actor
import com.anagram.JsonFormatter._
import com.anagram.services.{AnagramServiceImpl, WordServiceImpl}
import spray.http.StatusCodes
import spray.routing
import spray.routing.{HttpService, RouteConcatenation}


/**
  * [[RouteActor]] will actually handle running each received end point using predefined routes included in
  * the [[Route]] trait it extends.
  *
  * @author Peter Johnston
  * @since January 15, 2017
  */
class RouteActor extends Actor with Route {

  // the HttpService trait defines only one abstract member, which
  // connects the services environment to the enclosing actor or test
  implicit def actorRefFactory = context

  // this actor only runs our route, but you could add
  // other things here, like request stream processing
  // or timeout handling
  def receive = runRoute(routes)
}

/**
  * This trait is a collection of all our routes, to be included with our actual route running actor
  */
trait Route extends RouteConcatenation with AnagramRoutes with WordRoutes {
  val routes = anagramRoutes ~ wordRoutes
}

/**
  * Any route related to anagrams on our api
  */
trait AnagramRoutes extends HttpService {
  // Instance of our service
  private val anagramService = new AnagramServiceImpl

  /**
    * Returns a JSON of all the anagrams for the given word. This does not include the actual word in the results.
    * This will also only return results if the given word is in the data store.
    *
    * Also uses a query parameter "limit" to set a max limit to the resulting list
    *
    * ex /anagrams/read.json?limit=1 returns 1 anagram of read in the data store
    */
  private val getAnagramsOfWord: routing.Route = pathPrefix("anagrams") {
    (path(Segment) & get) { segment =>
      parameterMap { params =>
        if (segment.contains(".json")) {
          val word = segment.split(".json").head // Head safe after length check
          val limitStr = params.get("limit")
          if (limitStr.isDefined) {
            try {
              // Limit query param provided
              val limitOpt = Some(limitStr.get.toInt)
              complete(anagramService.findAnagramForWord(word, limitOpt))
            } catch {
              case nfe: NumberFormatException =>
                complete(StatusCodes.BadRequest,
                         "Invalid Limit parameter given, must be number")
            }
          } else
            complete(anagramService.findAnagramForWord(word)) // No limit param given
        } else {
          // Format of request url doesnt contain .json
          complete(StatusCodes.NotFound)
        }
      }
    }
  }

  /**
    * Deletes the given word and all anagrams of that word
    */
  private val deleteAnagramsOfWordRoute: routing.Route =
    (path("anagrams" / Segment) & delete) { segment =>
      complete {
        if (segment.contains(".json")) {
          val word = segment.split(".json").head // Head safe after length check
          anagramService.removeAllAnagramsForWord(word)
          StatusCodes.OK // Delete all anagrams
        } else {
          StatusCodes.NotFound
        }
      }
    }

  /**
    * Finds all anagram groups of the given size
    *
    * ex: /anagrams/groups/size/10 returns all anagram groups containing 10 words
    */
  private val getAnagramsOfGroupSizeRoute: routing.Route =
    (path("anagrams" / "groups" / "size" / IntNumber) & get) { number =>
      complete {
        anagramService.findAnagramsByGroupSize(number)
      }
    }

  /**
    * Returns a [[AnagramStatus]] on if the given words in the get request are anagrams of each other.
    * Words are parsed as a query param named words in a comma delimited list
    *
    * ex: /anagrams/groups/isGroup?words=foo,oof will return true
    *
    * Note: This does not involve the data store and ensuring the words exist in it
    */
  private val getWordSetForAnagramCheckRoute: routing.Route =
    (path("anagrams" / "groups" / "isGroup") & get) {
      parameterMap { params =>
        val words = params.get("words")
        words match {
          case None =>
            complete(AnagramStatus(false)) // No words provided in params, so automatically false
          case Some(wordsParam) =>
            val wordList = wordsParam.split(",").toList
            complete(anagramService.checkIfAnagrams(wordList))
        }
      }
    }

  // Our public route definition
  val anagramRoutes =
    deleteAnagramsOfWordRoute ~
      getAnagramsOfWord ~
      getAnagramsOfGroupSizeRoute ~
      getWordSetForAnagramCheckRoute
}

/**
  * Any route related to words on our api
  */
trait WordRoutes extends HttpService {

  private val wordService = new WordServiceImpl

  /**
    * Delete a single word from the data store. The word to be deleted is parsed from the url
    * from the format /words/blah.json where blah would be the word deleted
    */
  private val deleteWordRoute: routing.Route =
    (path("words" / Segment) & delete) { segment =>
      complete {
        if (segment.contains(".json")) {
          val word = segment.split(".json").head // Head safe after length check
          wordService.removeSingleWordFromDataStore(word)
          StatusCodes.OK // Delete all words
        } else {
          StatusCodes.NotFound
        }
      }
    }

  /**
    * Removes all words from the data store
    */
  private val deleteWordsRoute: routing.Route =
    (path("words.json") & pathEnd & delete) {
      complete {
        if (wordService.removeAllWordsFromDataStore())
          StatusCodes.NoContent // Delete all words
        else StatusCodes.InternalServerError // Failure on the server side
      }
    }

  /**
    * Adds a new word to the data store from the json body
    */
  private val postWordRoute: routing.Route = path("words.json") {
    post {
      entity(as[WordList]) { wordList =>
        wordList.words.foreach(wordService.addWordToDataStore) // Add each word from the request
        complete(StatusCodes.Created) // Return status created
      }
    }
  }

  // Connect all our routes to our public definition
  val wordRoutes = deleteWordsRoute ~ postWordRoute ~ deleteWordRoute
}
