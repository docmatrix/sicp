(load "support/ch4-ambeval.scm")
(define the-global-environment (setup-environment))
(define (run exp) (ambeval exp the-global-environment (lambda (val next) val) (lambda () 'ok)))

; ---- Exercise 4.35 ----
(run '(define (require p) (if (not p) (amb))))
(run '(define (an-integer-between low high)
        (require (> high low))
        (amb low (an-integer-between (+ low 1) high))))

