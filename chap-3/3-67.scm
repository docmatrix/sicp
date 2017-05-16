(load "streams.scm")

(define (pairs s t)
  (cons-stream
   (list (stream-car s) (stream-car t))
   (interleave
    (stream-map (lambda (x)
		  (list (stream-car s) x))
		(stream-cdr t))
    (interleave
     (stream-map (lambda (x)
		   (list x (stream-car t)))
		 (stream-cdr s))
     (pairs (stream-cdr s) (stream-cdr t))))))

(show-stream (pairs integers integers) 20)

; CORRECT. I was going to do this but couldn't reverse the stream, ended up looking at an answer.
; Correct intuition at least.
