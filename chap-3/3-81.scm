
(define (rand-update x) (+ x 1))

(define (random-numbers commands)
  (define (get-next-number prev_number commands)
    (let ((command (stream-car commands)))
      (cond ((eq? command 'reset)
             (let ((new-seed (stream-car (stream-cdr commands))))
               (cons-stream (rand-update new-seed)
                            (get-next-number (rand-update new-seed)
                                             (stream-cdr (stream-cdr commands))))))
            ((eq? command 'generate)
             (cons-stream (rand-update prev_number)
                          (get-next-number (rand-update prev_number)
                                           (stream-cdr commands)))
             )
          (else (error "Unknown command"))))
    )
  (get-next-number 0 commands))

(define commands (list->stream '(generate generate reset 1 generate generate generate reset 10 generate generate)))

(show-stream (random-numbers commands) 8)

; CORRECT
