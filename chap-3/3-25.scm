(define (make-table)
  (let ((local-table (list '*table*)))

    (define (lookup . keys)
      (define (inner table keys)
	(let ((subtable (cdr table)))
	  (if (null? keys)
	      subtable ; This is the value at this point
	      (let ((lookup-val (assoc (car keys) subtable)))
		(if lookup-val
		    (inner lookup-val (cdr keys))
		    #f)))))
      (inner local-table keys))

    
    (define (insert! value . keys)
      (define (inner table keys)
	(let ((key (car keys))
	      (last-key (null? (cdr keys))))
	  (let ((record (assoc key (cdr table))))
	    (if (not record)
		(begin
		  (set! record (cons key '()))
		  (set-cdr! table
			    (cons record (cdr table)))))
	    (if last-key
		(set-cdr! record value)
		(inner record (cdr keys))))))
      (inner local-table keys)
      'ok)
    (define (dispatch m)
      (cond ((eq? m 'lookup-proc) lookup)
	    ((eq? m 'insert-proc!) insert!)
	                (else (error "Unknown operation: 
                          TABLE" m))))
    dispatch))

(define twokeys (make-table))
((twokeys 'insert-proc!) 'a-a 'a 'a)
((twokeys 'insert-proc!) 'b-a 'b 'a)
((twokeys 'insert-proc!) 'b-a2 'b 'a)
((twokeys 'insert-proc!) 'b-b 'b 'b)
((twokeys 'insert-proc!) 'b-b-b 'c 'b 'a)
(display ((twokeys 'lookup-proc) 'a 'a)) (newline)
(display ((twokeys 'lookup-proc) 'b 'a)) (newline)
(display ((twokeys 'lookup-proc) 'b 'b)) (newline)
(display ((twokeys 'lookup-proc) 'b 'c)) (newline)
(display ((twokeys 'lookup-proc) 'c 'b 'a)) (newline)

; CORRECT

