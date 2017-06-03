; 1. Louis plan fails because application? will match anything that is a pair. This will include
;    things like the suggested (define x 3) or indeed anything that is represented by a list
; 2.

(define (application? exp)
  (tagged-list? exp 'call))
(define (operator exp) (cadr exp))
(define (operands exp) (cddr exp))

; CORRECT

