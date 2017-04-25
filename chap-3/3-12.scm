(define (append! x y)
  (set-cdr! (last-pair x) y)
  x)

(define (last-pair x)
  (if (null? (cdr x))
      x
      (last-pair (cdr x))))

(define x (list 'a 'b))
(define y (list 'c 'd))
(define z (append x y))

(display z) (newline)
; (a b c d)

(display (cdr x)) (newline)
; (b)

(define w (append! x y))
(display w) (newline))
; (a b c d)

(display (cdr x)) (newline)
; (b c d)

; CORRECT. Not doing ascii box and pointers.

