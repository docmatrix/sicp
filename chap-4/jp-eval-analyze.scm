(load "support/ch4-analyzingmceval.scm")

(use-modules (syntax-table))

(define (analyze exp)
  (cond ((self-evaluating? exp) (analyze-self-evaluating exp))
        ((variable? exp)(analyze-variable exp)) 
        ((pair? exp)
         (let ((installed-analyzer (get-syntax (operator exp))))
           (if installed-analyzer
               (installed-analyzer exp)
               (analyze-application exp))))
        (else
         (error "Unknown expression 
                 type: EVAL" exp))))

(put-syntax! 'quote (lambda (exp) (analyze-quoted exp)))
(put-syntax! 'set! (lambda (exp) (analyze-assignment exp)))
(put-syntax! 'define (lambda (exp) (analyze-definition exp)))
(put-syntax! 'lambda (lambda (exp) (analyze-lambda exp)))
(put-syntax! 'begin (lambda (exp) (analyze-sequence (begin-actions exp))))
(put-syntax! 'if (lambda (exp) (analyze-if exp)))
(put-syntax! 'cond (lambda (exp) (analyze (cond->if exp))))

; ---- Exercise 4.22 ----
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


(load "tests-analyzer.scm")
(run-tests)

