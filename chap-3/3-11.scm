; Not doing diagrams in ASCII, BUT
; make-account is in the global environment. When called it creates an environment with balance, withdraw, deposit and dispatch defined and assigns dispatch (a procedure) to the caller, pointing to this new envirnoment.
; Therefore acc is an alias for dispatch in E1 with balance set to 50. The two calls on acc are calling the withdraw and deposit methods on that environment.
; acc2 is an alias for dispatch in E2, with balance set to 100.
; The local accounts are kept distinct, because each call to make-account sets up a new environment. I don't believe anything is shared if we take the pure view, but the text does refer to sharing procedure code depending on 
; implementation.
; CORRECT
