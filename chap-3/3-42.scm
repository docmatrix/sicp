; I'm guessing that it means that the withdraw calls could interleave as they
; are using the same serializer. Therefore not a safe change.

; INCORRECT. It's safe, just changes where serialization happens.
