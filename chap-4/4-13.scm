(define (make-unbound! var env)
  ; Only unbind from the current frame 
  ; as we don't own the caller.
  (let* ((frame (first-frame env))
         (filtered (filter (lambda (x) (not (eq? var (car x)))) frame)))
    ;(display filtered) (newline)
    (set-car! frame (car filtered))
    (set-cdr! frame (cdr filtered))))

(define (eval-unbind exp env)
  (make-unbound! (definition-variable exp) env)
  'ok)
(put-syntax! 'make-unbound! (lambda (exp env) (eval-unbind exp env)))

; CORRECT

