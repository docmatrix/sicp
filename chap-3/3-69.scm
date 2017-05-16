(define (triples s t u)
  (stream-map (lambda (x)
		(begin
		  (list (caar x) (cadar x) (cadr x))))
	      (pairs (pairs s t) u)))

(define (square x) (* x x))

(define pythags
  (stream-filter
   (lambda (triple)
     (begin
       (display (car triple)) (newline)
       (display (car (cdr triple))) (newline)
       (display (car (cdr (cdr triple)))) (newline)

       (eq? (+ (square (car triple))
	       (square (car (cdr triple))))
	    (square (car (cdr (cdr triple)))))))
   (triples integers integers integers)))

(show-stream (triples integers integers integers) 20)
(show-stream (pythags) 1)

; INCORRECT. This doesn't produce the right combinations and throws pythag into infinite loop.
