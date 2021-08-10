import json

proc serializeMPP*(node: JsonNode): string = 
  return $(%*[node])
