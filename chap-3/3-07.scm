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

(define (make-joint acc acc-pw new-pw)
  (define (dispatch input_password m)
    (if (not (eq? input_password new-pw))
	"Incorrect password"
        (acc acc-pw m)))
  dispatch)

(display ((acc 'secret-password 'withdraw) 1)) (newline)
(display (acc 'wrong 'withdraw)) (newline)

(define joint-acc-bad-initial
  (make-joint acc 'wrong 'new-password))
(define joint-acc
  (make-joint acc 'secret-password 'new-password))

(display (joint-acc-bad-initial 'new-password 'withdraw)) (newline)
(display (joint-acc 'new-passwordd 'withdraw)) (newline)

; CORRECT
