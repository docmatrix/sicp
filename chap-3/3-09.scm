; (Global Env) -> (f 6) -> (* 6 (f 5))
; -> (E1, n = 5)        -> (* 5 (f 4))
; -> (E2, n = 4)        -> (* 4 (f 3))
; -> (E3, n = 3)        -> (* 3 (f 2))
; -> (E4, n = 2)        -> (* 2 (f 1))
; -> (E5, n = 1)        -> 1

; (Global Env)-> (f 6)  -> (fact-iter 1 1 6)
; (E1, product=1, counter=1, max=6) -> (fact-iter 1 2 6)
; (E2, product=1, counter=2, max=6) -> (fact-iter 2 3 6)
; (E3, product=2, counter=3, max=6) -> (fact-iter 6 4 6)
; (E4, product=6, counter=4, max=6) -> (fact-iter 24 5 6)
; (E5, product=24, counter=5, max=6) -> (fact-iter 120 6 6)
; (E6, product=120, counter=6, max=6) -> (fact-iter 720 7 6)
; (E7, product=720, counter=6, max=6) -> 720 

; CORRECT
