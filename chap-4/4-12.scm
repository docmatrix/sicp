(define (find-var var env)
  (define (env-loop env)
    (if (eq? env the-empty-environment)
        (error "Unbound variable" var))
    (let* ((frame (first-frame env))
           (lookup-val (assoc var frame)))
      (if lookup-val
          lookup-val
          (env-loop (enclosing-environment env)))))
  (env-loop env))

(define (set-variable-value! var val env)
  (set-cdr! (find-var var env) (list val)))
(define (lookup-variable-value var env)
  (cadr (find-var var env)))

; CORRECT

