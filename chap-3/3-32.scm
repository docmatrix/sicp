; If you do not maintain the order of operations, then nested
; components make run on stale inputs. You cannot garauntee that
; the components you're using are ultimate primitives, so you need
; to ensure that any nested component gets called immediately after
; its inputs are triggered.
; CORRECT
