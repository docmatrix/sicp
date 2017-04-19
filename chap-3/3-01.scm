(define (make-accumulator value)
  (define (accumulate x)
    (begin
      (set! value (+ value x))
      value))
  (lambda (x) (accumulate x)))

; CORRECT
