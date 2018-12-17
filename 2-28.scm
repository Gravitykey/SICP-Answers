(define (fringe seq)
    (reverse 
        (let loop( (seq seq) (result '() ))
            ( if(null? seq)
                result
                (if (pair? (car seq))
                    ( loop  (cdr seq) (loop (car seq) result) )
                    ( loop  (cdr seq) (cons (car seq) result) ))))))

(define x '(1 2 3 4) )
(define y '(5 6 7 8) )


(fringe x)
(fringe (list x y ))
(fringe '(1 2 (3 (4 5) 6) 7 (8 9))