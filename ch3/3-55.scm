; 据题目要求，易得
; 每后项为上一项加上Sn
; 首项是S0，第一个加上去的是S1，即(stream-cdr s)
; 那么可得以下定义

(define (partial-sums s)
    (cons-stream
        (stream-car s)
        (add-stream (partial-sums s)
                    (stream-cdr) s)))