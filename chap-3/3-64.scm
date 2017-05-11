(define (stream-limit s tolerance)
  (let ((s1 (stream-car s))
	(s2 (stream-car (stream-cdr s))))
    (if (> (- s2 s1) tolerance)
	(stream-limit (stream-cdr s) tolerance)
	s2)))
; CORRECT. Could check for more nulls.
