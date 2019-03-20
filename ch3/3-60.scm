(define (scale-stream stream factor)
    (stream-map (lambda (x) (* x factor)) stream))
; 实现mul-series级数相乘

; (define (mul-series s1 s2)
    ; (cons-stream <??> (add-streams <??><??>)))


(define (mul-series s1 s2)
    (cons-stream (* (stream-car s1) (stream-car s2))
                 (add-streams (scale-stream (stream-cdr s2) (stream-car s1)) 
                                          (mul-series (stream-cdr s1) s2))))

; 解释
; 两个级数相乘，相当于级数a的每一项分别与级数b相乘。
; 那么可知，如果保证(stream-car a )的指数不变,该项必定乘的是b的常数项，也就是(stream-car b)
; 故做成流之后，(stream-car mul) 结果必为(* (stream-car a)(stream-car b))
; 在这一步，我们得到了a0*b0 
; 则后面仍未处理的：
;   1.  a0与b1到bn 相乘
;   2.  a1开始，每一项与级数b相乘。
; 把1. 2. 两点相加，即得到上面的答案

; 测试
(load "../ch2/accumulate.scm")
(load "3-59.scm")

(stream-head (mul-series sine-series sine-series) 10)
;Value 14: (0 0 1 0 -1/3 0 2/45 0 -1/315 0)

(stream-head (mul-series cosine-series cosine-series) 10)
;Value 15: (1 0 -1 0 1/3 0 -2/45 0 1/315 0)

(define sum (add-streams (mul-series sine-series sine-series)
                         (mul-series cosine-series cosine-series)))

(stream-head sum 10)
;Value 16: (1 0 0 0 0 0 0 0 0 0)

(accumulate + 0 (stream-head sum 100))
;Value: 1

; 结果正确
