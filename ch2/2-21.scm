(define (map proc items)
    (if (null? items)
        '()
        (cons (proc (car items)) (map proc (cdr items)))
    )
)

(define (square-list items)
    (if (null? items)
        '()
        (cons (expt (car items) 2 ) (square-list (cdr items)))    
    )
)

(define (square-list2 items)
    (map  (lambda (x) (* x x))  items)
)

(square-list '(1 2 3 4 5))

(square-list2 '(1 2 3 4 5 6))