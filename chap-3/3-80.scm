
(define (RLC1 R L C dt)
  (lambda (vc0 il0)
    (define vc (integral (delay dvc) vc0 dt))
    (define dvc (scale-stream il (/ -1 C)))
    (define il (integral (delay dil) il0 dt))
    (define dil (add-streams (scale-stream vc (/ 1 L))
                             (scale-stream il (/ (* -1 R) L))))
    (cons-stream vc il)))

(define (RLC R L C dt)
  (lambda (vc0 il0)
    (define vc (integral (delay (scale-stream il (/ -1 C))) vc0 dt))
    (define il (integral (delay dil) il0 dt))
    (define dil (add-streams (scale-stream vc (/ 1 L))
                             (scale-stream il (/ (* -1 R) L))))
    (cons vc il)))


(define circuit (RLC 1 0.2 1 0.1))
(define instance (circuit 0 10))
(define vc (car instance))
(define il (cdr instance))

(show-stream vc 5)
(show-stream il 5)

(show-stream (circuit 0 10) 10)

;  CORRECT
