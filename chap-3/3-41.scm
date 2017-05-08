; Bens change doesn't modify any behaviour. You would do this if you wanted to
; check your balance before making a change, but because those two events wouldn't
; be serialized together you don't get any safety. Easy example is account with 100,
; Paul checks balance, Peter withdraws 50 and paul withdraws 75 but gets an unexpected
; refusal.
; CORRECT

