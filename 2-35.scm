; (define (count-leaves t)
;     (accumulate 
;         <??> <??> (map <??> <??>)
;     )
; )
(load "accumulate.scm")

(define (count-leaves t)
    (accumulate 
        +
        0
        (map 
            (lambda (x)
                (if(null? x)
                    0
                    (if (pair? x)
                        (count-leaves x)
                        1
                    ))) 
            t)))


;测试
(count-leaves '(1 2 3 (4 5 (6 7) 8) 9))
;Value: 11