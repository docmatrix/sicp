; Don't want to do ascii diagrams, BUT
; The let will simply produce a lambda that is called on the set expression. What this means is that the internal code is wrapped
; in the environment of that outer lambda, and as so the let term is defined in a child environment, in which the internal lambda is also bound and points to.
; CORRECT
