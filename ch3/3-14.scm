(define (mystery x)
    (define (loop x y)
        (if (null? x)
            y
            (let ((temp (cdr x)))
                (set-cdr! x y)
                (loop temp x))))
    (loop x '()))


; 这个过程的作用是翻转列表
; 图示请看3-14.jpg

(define v (list 'a 'b 'c 'd))

(define w (mystery v))

w
;Value 13: (d c b a)

