(define count 0)
(define (id x) (set! count (+ count 1)) x)

(define w (id (id 10)))

;;; L-Eval input:
count

;;; L-Eval value:
1

;;; L-Eval input:
w

;;; L-Eval value:
10

;;; L-Eval input:
count

;;; L-Eval value:
2


; CORRECT, though I had count at 0 to begin with. This isn't the case as the operand gets forced
; during the define as it is an application
