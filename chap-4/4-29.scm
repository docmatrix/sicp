; Any procedure with a massive computation will run much more slowly. A large factorial or
; fibonnaci for example. I'm not going to explicitly write it.

(define (square x) (* x x))

;;; L-Eval input:
(square (id 10))

;;; L-Eval value:
100

;;; L-Eval input:
count

;;; L-Eval value:
1

; If no memoization count would evaluate to 2, as it would ge thunk'd twice

; CORRECT
