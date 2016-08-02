package me.monokro

import akka.actor.{ActorSystem, Props}
import akka.io.IO
import spray.can.Http
import akka.pattern.ask
import akka.util.Timeout
import scala.concurrent.duration._


object Main extends App {
  override def main(args : Array[String]) {
    implicit val system = ActorSystem("mk")
    implicit val timeout = Timeout(5.millis)
    val service = system.actorOf(Props[ServiceActor], "service")
    IO(Http) ? Http.Bind(service, interface="0.0.0.0", port = 9020)
  }
}
