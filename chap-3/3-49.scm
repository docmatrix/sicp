; Deadlock could still occur if for instance it needed to perform the locks
; in terms of the account balances instead. There's a chance that between
; calculating the existing balances and then acquiring the locks that the balance
; could change, and the serializers would be run in the wrong order.
; CORRECT

