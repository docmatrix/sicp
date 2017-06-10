(load "ch4-mceval.scm")

; ---- Exercise 4.03 ----
(use-modules (syntax-table))
(define (eval exp env)
  (cond ((self-evaluating? exp) exp)
        ((variable? exp) (lookup-variable-value exp env))
        ((pair? exp)
         (let ((installed-eval (get-syntax  (operator exp))))
           (if installed-eval
               (installed-eval exp env)
               (apply-jp (eval (operator exp) env)
                      (list-of-values (operands exp) env)))))
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
; CORRECT

; ---- Exercise 4.04 ----

(define (eval-and exp env)
  (if (null? exp)
      true
      (if (false? (eval (first-exp exp) env))
          false
          (eval-and (rest-exps exp) env))))

(define (eval-or exp env)
  (if (null? exp)
      false
      (if (true? (eval (first-exp exp) env))
          true
          (eval-or (rest-exps exp) env))))

(put-syntax! 'and (lambda (exp env) (eval-and (cdr exp) env)))
(put-syntax! 'or (lambda (exp env) (eval-or (cdr exp) env)))
; CORRECT. Alternate method would be create derived nested if's.

; ---- Exercise 4.05 ----
(define (recipient-clause? clause)
  (eq? (cadr clause) '=>))
(define (clause-recipient clause)
  (caddr clause))

(define (expand-clauses clauses)
  (if (null? clauses)
      'false                          ; no else clause
      (let ((first (car clauses))
            (rest (cdr clauses)))
        (if (cond-else-clause? first)
            (if (null? rest)
                (sequence->exp (cond-actions first))
                (error "ELSE clause isn't last -- COND->IF"
                       clauses))
            (if (recipient-clause? first)
                (make-if (cond-predicate first)
                         (cons (clause-recipient first) (list (cond-predicate first)))
                         (expand-clauses rest))
                 (make-if (cond-predicate first)
                          (sequence->exp (cond-actions first))
                          (expand-clauses rest)))))))

; ---- Exercise 4.06 ----
(define (let-decls exp) (cadr exp))
(define (let-body exp) (caddr exp))
(define (let-var decl) (car decl))
(define (let-exp decl) (cadr decl))
(define (let-vars decls)
  (if (null? decls)
      '()
      (cons (let-var (car decls))
            (let-vars (cdr decls)))))
(define (let-exps decls)
  (if (null? decls)
      '()
      (cons (let-exp (car decls))
            (let-exps (cdr decls)))))
(define (let->lambda exp)
  (let ((vars (let-vars (let-decls exp)))
        (body (list (let-body exp)))
        (exps (let-exps (let-decls exp))))
    (cons (make-lambda vars body) exps)))
(put-syntax! 'let (lambda (exp env) (eval (let->lambda exp) env)))
; CORRECT

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


(load "tests.scm")
(run-tests)
