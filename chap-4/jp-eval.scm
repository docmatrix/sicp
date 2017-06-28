(load "support/ch4-mceval.scm")

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
(define (let-bindings exp) (cadr exp))
(define (let-body exp) (caddr exp))
(define (binding-vars bindings) (map car bindings))
(define (binding-vals bindings) (map cadr bindings))
(define (let->lambda exp)
  (let ((vars (binding-vars (let-bindings exp)))
        (body (list (let-body exp)))
        (exps (binding-vals (let-bindings exp))))
    (cons (make-lambda vars body) exps)))
(put-syntax! 'let (lambda (exp env) (eval (let->lambda exp) env)))

; ---- Exercise 4.07 ----
(define (make-let bindings body)
  (list 'let bindings body)) 
(define (let*->nested-lets exp)
  (define (nested-let bindings body)
    (if (null? bindings)
        body
        (make-let (list (car bindings)) (nested-let (cdr bindings) body))))
  (nested-let (let-bindings exp) (let-body exp)))

(put-syntax! 'let* (lambda (exp env) (eval (let*->nested-lets exp) env)))

; ---- Exercise 4.08 ----
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

; ---- Exercise 4.09 ----
(define (while-pred exp) (cadr exp))
(define (while-body exp) (caddr exp))
(define (while->combination exp)
  (let ((iter-def (make-define
                   '(iter)
                   (make-if (while-pred exp)
                            (make-begin (cons (while-body exp) (list '(iter))))
                            (while-pred exp)))))
    (list (make-lambda '() (cons iter-def (list '(iter)))))))
(put-syntax! 'while (lambda (exp env) (eval (while->combination exp) env)))

; ---- Exercise 4.11 ----
(define (make-frame variables values) (map list variables values))
(define (frame-variables frame) (map car frame))
(define (frame-values frame) (map cadr frame))
(define (add-binding-to-frame! var val frame)
  (set-cdr! frame (cons (car frame) (cdr frame)))
  (set-car! frame (list var val)))
(define (lookup-variable-value var env)
  (define (env-loop env)
    (if (eq? env the-empty-environment)
        (error "Unbound variable" var))
    (let* ((frame (first-frame env))
           (lookup-val (assoc var frame)))
      (if lookup-val
          (cadr lookup-val)
          (env-loop (enclosing-environment env)))))
  (env-loop env))
(define (set-variable-value! var val env)
  (define (env-loop env)
    (if (eq? env the-empty-environment)
        (error "Unbound variable: SET!" var))
    (let* ((frame (first-frame env))
           (lookup-val (assoc var frame)))
      (if lookup-val
          (set-cdr! lookup-val (list val))
          (env-loop (enclosing-environment env)))))
  (env-loop env))
(define (define-variable! var val env)
  (let* ((frame (first-frame env))
         (lookup-val (assoc var frame)))
    (if lookup-val
        (set-cdr! lookup-val val)
        (if (null? frame)
            (set-car! env (list (list var val)))
            (add-binding-to-frame! var val frame)))))


(load "tests.scm")
(run-tests)
