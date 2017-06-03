(define (eval exp env)
  (cond ((self-evaluating? exp) exp)
        ((variable? exp) (lookup-variable-value exp env))
        ((pair? exp)
         (let ((installed-eval (get 'eval (car exp))))
           (if installed-eval
               (installed-eval exp env)
               (apply (eval (operator exp) env)
                      (list-of-values (operands exp) env)))))
        (else
         (error "Unknown expression 
                 type: EVAL" exp))))

(put 'eval 'quote (lambda (exp env) (text-of-quotation exp)))
(put 'eval 'set! (lambda (exp env) (eval-assignment exp env)))
(put 'eval 'define (lambda (exp env) (eval-definition exp env)))
(put 'eval 'if? (lambda (exp env) (eval-if exp env)))
(put 'eval 'if? (lambda (exp env) (eval-if exp env)))
(put 'eval 'cond (lambda (exp env)(eval (cond->if exp) env)))

; CORRECT

