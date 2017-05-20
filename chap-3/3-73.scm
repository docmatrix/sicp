(define (RC R C dt)
  (lambda (i v0)
    (let ((iR (scale-stream i R))
          (iC (scale-stream i (/ 1 C))))
      (let ((integrated (integral iC v0 dt)))
        (add-streams iR integrated)))
    ))

(define RC1 (RC 5 1 0.5))
(show-stream (RC1 integers 0.2) 5)

; 5.2
; 10.7
; 16.7
; 23.2
; 30.2

; CORRECT
