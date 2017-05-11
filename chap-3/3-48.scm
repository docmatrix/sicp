; It will work because the accounts will be accessed in order, and so the second account with the
; higher number cannot be acquired until the lower number has been, and as such, only one process
; is garaunteed to be able to access the lower number.

(define (serialized-exchange account1 account2)
  (let ((serializer1 (account1 'serializer))
	(serializer2 (account2 'serializer)))
    (if (>= (account1 'number) (account2 'number))
	((serializer2 (serializer1 exchange))
	 account1
	 account2)
	((serializer1 (serializer2 exchange))
	 account1
	 account2))))

(define last 1)
(define (make-account-and-serializer balance)
  (let ((number (+ last 1)))
    (set! last number)
    (define (withdraw amount)
      (if (>= balance amount)
	  (begin
	    (set! balance (- balance amount))
	    balance)
	  "Insufficient funds"))
    (define (deposit amount)
      (set! balance (+ balance amount))
      balance)
    (let ((balance-serializer
	   (make-serializer)))
      (define (dispatch m)
	(cond ((eq? m 'withdraw) withdraw)
	      ((eq? m 'deposit) deposit)
	      ((eq? m 'balance) balance)
	      ((eq? m 'number) number)
	      ((eq? m 'serializer) balance-serializer)
	      (else (error "Unknown request: MAKE-ACCOUNT" m))))
      dispatch)))

; CORRECT
