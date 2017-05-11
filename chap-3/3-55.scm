(load "streams.scm")

(define (add-streams s1 s2)
  (stream-map + s1 s2))

(define (partial-sum s)
  (cons-stream (stream-car s)
	       (add-streams (stream-cdr s)
			    (partial-sum s))))

(display (stream-car ones))(newline)
(display (partial-sums ones)) (newline)

; INCORRECT. Couldn't figure it out, and none of the other answers worked.
