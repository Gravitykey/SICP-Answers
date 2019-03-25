(load "stream.scm")
(define (expand num den radix)
    (cons-stream
        (quotient (* num radix) den)
        (expand (remainder (* num radix) den) den radix)))
; 该过程是求除法小数，每次一位，可得到无限精度

(define a (stream-map display-line (expand 1 7 10)))
(define b (stream-map display-line (expand 3 8 10)))
(stream-ref a 10)

#| 
(stream-ref a 10)
输出
4
2
8
5
7
1
4
2
8
5

符合 1/7=0.142857142857……
|#

(stream-ref b 10)
#| 
输出
7
5
0
0
0
0
0
0
0
0

符合 3/8=0.375
|#