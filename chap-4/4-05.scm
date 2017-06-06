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

; CORRECT
