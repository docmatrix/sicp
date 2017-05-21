(define (random-in-range low high)
  (let ((range (- high low)))
        (+ low (/ (random (* 1000 (exact-round range))) 1000))))

(define (random-numbers-in-range low high)
  (define gen (lambda (x) (random-in-range low high)))
  (define random-numbers
    (cons-stream (random-in-range low high)
                 (stream-map gen random-numbers)))
  random-numbers)

(define (monte-carlo experiment-stream 
                     passed 
                     failed)
  (define (next passed failed)
    (cons-stream
     (/ passed (+ passed failed))
     (monte-carlo
      (stream-cdr experiment-stream) 
      passed 
      failed)))
  (if (stream-car experiment-stream)
      (next (+ passed 1) failed)
      (next passed (+ failed 1))))

(define (estimate-integral p x1 x2 y1 y2)
  (let ((xstream (random-numbers-in-range x1 x2))
        (ystream (random-numbers-in-range y1 y2)))
    (define test-stream
      (stream-map p xstream ystream))
    (monte-carlo test-stream 0 0)))

(define (p x y)
  (< (+ (expt (- x 5) 2)
        (expt (- y 7) 2))
     (expt 3 2)))

(define integrals (estimate-integral p 2.0 8.0 4.0 10.0))

(define pi
  (stream-map (lambda (x) (/ (* x 36.0) 9.0))
              integrals))
(stream-ref pi 10000)
(stream-ref pi 100000)

; CORRECT
