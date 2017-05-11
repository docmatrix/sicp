(define (make-semaphore n)
  (let ((running 0))
    (define (test-and-increment! running)
      (if (>= running n)
	  true
	  (begin
	    (set! running (+ running 1))
	    false)))
    (define (the-semaphore m)
      (cond ((eq? m 'acquire)
	     (if (test-and-increment! running)
		 (the-semaphore 'acquire))) ; retry
	    ((eq? m 'release) (set! (- n 1)))))
    the-semaphore))

; CORRECT. Mostly, I should have protected running with a mutex
