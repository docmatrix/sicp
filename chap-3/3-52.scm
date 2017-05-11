(load "streams.scm")

(define sum 0)

(define (accum x)
  (set! sum (+ x sum))
  sum)

(define seq
  (stream-map
   accum
   (stream-enumerate-interval 1 20)))

(define y (stream-filter even? seq))

(define z
  (stream-filter
   (lambda (x)
     (= (remainder x 5) 0)) seq))

(stream-ref y 7)
; sum = (1 + 2 ... + 16), 8th even number = 136

(display-stream z)
; 10, 15, 45, 55, 105, 120, 190, 210 (All sums divisible by 5)
; sum = 210, stream exhausted

; The responses would differ as the seen elements of the stream
; would be recalculated, and so sum would be much larger.

; CORRECT
