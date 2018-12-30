(define (deep-reverse s)
    (let loop((s s) (result '()))
        (if (null? s)
            result
            (if (pair? (car s))
                (loop (cdr s) (cons (deep-reverse (car s)) result ))
                (loop (cdr s) (cons (car s) result ))))))

(define x '((1 2)(3 4)))
(reverse x)
(deep-reverse x)