; 书上给的append!
(define (append! x y)
    (set-cdr! (last-pair x) y)
    x)

(define (last-pair x)
    (if (null? (cdr x))
        x
        (last-pair (cdr x))))

; 交互
(define x (list 'a 'b))

(define y (list 'c 'd))

(define z (append x y))

z
;Value 13: (a b c d)

(cdr x)
;Value 14: (b)

(define w (append! x y))

w
;Value 15: (a b c d)
(cdr x)
;Value 14: (b c d)

; 因为append！简单的改变了第一个参数的末尾，即改变了参数所指向存储单元的本体，
; 而不是生成一个新的存储单元，导致参数x的值被更改。所以导致append和append!的结果不一致
; 图见3-12.jpg

