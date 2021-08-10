import ../util, ws
import std/[asyncdispatch, json]

proc handleId*(packet: JsonNode, ws: Websocket) {.async.} =
  await ws.send(serializeMPP(%*{
    "m":"a",
    "message": "Your ID is " & packet{"p", "_id"}.getStr()
  }))