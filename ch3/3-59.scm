(load "stream.scm")

(define (add-streams s1 s2)(stream-map + s1 s2))
(define ones (cons-stream 1 ones))
(define integers (cons-stream 1 (add-streams ones integers)))

; 幂级数积分
(define (integrate-series stm)
    (define (inner s a)
        (cons-stream (* (/ 1 a) (stream-car s)) 
                     (inner (stream-cdr s) (+ a 1))))
    (inner stm 1)
)
; 另一种写法
(define (integrate-series2 stm)
    (stream-map * stm (stream-map / ones integers)))

; 测试，得到的结果相同
(stream-head (integrate-series ones) 10)
;Value 13: (1 1/2 1/3 1/4 1/5 1/6 1/7 1/8 1/9 1/10)

(stream-head (integrate-series2 ones) 10)
;Value 14: (1 1/2 1/3 1/4 1/5 1/6 1/7 1/8 1/9 1/10)

(stream-head (integrate-series integers) 10)
;Value 15: (1 1 1 1 1 1 1 1 1 1)

(stream-head (integrate-series2 integers) 10)
;Value 16: (1 1 1 1 1 1 1 1 1 1)

; ;b) 填空，cosine-series，sine-series

; integrate-series是级数的积分(不包括常数项c)。
; 如果已知某多项式x 的导数d，那么多项式的级数可表达为 x = (cons-stream c (integrate-series d))


; 因为sin的导数是cos 
(define sine-series (cons-stream 0 (integrate-series cosine-series)))
; 又因为cos的导数是负sin
(define cosine-series (cons-stream 1 (integrate-series (stream-map (lambda (x) (- x)) sine-series))))

; 测试
(stream-head sine-series 7)
;Value 17: (0 1 0 -1/6 0 1/120 0) 与书上给出的sin x级数一致