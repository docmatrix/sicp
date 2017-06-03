(define (list-of-values exps env)
  (if (no-operands? exps)
      '()
      (cons (eval (first-operand exps) env)
            (list-of-values 
             (rest-operands exps) 
             env))))


(define (list-of-values-ltr exps env)
  (if (no-operands? exps)
      '()
      (let ((left-value (eval (first-operand exps) env)))
        (let ((right-value (list-of-values-ltr (rest-operands exps) env)))
          (cons left-value right-value)))))

(define (list-of-values-rtl exps env)
  (if (no-operands? exps)
      '()
      (let ((right-value (list-of-values-rtl (rest-operands exps) env)))
        (let ((left-value (eval (first-operand exps) env)))          
          (cons left-value right-value)))))

(list-of-values '(a b c) '())
(list-of-values-ltr '(a b c) '())
(list-of-values-rtl '(a b c) '())

; CORRECT

