(define random-init 1)
(define (rand-update x) (+ x 1))

(define rand
  (let ((x random-init))
    (lambda (command)
      (if (eq? command 'reset)
	  (lambda (random-init) (set! x random-init))
	  (begin
	    (set! x (rand-update x)) x)))))

; CORRECT

