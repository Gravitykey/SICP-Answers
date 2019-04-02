(define (a-plus-abs-b a b)
    ((if (> b 0) + -) a b))
; 求的是a加上b的绝对值
