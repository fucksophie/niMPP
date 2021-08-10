import std/[asyncdispatch, json, strutils]
import ../commands/[crown, id, commands, nerd]

import ws except toSeq

proc a*(packet: JsonNode, ws: Websocket) {.async.} =
  let msg = packet{"a"}.getStr()
  var args = split(msg, " ")
  let command = args[0]

  args.delete(0)

  case command:
    of "/crown": await handleCrown(packet, ws)
    of "/_id": await handleId(packet, ws)
    of "/commands": await handleCommands(packet, ws)
    of "/help": await handleCommands(packet, ws)
    of "/nerd": await handleNerd(packet, ws)