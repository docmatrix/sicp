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
  (define (dispatch input_password m)
      (if (not (eq? input_password password))
	  "Incorrect password"
	  (cond ((eq? m 'withdraw) withdraw)
	        ((eq? m 'deposit) deposit)
	        (else (error "Unknown request: MAKE-ACCOUNT" m)))))
    dispatch)

(define acc
  (make-account 100 'secret-password))

(display ((acc 'secret-password 'withdraw) 1)) (newline)
(display (acc 'wrong 'withdraw)) (newline)

; CORRECT
