package com.anagram

import akka.actor.{ActorSystem, Props}
import akka.io.IO
import spray.can.Http
import akka.pattern.ask
import akka.util.Timeout
import com.anagram.services.BootStrapService

import scala.concurrent.duration._

/**
  * Boot runs the app on start, setting up system configurations and global values.
  *
  * Here we also build the initial "data-store", which in this case is a Map in memory. In
  * the future this could be replaced with a real database.
  *
  * One rule to note about this application is that it currently treats a capital letter as defining
  * a different word. For example, when asking for anagrams of read, Read could be returned if it
  * exists in the data store, even though these are technically the same word. This could be changed
  * if needed.
  */
object Boot extends App {

  // Bootstrap the application by setting up the data store
  BootStrapService.onStart()

  // we need an ActorSystem to host our application in
  implicit val system = ActorSystem("system")

  // create and start our service actor
  val service = system.actorOf(Props[RouteActor], "anagram-service")

  implicit val timeout = Timeout(5.seconds)
  // start a new HTTP server on port 3000 with our service actor as the handler
  IO(Http) ? Http.Bind(service, interface = "localhost", port = 3000)
}
