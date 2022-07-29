import ws
import std/[asyncdispatch, json, times, sequtils, strutils]

import lib/[config, useer, util]
import lib/events/[hi, p, a]

proc main() {.async.} = 
  var ws = await newWebSocket("wss://mppclone.com:8443")

  proc tSender() {.async.} =
    while true:
      await ws.send($(%*[{
        "m": "t",
        "e": getTime().toUnix()
      }]))
      await sleepAsync(20000)
    
  asyncCheck tSender()

  while ws.readyState == Open:
    let packet = parseJson(await ws.receiveStrPacket())[0]
    let id = packet{"m"}.getStr();

    case id:
      of "b":
        await ws.send(serializeMPP(%*{
          "m": "hi",
          "token": readFile("token.txt"),
        }))
      of "hi":
        await hi(packet, ws)
      of "ch":
        users = to(packet{"ppl"}, seq[User])
        crown = packet{"ch", "crown", "userId"}.getStr() == user.id

      of "p":
        await p(packet, ws)
      of "a":
        await a(packet, ws)
      of "bye":
          let db = filter(users, proc (u: User): bool = return u.id == packet{"p"}.getStr())[0]

          echo "Removing user " & packet{"p"}.getStr() & " from the DB. " & users.len.intToStr()

          users.keepIf(proc (u: User): bool = return u.id != packet{"p"}.getStr())

          echo "User removed, now " & users.len.intToStr() & " users! "

  ws.close()

when isMainModule:
  waitFor main()
