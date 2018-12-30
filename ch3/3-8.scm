; 定义一个求值顺序影响结果的过程


; 方便对比，做出两个完全相同的fa和fb

(define (fs)
    (let((m 3))(lambda(x) (set! m (+ m x)))))

(define fa (fs))
(define fb (fs))

(+ (fa 0) (fa 1))
; 结果是7
(+ (fb 1) (fb 0))
; 结果是6