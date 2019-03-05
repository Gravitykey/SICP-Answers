; stream.scm和stream-my.scm
; 前者尽量使用解释器自带的过程，后者按书上内容重写。因为有命名冲突问题，故分成两个测试
; 后者实现与解释器有冲突，弃用


; (load "stream-my.scm") 弃用
(load "stream.scm")
(load "3-50.scm")
(define (show x)
    (display-line x)
    x)

(define x (stream-map show (stream-enumerate-interval 0 10)))
(stream-ref x 5)
(stream-ref x 7)

#| 
1 ]=> (define x (stream-map show (stream-enumerate-interval 0 10)))
0
;Value: x

1 ]=> (stream-ref x 5)
1
2
3
4
5
;Value: 5

1 ]=> (stream-ref x 7)
6
7
;Value: 7

结果做到了延迟计算
|#