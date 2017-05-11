; All Louis has done is recreate the serialized version that was suggested
; a few exercises ago. This is fine in protecting the single resource of the
; account, but doesn't allow you to lock two resources by nesting their 
; serialzers and so the exchange paradigm will still fail.

; INCORRECT. The problem here is that there are multiple calls made using
; the same serializer which will result in a deadlock
