; c = (a + b) / 2
; a --|       |         |            |
;     | Adder | -- w -- | Mulitplier | - c
; b --|       |    x -- |            |
;                  | 
;                 0.5
;


(define (averager a b c)
  (let ((w (make-connector))
	(x (make-connector)))
    (adder a b w)
    (constant 0.5 x)
    (multiplier w x c)
    'ok))

; CORRECT
