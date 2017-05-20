(define (smooth s)
  (define (do-smooth s last_value)
    (let ((avpt (/ (+ (stream-car s) last_value) 2)))
      (cons-stream avpt (do-smooth (stream-cdr s) (stream-car s)))
    ))
  (do-smooth s 0)
  )

(define (make-zero-crossings s)
  (stream-map sign-change-detector 
              s 
              (cons-stream 0 s)))

(define zero-crossings (make-zero-crossings (smooth sense-data)))

(show-stream  zero-crossings  15)

; CORRECT
