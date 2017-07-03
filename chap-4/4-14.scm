; Louis is trying to use map doesn't fall through the 'new' version of
; the eval-apply loop, so therefore it won't evaluate the arguments correctly
; nor unwrap the tagged lists, etc. It also won't use any other definitions
; that might have been built up in the environment. 

; CORRECT
