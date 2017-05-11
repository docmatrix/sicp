; If you only run the transactions sequentially then all you are doing is swapping balances, which means that 
; the set of balances will always be 10, 20 and 30. This can be violated with serialization, in this case: 
; A = 10, B = 20, C = 30. If we swap A & B concurrently with A & C, we could have the transaction of the first
; resulting in A = 20, B = 10, C = 30 but then after the second transaction is completed after having read the balance
; before the end of the first transaction you are left with A = 30, B = 10 and C = 10.
;
; By using this new exchange program, it ensures all transactons on all accounts are completed before continuing
; with another.

; CORRECT

