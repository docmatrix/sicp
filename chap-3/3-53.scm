(define s (cons-stream 1 (add-streams s s)))

; This results in a stream that doubles, so 1, 2, 4, 8, etc.

; CORRECT
