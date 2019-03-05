(load "stream.scm")

(define sum 0)
(define (accum x)
    (set! sum (+ x sum))
    sum)
(define seq (stream-map accum (stream-enumerate-interval 1 20)))

(display-line sum); 1
; 定义时只有1被求值

(define y (stream-filter even? seq))

(display-line sum) ; 6
; 求到第一个非偶数出现 1+2+3

(define z (stream-filter (lambda (x) (= (remainder x 5) 0)) seq))

(display-line sum) ;10
; 求值进行到4。 1+2+3+4

(stream-ref y 7) 

(display-line sum); 136
; 强迫求值

(display-stream z)

(display-line sum); 210
; 强迫求值整个流

; 如果不使用memo-proc提供的优化，那么每次计算流时，accum过程会被重复执行，sum会多次累加
