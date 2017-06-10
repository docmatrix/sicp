(define (make-define name value) (list 'define name value))
(define (namedlet-name exp) (cadr exp))
(define (namedlet-bindings exp) (caddr exp))
(define (namedlet-body exp) (cadddr exp))
(define (namedlet->lambda exp)
  (let ((name (namedlet-name exp))
        (bindings (namedlet-bindings exp))
        (body (namedlet-body exp)))
    (make-begin (cons (make-define (cons name (binding-vars bindings)) body)
                      (list (cons name (binding-vals bindings)))))))

(define (letwithnamed->lambda exp)
  (if (pair? (let-bindings exp))
      (let->lambda exp)
      (namedlet->lambda exp)))
(put-syntax! 'let (lambda (exp env) (eval (letwithnamed->lambda exp) env)))

; CORRECT
