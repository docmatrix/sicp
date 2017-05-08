; memo-fib definition is in global scope which returns a lambda with a table and f bound to
; the lambda implementation of fib
; Upon calling memo-fib 3:
; E1 n = 3 and will call
;  E2 memo-fib 2 -> will call
;   E3 memo-fib 1 -> return 1, cache result
;   E4 memo-fib 0 -> return 0, cache result
;  E3 memo-fib 1 -> Will call
;   E5 -> return cached result (1)
;  E3 memo 1
;   E6 -> return cached result (1)
; In this way, it never has to recurse exponentially as each value is only computed once
;
; (memoize fib) will not work, as fib doesn't called the memoized version, and so unless you
; call the memoized version with the same number as a previous call you won't be getting any
; savings in the recursion.

