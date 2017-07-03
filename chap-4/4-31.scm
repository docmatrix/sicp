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


(define (delay-arg? arg)
  (if (pair? arg)
      (cond ((eq? (cadr arg) 'lazy) #t)
            ((eq? (cadr arg) 'lazy-memo) #t)
            (else #f))
      #f))

(define (list-of-delayed-args arg-names exps env)
  (if (no-operands? exps)
      '()
      (let* ((arg-name (car arg-names))
             (arg-val (first-operand exps))
             (rest (list-of-delayed-args (cdr arg-names) (rest-operands exps) env)))
        (if (delay-arg? arg-name)
            (cons (delay-it arg-val env) rest)
            (cons (eval arg-val env) rest)))))

(define (make-frame variables values)
  (define (flatten-variables vars)
    (if (null? vars)
        '()
      (let ((var (car vars))
            (rest (flatten-variables (cdr vars))))
        (if (pair? var)
            (cons (car var) rest) 
            (cons var rest)))))
  (cons (flatten-variables variables) values)) 

(put-syntax! 'actual-value (lambda (exp env)(eval (actual-value exp env) env)))

(load "tests-4-31.scm")
(run-tests)

; CORRECT, though I haven't done the optional memoize. It's all memoized. Needed some help for this one
