import std/[json, jsonutils]

type User* = object
    name*, color*, id*: string

proc getJName*(name: string): string {.inline.} = 
  case name
  of "id": "_id"
  else: name
  
proc fromJsonHook*(u: var User, jsonNode: JsonNode) =
  for name, field in u.fieldPairs:
    field.fromJson(jsonNode[name.getJName()])
      
proc toJsonHook*(u: User): JsonNode =
  result = newJObject()
  for name, field in u.fieldPairs:   
    result[name.getJName()] = field.toJson