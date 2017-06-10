(use-modules (check))

(define the-global-environment (setup-environment))
(define (run exp) (eval exp the-global-environment))

(define (run-tests)
  ; Check basic primitives
  (check (run 5) => 5)
  (check (run 666666666222) => 666666666222)
  (check (run (/ 3 7)) => (/ 3 7))
  (check (run "hi there") => "hi there")

  ; Check quoted elements
  (check (run '(quote 2)) => 2)
  (check (run '(quote hello)) => 'hello)
  (check (run '(quote (one 2 three))) => '(one 2 three))

  ; Check if
  (check (run '(cons 1 2)) => (cons 1 2))
  (check (run '(if (= 4 5) false 1)) => 1)
  (check (run '(if (= 5 5) false 1)) => false)
  (check (run '(if (= 4 5) false 1)) => 1)
  (check (run '(cond (false false) (else true))) => true)
  (check (run '(cond (true true) (else false))) => true)
  (check (run '(cond ((= 5 6) false) ((= 4 5) false) ((= 51 5) false) (else (= 1 1)))) => true)
  (check (run '(cond ((= 5 6) false) ((= 4 5) false) ((= 5 5) true) (else false))) => true)
  (check (run '(cond (10 => (lambda (x) (+ x 5))) (else false))) => 15)
  (check (run '(cond ((assoc 'b '((a 1) (b 2))) => cadr) (else false))) => 2)
  (check (run '(cond ((assoc 'z '((a 1) (b 2))) => cadr) (else false))) => false)

  ; Check and / or
  (check (run '(and true true true)) => true)
  (check (run '(and true false true)) => false)
  (check (run '(and false false false)) => false)
  (check (run '(and 1 2 3)) => true)
  (check (run '(and 1 2 false)) => false)
  (check (run '(or true true true)) => true)
  (check (run '(or true false true)) => true)
  (check (run '(or false false false)) => false)
  (check (run '(or false false false)) => false)
  (check (run '(or 1 2 3)) => true)
  (check (run '(or 1 2 false)) => true)

  ; Check variables
  (run '(define joe 12))
  (run '(define moe 5))

  (check (run 'joe) => 12)
  (check (run '(+ joe 2)) => 14)
  (check (run '(= joe 12)) => true)
  (check (run '(+ joe moe)) => 17)

  (run '(set! moe 10))
  (run '(set! joe (+ moe 5)))

  (check (run '(+ moe joe)) => 25)
  
  ; Check procedure definition
  (run '(define (sum a b) (+ a b)))
  (run '(define (average x y) (/ (sum x y) 2)))
  (run '(define xx 10))
  (run '(define yy 20))
  (check (run '(sum 2 4)) => 6)
  (check (run '(average xx yy)) => 15)

  (check (run '((lambda (x y) (+ x y)) 15 5)) => 20)
  (run '(define lsum (lambda (x y) (+ x y))))
  (check (run '(lsum 11 12)) => 23)
  (run '(set! lsum (lambda (x y) (- x y ))))
  (check (run '(lsum 11 12)) => -1)

  ; Check recursives
  (run '(define (rsum x y) (if (= y 0) x (rsum (+ x 1) (- y 1)))))
  (check (run '(rsum 5 6)) => 11)
  (check (run '(rsum 0 6)) => 6)
  (check (run '(rsum 6 0)) => 6)

  ; Returned functions
  (run '(define (make-adder-func x) (lambda (y) (+ x y))))
  (run '(define add2 (make-adder-func 2)))
  (check (run '(add2 xx)) => 12)
  (check (run '((make-adder-func 4) 10)) => 14)

  ; Function params
  (run '(define (apply-twice func val) (func (func val))))
  (check (run '(apply-twice add2 100)) => 104)
  (check (run '(apply-twice (lambda (x) (* x x)) 10)) => 10000)

  (run '(define (compose f g) (lambda (x) (f (g x)))))
  (run '(define (square x) (* x x)))
  (run '(define (inc x) (+ x 1)))
  (check (run '((compose square inc) 10)) => 121)
  (check (run '((compose inc square) 10)) => 101)

  ; Let
  (check (run '(let ((a 2) (b 3)) (+ a b))) => 5)
  (check (run '(let ((a 2)) (let ((b (square 5))) (+ a b)))) => 27) 
  (check (run '(let* ((x 3) (y (+ x 2)) (z (+ x y 5))) (* x z))) => 39)

  (check-report)
  (check-reset!)
)

