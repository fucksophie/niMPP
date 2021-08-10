import ../util, ws
import std/[asyncdispatch, json]


# you can index /commands :D i thjink?

proc handleCommands*(packet: JsonNode, ws: Websocket) {.async.} =
  await ws.send(serializeMPP(%*{
    "m":"a",
    "message": "Current commands: crown, _id, commands, nerd"
  }))