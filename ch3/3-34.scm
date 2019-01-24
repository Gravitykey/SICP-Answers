(load "ch3-3-5.scm")
; 使用乘法约束构建平方器
(define (squarer a b)
    (multiplier a a b)
)

(define a (make-connector))
(define b (make-connector))
(squarer a b)
(probe "a:" a)
(probe "b:" b)

(set-value! b 9 'user)
; 1 ]=> (set-value! b 9 'user)
; Probe: b: = 9
; ;Value: done

; 很显然设置了b之后，无法映射回a的值。
; multiplier的定义里面，只得知b的值，a为空，不符合乘法约束的四种计算情况，会被忽略。
; 而设置了a的值，则约束里面m1,m2的值都不为空，会直接算出b。
; 所以用乘法来表示平方，构成的约束是单项的。

