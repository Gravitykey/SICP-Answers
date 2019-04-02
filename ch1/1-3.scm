; 三个数返回较大两个数之和
; 先找出最小的那个数，然后全加起来之后减掉最小的
(define (min a b)
    (if (> a b)
        b
        a))
(define (add-two-big a b c)
    (+ a b c (- (min c (min a b)))))

; 测试

(add-two-big 1 2 3)
(add-two-big 6 6 6)
(add-two-big 8 5 6)

; (add-two-big 1 2 3)
; ;Value: 5

; 1 ]=> (add-two-big 6 6 6)
; ;Value: 12

; 1 ]=> (add-two-big 8 5 6)
; ;Value: 14
