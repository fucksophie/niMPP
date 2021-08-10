import ../config, ../useer, ../config, ../animations, ../util, ws
import std/[asyncdispatch, jsonutils, json]

proc hi*(packet: JsonNode, ws: Websocket) {.async.} =
  
  user = jsonTo(packet{"u"}, User)

  await ws.send(serializeMPP(%*{
    "m":"ch",
    "_id":"esm",
    "set": {
      "visible": "true",
    }
  }))

  await ws.send(serializeMPP(%*{
    "m":"userset",
    "set":{
      "name": "ｅｓｍ　流ドぞ",
      "color": "#ffb7c5"
    }
  }))

  proc text() {.async.} =
    while true:
      for loc in 0..sequence.len-1:
          await ws.send(serializeMPP(%*{
            "m":"userset",
            "set":{
              "name": sequence[loc],
            }
          }))

          await sleepAsync(800)

  proc color() {.async.} =
    while true:
      for loec in 0..colors.len-1:
        await ws.send(serializeMPP(%*{
          "m":"userset",
          "set":{
            "color": colors[loec]
          }
        }))          

        await sleepAsync(100)

  asyncCheck color()
  asyncCheck text()

  echo "Logged in!"