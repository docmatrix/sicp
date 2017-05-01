(load "queues.scm")

(define q1 (make-queue))

(insert-queue! q1 'a)
(display q1)(newline)

(insert-queue! q1 'b)
(display q1)(newline)

(delete-queue! q1)
(display q1)(newline)

(delete-queue! q1)
(display q1)(newline)

; This doesn't display well as the queue is really represented by the car of the structure. Hence,
; a good print function is simply:

(define (print-queue x) (display (car x)) (newline))
(print-queue q1)
(insert-queue! q1 'b)
(insert-queue! q1 'a)
(print-queue q1)

; CORRECT
