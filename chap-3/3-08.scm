(define f
  (let ((initial-value '()))
    (lambda (x)
      (if (eq? '() initial-value)
  	  (set! initial-value x))
      (if (= initial-value 0)
  	  0
	  x))))

; (display (+ (f 0) (f 1))) (newline)
(display (+ (f 1) (f 0))) (newline)

; CORRECT
