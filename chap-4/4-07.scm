; ---- Exercise 4.07 ----
(define (make-let decls body)
  (list 'let decls body)) 
(define (let*->nested-lets exp)
  (define (nested-let decls body)
    (if (null? decls)
        body
        (make-let (list (car decls)) (nested-let (cdr decls) body))))
  (nested-let (let-decls exp) (let-body exp)))

(put-syntax! 'let* (lambda (exp env) (eval (let*->nested-lets exp) env)))

; I believe that the simple eval clause is sufficient and we don't need an explicity derivation (thats what the clause does anyway)


