; You're connecting the same 'connector' to two terminals.
; I think this will throw the system into an infinite loop, as
; the first terminal will propagate to the product.

; INCORRECT. I needed to consider the reverse propagation from the square to the
; original value. Both terminals are unset in this case so the multiplier can't
; 'unsquare' the result.
