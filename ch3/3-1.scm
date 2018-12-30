; 做一个累加器
(define (make-accumulator init-val)
    (lambda (x) 
        (begin 
            (set! init-val (+ init-val x)) 
            init-val)))

; 测试
; 1 ]=> (define A (make-accumulator 5))

; ;Value: a

; 1 ]=> (A 10)

; ;Value: 15

; 1 ]=> (A 10)

; ;Value: 25