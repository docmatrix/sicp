((lambda (n)
   ((lambda (fib) (fib fib n))
    (lambda (fn n)
      (cond ((= n 0) 0)
            ((= n 1) 1)
            (else (+ (fn fn (- n 1))
                     (fn fn (- n 2))))))))
 10)

(define (f x)
  ((lambda (even? odd?)
     (even? even? odd? x))
   (lambda (ev? od? n)
     (if (= n 0) 
         true 
         (od? ev? od? (- n 1))))
   (lambda (ev? od? n)
     (if (= n 0) 
         false 
         (ev? ev? od? (- n 1))))))

; CORRECT
