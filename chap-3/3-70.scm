#lang racket

;(use-modules (ice-9 syncase))
;(define-syntax cons-stream
;  (syntax-rules ()
;    ((_ head tail) (cons head (delay tail))) ))

;(defmacro cons-stream (a b)
;  `(cons ,a (delay ,b)))


; (use-syntax (ice-9 syncase))  ; this is currently needed for R5RS macros to work in Guile

(define-syntax cons-stream
  (syntax-rules ()
    ((_ ?car ?cdr) (cons ?car (delay ?cdr)))))


(define (stream-car stream) (car stream))
(define (stream-cdr stream) (force (cdr stream)))

(define (stream-filter pred stream)
  (cond ((null? stream) '())
	((pred (stream-car stream))
	 (cons-stream (stream-car stream)
		      (stream-filter pred
				     (stream-cdr stream))))
	(else (stream-filter pred (stream-cdr stream)))))

(define (stream-ref stream n)
  (if (< n 1)
      (stream-car stream)
      (stream-ref (stream-cdr stream) (- n 1))))

(define (stream-map proc . argstreams)
  (if (null? (car argstreams))
      '()
      (cons-stream
       (apply proc (map stream-car argstreams))
       (apply stream-map
	      (cons proc (map stream-cdr argstreams))))))

(define (stream-map-single proc s)
  (if (null? s)
      '()
      (cons-stream
       (proc (stream-car s))
       (stream-map-single proc (stream-cdr s)))))

(define (stream-for-each proc s)
  (if (null? s)
      'done
      (begin
	(proc (stream-car s))
	(stream-for-each proc (stream-cdr s)))))

(define (stream-enumerate-interval low high)
  (if (> low high)
      '()
      (cons-stream
       low
       (stream-enumerate-interval (+ low 1)
				  high))))

(define (display-stream s)
  (stream-for-each display-line s))

(define (display-line x)
  (newline)
  (display x))

(define (add-streams s1 s2)
  (stream-map + s1 s2))

(define ones (cons-stream 1 ones))

(define integers
  (cons-stream 1 (add-streams ones integers)))

(define (partial-sum s)
  (cons-stream (stream-car s)
	       (add-streams (stream-cdr s)
			    (partial-sum s))))

(define (show-stream s n)
  (if (zero? n)
      (display-line "done")
      (begin
	(display (stream-car s)) (newline)
	(show-stream (stream-cdr s) (- n 1) ))))

(define (interleave s1 s2)
  (if (null? s1)
      s2
      (cons-stream
       (stream-car s1)
       (interleave s2 (stream-cdr s1)))))

(define (pairs s t)
  (cons-stream
   (list (stream-car s) (stream-car t))
   (interleave
    (stream-map (lambda (x)
		  (list (stream-car s) x))
		(stream-cdr t))
    (pairs (stream-cdr s) (stream-cdr t)))))

(define (scale-stream stream factor)
  (stream-map
   (lambda (x) (* x factor))
   stream))

(define (integral integrand initial-value dt)
  (define int
    (cons-stream 
     initial-value
     (add-streams (scale-stream integrand dt)
                  int)))
  int)

(define (RC R C dt)
  (lambda (i v0)
    (add-streams iR 
    ))
