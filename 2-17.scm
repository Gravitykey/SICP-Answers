(define (last-pair lst)
    (if (null? (cdr lst)) (car lst) (last-pair (cdr lst))))

    (display (last-pair '(23 72 149 34)))
