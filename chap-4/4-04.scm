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

