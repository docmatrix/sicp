(define (square x) (* x x))
(define (largest x y) (if (> x y) x y))
(define (sum-of-squares a b c)
  (if (= a (largest a b))
      (+ (square a) (square (largest b c)))
      (+ (square b) (square (largest a c)))))
