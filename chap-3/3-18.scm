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
  (let ((seen '()))
    (define (inner list)
      (cond ((null? list) #f)
	    ((memq (cdr list) seen) #t)
	    (else
	     (begin
	       (set! seen (cons list seen))
	       (inner (cdr list))))))
    (inner x)))
