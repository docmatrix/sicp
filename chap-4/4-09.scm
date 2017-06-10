; ---- Exercise 4.09 ----
(define (while-pred exp) (cadr exp))
(define (while-body exp) (caddr exp))
(define (while->combination exp)
  (let ((iter-def (make-define
                   '(iter)
                   (make-if (while-pred exp)
                            (make-begin (cons (while-body exp) (list '(iter))))
                            (while-pred exp)))))
    (list (make-lambda '() (cons iter-def (list '(iter)))))))
(put-syntax! 'while (lambda (exp env) (eval (while->combination exp) env)))

; CORRECT
