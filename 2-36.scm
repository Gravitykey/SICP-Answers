(load "accumulate.scm")

; (define (accumulate-n op init seqs)
;     (if(null? (car seqs))
;         '()
;         (cons (accumulate op init <??>)
;               (accumulate-n op init <??>))    
;     )
; )

(define (accumulate-n op init seqs)
    (if(null? (car seqs))
        '()
        (cons (accumulate op init 
                (let loop1((x seqs))
                    (if (null? x)
                        '()
                        (cons (caar x) (loop1 (cdr x)))
                    )
                ))
              (accumulate-n op init 
                (let loop2((x seqs))
                    (if (null? x)
                        '()
                        (cons (cdar x) (loop2 (cdr x)))
                    )
                ))
        )    
    )
)

;循环，用caar取出(x[0][0],x[1][0],x[2][0]...)，用cdar取出 (x[0][1],x[0][2]...)，(x[1][1],x[1][2]...)...
;测试
(accumulate-n + 0 '((1 2 3)(4 5 6)(7 8 9)(10 11 12)) )
;Value 13: (22 26 30)