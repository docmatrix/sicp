(load "streams.scm")

(define (square x) (* x x))

(define (ln-summands n)
  (cons-stream (/ 1.0 n)
	       (stream-map - (ln-summands (+ n 1)))))

(define ln-stream
  (partial-sum (ln-summands 1)))

(define (euler-transform s)
  (let ((s0 (stream-ref s 0))     ; Sₙ₋₁
	(s1 (stream-ref s 1))     ; Sₙ
	(s2 (stream-ref s 2)))    ; Sₙ₊₁
    (cons-stream
     (- s2 (/ (square (- s2 s1))
	      (+ s0 (* -2 s1) s2)))
          (euler-transform (stream-cdr s)))))

(define (make-tableau transform s)
  (cons-stream
   s
   (make-tableau
    transform
        (transform s))))

(define (accelerated-sequence transform s)
  (stream-map stream-car
	      (make-tableau transform s)))

(show-stream ln-stream 10)
(show-stream (euler-transform ln-stream) 10)
(show-stream (accelerated-sequence euler-transform ln-stream) 10)

; CORRECT, sort of. Looked some things up.

