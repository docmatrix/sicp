; We need to initialise each of the procedures to ensure the initial states down the system
; are correct. This is necessary for things like and's, not's, etc where you might otherwise
; start the system with inconsistent states. For instance, an inverter without triggering
; the action procedures would have 0 -> 0 which is incorrect.
; CORRECT
