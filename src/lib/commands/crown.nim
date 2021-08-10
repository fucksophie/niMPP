import ../config, ../util, ws
import std/[asyncdispatch, json]

proc handleCrown*(packet: JsonNode, ws: Websocket) {.async.} =
   if config.crown:
      if packet{"p", "_id"}.getStr() == owner:
         await ws.send(serializeMPP(%*{
            "m":"chown",
            "id": owner
         }))

         await ws.send(serializeMPP(%*{
            "m":"a",
            "message": "Here you go :D"
         }))
      else:
         await ws.send(serializeMPP(%*{
            "m":"a",
            "message": "You're not the owner."
         }))
   else:
      await ws.send(serializeMPP(%*{
         "m":"a",
         "message": "I don't have the crown."
      }))