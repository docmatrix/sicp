(define (let-bindings exp) (cadr exp))
(define (let-body exp) (caddr exp))
(define (binding-vars bindings) (map car bindings))
(define (binding-vals bindings) (map cadr bindings))
(define (let->lambda exp)
  (let ((vars (binding-vars (let-bindings exp)))
        (body (list (let-body exp)))
        (exps (binding-vals (let-bindings exp))))
    (cons (make-lambda vars body) exps)))

(put-syntax! 'let (lambda (exp) (analyze (let->lambda exp))))

; CORRECT
