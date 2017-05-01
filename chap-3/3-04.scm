(define (call-the-cops) "Cops called")
(define (make-account balance password)
  (define (withdraw amount)
    (if (>= balance amount)
	(begin (set! balance
		     (- balance amount))
	       balance)
	"Insufficient funds"))
  (define (deposit amount)
    (set! balance (+ balance amount))
    balance)
  (let ((count 0))
    (define (dispatch input_password m)
      (if (not (eq? input_password password))
	  (begin
	    (set! count (+ count 1))
	    (if (= count 7)
		(call-the-cops)
		"Incorrect password"))
	  (begin
	    (set! count 0)
	    (cond ((eq? m 'withdraw) withdraw)
		  ((eq? m 'deposit) deposit)
		  (else (error "Unknown request: MAKE-ACCOUNT" m))))))
    dispatch))

(define acc
  (make-account 100 'secret-password))

(display ((acc 'secret-password 'withdraw) 1)) (newline)
(display ((acc 'secret-password 'withdraw) 1)) (newline)

(display (acc 'wrong 'withdraw)) (newline)

(display ((acc 'secret-password 'withdraw) 1)) (newline) 

(display (acc 'wrong 'withdraw)) (newline)
(display (acc 'wrong 'withdraw)) (newline)
(display (acc 'wrong 'withdraw)) (newline)
(display (acc 'wrong 'withdraw)) (newline)
(display (acc 'wrong 'withdraw)) (newline)
(display (acc 'wrong 'withdraw)) (newline)
(display (acc 'wrong 'withdraw)) (newline)

; CORRECT

