(load "p100.scm")
(load "2-56.scm")

; 说明
; 首先用(cdddr s)判断是否为空
; 如果为空，那么说明该表达式只有 一个符号 两个操作数
; 这时用caddr取出第二个操作数即可
; 如果不为空，那么说明有两个以上的操作数，可以自动展开一层
; 比如(+ a b c d)
; 取cddr的值为 (b c d)
; b c d也是相加的关系，于是在头部添加 + ，再append，得到(+ b c d)
; 如此我们就把 (+ a b c d) 展开成了 (+ a (+ b c d))

; 乘法同理

(define (augend s)
    (if (null? (cdddr s))
            (caddr s)
            (append '(+) (cddr s))))

(define (multiplicand p)
    (if (null? (cdddr p))
            (caddr p)
            (append '(*) (cddr p))))

(deriv '(* (* x y) (+ x 3)) 'x)
;Value 14: (+ (* x y) (* y (+ x 3)))

(deriv '(* x y (+ x 3)) 'x)
;Value 15: (+ (* x y) (* y (+ x 3)))

(deriv '(+ x 3 x 5 (** x 3)) 'x)
;Value 16: (+ 1 (+ 1 (* 3 (** x 2))))