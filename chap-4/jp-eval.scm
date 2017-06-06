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


(load "tests.scm")
(run-tests)
