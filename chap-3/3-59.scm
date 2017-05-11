(define (divide-streams s1 s2)
  (stream-map / s1 s2))

(define (integrate-series s)
  (divide-streams s integers))

(define cosine-series
  (cons-stream 1 (integrate-series (multiple-series negones sine))))
(define sine-series
  (cons-stream 0 (integrate-series cosine)))

; CORRECT

