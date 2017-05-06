; In a tree based table you would represent the table as a tree of keys
; rather than a list of keys. In this way, instead of iterating across the list,
; you would compare the key to the node and recurse down the nodes until you either
; find the leaf (if looking up) or a missing key in which case you would insert the
; node into the tree. Multi dimensional tables can work in the same way, where the
; leaf node simply contains another tree-table

; CORRECT. The question asked for a description intead of an implementation.
