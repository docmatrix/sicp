(define (last-pair x)
  (if (null? (cdr x))
      x
      (last-pair (cdr x))))

(define (make-cycle x)
  (set-cdr! (last-pair x) x)
  x)

(define good-list '(a b c d))
(define bad-list (make-cycle '(a b c d)))

(define (contains-cycle? x)
  (define (list-contains? list el)
    (cond ((null? list)#f)
	  ((eq? (car list) el) #t)
	  (else (list-contains? (cdr list) el))))
  (let ((seen '()))
    (define (inner list)
      (display seen) (newline)
      (cond ((null? list) #f)
	    ((memq (cdr list) seen) #t)
					;((list-contains? seen (car list)) #t)
	    (else
	     (begin
	       (set! seen (cons list seen))
	       (inner (cdr list))))))
    (inner x)))

(define (contains-cycle-constant x)
  (define (previous-contains? list el)
    (let ((counter 0))
      (display counter) (newline)
      (display list) (newline)
      (display el) (newline)
      (if (null? list)
	  #f
	  (if (eq? list el)
	      (begin
		(set! counter (+ counter 1))
		(if (eq? counter 2)
		    #t
		    (previous-contains? (cdr list) el)))))))

  (define (check-element el)
    (if (null? el)
	#f
	(if (previous-contains? x el)
	    #t
	    (check-element (cdr el)))))
  (check-element x))
      
; FAIL. On the wrong path here after inspecting some solutions
