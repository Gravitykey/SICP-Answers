(define (count-pairs x)
    (if (not (pair? x))
    0
    (+ (count-pairs (car x))
       (count-pairs (cdr x))
       1)))

; 正常3个
(count-pairs '(1 2 3))
;Value: 3

; 4个
(define b-4 (cons 2 '()))
(define a-4 (cons 1 b-4))
(define four (cons a-4 b-4))
four
; ((1 2) 2)
(count-pairs four)
;Value: 4

; 7个
(define b-7 (cons 1 '()))
(define a-7 (cons b-7 b-7))
(define seven (cons a-7 a-7))
seven
;Value 14: (((1) 1) (1) 1)
(count-pairs seven)
;Value: 7

; 不返回
; 做出一个环来即可，程序会死循环，直到超过最大递归深度，然后终止
(define cycle '(1 2 3))
(set-cdr! (cdr (cdr cycle)) cycle)
(count-pairs cycle)
;Aborting!: maximum recursion depth exceeded

; 图见3-16.jpg