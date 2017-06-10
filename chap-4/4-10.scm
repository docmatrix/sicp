; This seems like a redundant exercise. By using the data driven method of injecting
; syntax into the evaluator, effectively all of the syntax is custom and independant. 
; I would simply use a different tag value for any of the calls to put-syntax! and this
; would have the affect of altering the syntax.

; We could take it to further extremes and change things like the parameter order of a 
; method like 'if', such that the predicate was last, and this would be a matter of changing
; the accessors to:

(define (if-predicate exp) (cadddr exp))
(define (if-consequent exp) (cadr exp))
(define (if-alternative exp) (caddr exp)) ; Note that this syntax mandates an alternative clause

; CORRECT

