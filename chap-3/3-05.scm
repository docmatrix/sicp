(define (square x) (* x x))
(define (random-in-range low high)
  (let ((range (- high low)))
        (+ low (random range))))

(define (monte-carlo trials experiment)
  (define (iter trials-remaining trials-passed)
    (cond ((= trials-remaining 0)
	   (/ trials-passed trials))
	  ((experiment)
	   (iter (- trials-remaining 1)
		 (+ trials-passed 1)))
	  (else
	   (iter (- trials-remaining 1)
		 trials-passed))))
  (iter trials 0))

(define (estimate-integral p x1 x2 y1 y2 trials)
  (define (test)
    (let ((x (random-in-range x1 x2))
	  (y (random-in-range y1 y2)))
      (p x y)))
  (monte-carlo trials test))

(define (p x y)
  (< (+ (expt (- x 5) 2)
	(expt (- y 7) 2))
     (expt 3 2)))
(define pi (/ (* (estimate-integral p 2.0 8.0 4.0 10.0 10000.0) 36.0) 9.0))
pi

; CORRECT. Needed a bit of tweaking, I was testing the rect area twice
