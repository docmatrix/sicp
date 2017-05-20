(define (make-zero-crossings input-stream last-value last-avg)
  (let ((avpt (/ (+ (stream-car input-stream) last-value) 2)))
    (cons-stream avpt
                 (make-zero-crossings (stream-cdr input-stream)
                                      (stream-car input-stream)
                                      avpt))))

; CORRECT, though I had to look it up. I originally assumed it was becuase it was starting from zero. The actual problem was that it was
; averaging the previous average with the next value rather than just averaging the previous two values. 
