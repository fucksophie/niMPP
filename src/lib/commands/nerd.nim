import ../util, ws
import std/[asyncdispatch, json]

proc handleNerd*(packet: JsonNode, ws: Websocket) {.async.} =
  await ws.send(serializeMPP(%*{
    "m":"a",
    "message": "This bot is written in Nim. I haven't seen anybody else make a bot in nim, so I decided to take the challange. It's been really fun so far."
  }))