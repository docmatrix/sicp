(load "support/ch4-leval.scm")

(use-modules (syntax-table))
(define (eval exp env)
  (cond ((self-evaluating? exp) exp)
        ((variable? exp) (lookup-variable-value exp env))
        ((pair? exp)
         (let ((installed-eval (get-syntax  (operator exp))))
           (if installed-eval
               (installed-eval exp env)
               (apply-jp (actual-value (operator exp) env) (operands exp) env))))
        (else
         (error "Unknown expression 
                 type: EVAL" exp))))

(put-syntax! 'quote (lambda (exp env) (text-of-quotation exp)))
(put-syntax! 'set! (lambda (exp env) (eval-assignment exp env)))
(put-syntax! 'define (lambda (exp env) (eval-definition exp env)))
(put-syntax! 'lambda (lambda (exp env) (make-procedure (lambda-parameters exp) (lambda-body exp) env)))
(put-syntax! 'begin (lambda (exp env) (eval-sequence (begin-actions exp) env)))
(put-syntax! 'if (lambda (exp env) (eval-if exp env)))
(put-syntax! 'cond (lambda (exp env)(eval (cond->if exp) env)))

(load "tests-leval.scm")
(run-tests)

