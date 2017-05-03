(define (make-deque)
  (cons '() '()))

(define (set-front-ptr! q item) (set-car! q item))
(define (set-last-ptr! q item) (set-cdr! q item))

(define (empty-deque? q) (null? (front-ptr q)))
(define (front-ptr q) (car q))
(define (last-ptr q) (cdr q))

(define (front-deque q) (car (front-ptr q)))
(define (rear-deque q) (car (last-ptr q)))

(define (make-item data prev next) (cons data (cons prev next)))
(define (data x) (car x))
(define (next x) (cdr (cdr x)))
(define (prev x) (car (cdr x)))
(define (set-next! x next) (set-cdr! (cdr x) next))
(define (set-prev! x prev) (set-car! (cdr x) prev))

(define (front-insert-deque! q item)
  (let ((new-item (make-item item '() (front-ptr q))))
    (cond ((empty-deque? q)
	   (set-front-ptr! q new-item)
	   (set-last-ptr! q new-item)
	   q)
	  (else
	   (set-prev! new-item (front-ptr q))
	   (set-front-ptr! q new-item)
	   q))))
(define (rear-insert-deque! q item)
  (let ((new-item (make-item item (last-ptr q) '())))
    (cond ((empty-deque? q)
	   (set-front-ptr! q new-item)
	   (set-last-ptr! q new-item)
	   q)
	  (else
	   (set-next! (last-ptr q) new-item)
	   (set-last-ptr! q new-item)
	   q))))

(define (print-queue q)
  (define (print-list l)
    (display (data l))
    (if (null? (next l))
	(newline)
	(print-list (next l))))
  (print-list (front-ptr q)))

(define (front-delete-deque! q)
  (let ((first-item (front-ptr q)))
    (let ((next-item (next first-item)))
      (if (null? next-item)
	  (begin
	    (set-front-ptr! q '())
	    (set-last-ptr! q '()))
	  (begin
	    (set-prev! next-item '())
	    (set-front-ptr! q next-item))))))
(define (rear-delete-deque! q)
  (let ((last-item (last-ptr q)))
    (let ((prev-last-item (prev last-item)))
      (if (null? prev-last-item)
	  (begin
	    (set-front-ptr! q '())
	    (set-last-ptr! q '()))
	  (begin
	    (set-next! prev-last-item '())
	    (set-last-ptr! q prev-last-item))))))
  
(define q1 (make-deque))
(display (empty-deque? q1)) (newline) ; #t
(front-insert-deque! q1 'b)
(rear-insert-deque! q1 'c)
(display (empty-deque? q1)) (newline) ; #f
(print-queue q1)                      ; (b c)
(rear-insert-deque! q1 'd)
(front-insert-deque! q1 'a)
(print-queue q1)                      ; (a b c d)
(display (front-deque q1)) (newline)  ; a
(display (rear-deque q1)) (newline)   ; d
(rear-delete-deque! q1)
(rear-delete-deque! q1)
(print-queue q1)                      ; (a b)
(front-delete-deque! q1)
(display (front-deque q1)) (newline)  ; (b)
(display (rear-deque q1))  (newline)  ; (b)
(front-delete-deque! q1)
(display (empty-deque? q1)) (newline)  ; #t

; CORRECT. Could do with more error checking, but it's correct!
