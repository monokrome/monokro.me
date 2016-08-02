package me.monokro

import akka.actor.Actor
import spray.routing._
import spray.http._
import MediaTypes._


trait Service extends HttpService {
  val routes =
    path("") {
      get {
        respondWithMediaType(`text/html`) {
          complete {
            <html><body><h1>Hello, Bailey!</h1></body></html>
          }
        }
      }
    }
}


class ServiceActor extends Actor with Service {
  def actorRefFactory = context
  def receive = runRoute(routes)
}

