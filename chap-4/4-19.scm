; I like Eva's opinion, though it sounds quite difficult to implement. You would need to produce
; a dependency tree of references, or at the very least order the definitions in terms of simple / 
; symbolic definitions first followed by evaluated expressions. As described in the footnotes,
; the error raised by an unassigned 'a' variable is probably simpler and more explicit to the
; programmer, removing risk of 'magic' behaviour.

; CORRECT
