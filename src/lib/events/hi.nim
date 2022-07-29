import ../config, ../useer, ../util, ws
import std/[asyncdispatch, jsonutils, json]

proc hi*(packet: JsonNode, ws: Websocket) {.async.} =
  
  user = jsonTo(packet{"u"}, User)

  await ws.send(serializeMPP(%*{
    "m":"ch",
    "_id":"✧𝓓𝓔𝓥 𝓡𝓸𝓸𝓶✧",
    "set": {
      "visible": "true",
    }
  }))
