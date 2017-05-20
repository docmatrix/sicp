(define zero-crossings
  (stream-map sign-change-detector 
              sense-data 
              (cons-stream 0 sense-data)))

; CORRECT. I had it as (cdr sense-data) which effectively reversed the polarity, but the idea of the same offset stream is correct.
