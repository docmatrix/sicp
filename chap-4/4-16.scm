(define (lookup-variable-value var env)
  (define (env-loop env)
    (if (eq? env the-empty-environment)
        (error "Unbound variable" var))
    (let* ((frame (first-frame env))
           (lookup-val (assoc var frame)))
      (if lookup-val
          (let ((val (cadr lookup-val)))
            (if (eq? val '*unassigned*)
                (error "Unassigned variable")
                val))
          (env-loop (enclosing-environment env)))))
  (env-loop env))

(define (defines->let defines)
  (map (lambda (x) (list (definition-variable x) '(quote *unassigned*))) defines))

(define (defines->set defines)
  (map (lambda (x) (list 'set! (definition-variable x) (definition-value x))) defines))

(define (scan-out-defines body)
  (let* ((defines (filter definition? body))
         (others (filter (lambda (x) (not (definition? x))) body))
         (let-exps (defines->let defines))
         (set-exps (defines->set defines)))
    (if (null? defines)
       body
       (list (make-let let-exps (make-begin (append set-exps others)))))
))

(define (make-procedure parameters body env)
  (list 'procedure parameters (scan-out-defines body) env))

; Installed on make-procedure otherwise it will get regenerated each invocation

; CORRECT. Used some references to help, though I feel my implementation is cleaner
