import ../config, ../useer, ../util, ws
import std/[asyncdispatch, jsonutils, json, sequtils, strutils]

proc p*(packet: JsonNode, ws: Websocket) {.async.} =
  if packet{"id"}.getStr() != user.id: 
    let db = filter(users, proc (u: User): bool = return u.id == packet{"id"}.getStr())

    if db.len > 0:
      await ws.send(serializeMPP(%*{
        "m":"a",
        "message": packet{"name"}.getStr() & " already exists in DB. Their previous name was " & db[0].name
      }))
    else:
      if crown:
        if packet{"tag"}.getStr() == "BOT":
          await ws.send(serializeMPP(%*{
            "m":"kickban",
            "_id": packet{"_id"}.getStr(),
            "ms": 3600000
          }))

          await ws.send(serializeMPP(%*{
            "m":"a",
            "message": packet{"name"}.getStr() & " eradicated. I don't want competition."
          }))

      echo "Adding user " & packet{"name"}.getStr() & " to the DB. " & users.len.intToStr()

      users.add(jsonTo(packet, User))

      echo "User added, now " & users.len.intToStr() & " users! "