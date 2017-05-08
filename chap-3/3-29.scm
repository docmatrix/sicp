(define (or-gate o1 o2 output)
  (let ((and1 (make-wire))
	(and2 (make-wire))
	(nand1 (make-wire))
	(nand2 (make-wire))
	(and3 (make-wire)))
    (and-gate o1 o1 and1)
    (and-gate o2 o2 and2)
    (inverter and1 nand1)
    (inverter and2 nand2)
    (and-get nand1 nand2 and3)
    (inverter and3 output)))

; Delay time is and-delay, inverter-delay, and-delay, inverter-delay. So 2*and-delay + 2*inverter-delay
; CORRECT
