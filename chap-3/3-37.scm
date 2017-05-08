(define (c- x y)
  (let ((z (make-connector)))
    (adder z y x) ; Setting x and y will result in z -> x - y
    z))

(define (c* x y)
  (let ((z (make-connector)))
    (multiplier x y z)
    z))

(define (c/ x y)
  (let ((z (make-connector)))
    (multiplier z y x) ; Setting x and y will result in z -> x / y
    z))

(define (cv x)
  (let ((z (make-connector)))
    (constant x z)
    z))

; CORRECT



