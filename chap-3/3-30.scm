(define (ripple-carry-adder a b s c)
  (if (null? a)
      'ok
      (let ((next-c (make-wire)))
	(full-adder (car a) (car b) c (car s) next-c)
	(ripple-carry-adder (cdr a) (cdr b) (cdr s) next-c))))

; Each bit has to wait for the carry of the previous. Carry
; delay is sum of previous as the critial path. So n bits * (and + inverter + and)
; assuming that is longer than n bits * (or + and)
; CORRECT
