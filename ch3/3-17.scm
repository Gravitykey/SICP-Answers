; 这里的in需要用到memq内置过程，使用eq?逐项对比得不到正确的结果
(define in? memq)


; 递归做法，不使用set!来保存表
(define (count-pairs lst)
    (define (count x counted-items)
        (if (not (pair? x))
        counted-items
            (if (in? x counted-items)
                counted-items
                (count (car x) (count (cdr x) (cons x counted-items))))
        ))
    (length (count lst '())))


; 使用set的做法
(define (count-pairs-set lst)
    (define counted-items '())
    (define (count-loop x)
        (if (or (not (pair? x))
            (in? x counted-items))
            0
            (begin
                (set! counted-items (cons x counted-items))
                (+ (count-loop (car x))
                (count-loop (cdr x))
                1))))
    (count-loop lst))

    
; 测试之前值为4的表
(define b-4 (cons 2 '()))
(define a-4 (cons 1 b-4))
(define four (cons a-4 b-4))
four
(count-pairs four)
(count-pairs-set four)
;Value: 3


; 测试之前值为7的表
(define b-7 (cons 1 '()))
(define a-7 (cons b-7 b-7))
(define seven (cons a-7 a-7))
seven
(count-pairs seven)
(count-pairs-set seven)
;Value: 3


;测试环
(define cycle '(1 2 3))
(set-cdr! (cdr (cdr cycle)) cycle)
(count-pairs cycle)
(count-pairs-set cycle)
;Value: 3