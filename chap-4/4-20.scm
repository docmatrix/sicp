(define (letrec-exps exp)
  (let ((bindings (let-bindings exp)))
    (map (lambda (x) (list (car x) '(quote *unassigned))) bindings)))
(define (letrec-sets exp)
  (let ((bindings (let-bindings exp)))
    (map (lambda (x) (list 'set! (car x) (cadr x))) bindings)))

(define (letrec->let exp)
  (make-let (letrec-exps exp) (make-begin (append (letrec-sets exp) (list (let-body exp))))))
(put-syntax! 'letrec (lambda (exp env) (eval (letrec->let exp) env)))


; CORRECT
