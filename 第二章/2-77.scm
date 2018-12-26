; 前置代码过于繁琐，此题不做调试运行

; 1、为什么做了一堆put后，调用变得可行？

; 在书的p125，我们发现有定义
(define (real-part z) (apply-generic 'real-part z))
(define (imag-part z) (apply-generic 'imag-part z))
(define (magnitude z) (apply-generic 'magnitude z))
(define (angle z) (apply-generic 'angle z))

; 而在处理复数加减乘除操作的包时，并没有添加上面四种针对 【复数 complex】 对象的取值操作
; 下面四行相当于补足了apply-generic的表格
(put 'real-part '(complex) real-part)
(put 'imag-part '(complex) imag-part)
(put 'magnitude '(complex) magnitude)
(put 'angle '(complex) angle)

; 调用时解包一次，去掉(complex)头部，然后再根据次一级的头部判断该用哪种方法处理

; 调用(magnitude z)的求值过程
(magnitude z)                                                   
    (apply-generic 'magnitude z)
        (map type-tag (list z))
        (get 'magnitude '(complex))
        (apply magnitude (map contents (list z)))
            ; 去掉头部后的操作
            (magnitude '(rectangular 3 . 4))
                (apply-generic 'magnitude '(rectangular 3 . 4))
                    (map type-tag (list '(rectangular 3 . 4)))
                    (get 'magnitude '(rectangular))
                    (apply magnitude (map contents (list '(rectangular 3 . 4))))
                        ; 再去掉一层头部，调用rectangular包的magnitude
                        (magnitude '(3 . 4))
                            (sqrt (+ (square (real-part '(3 . 4)))
                            (square (imag-part '(3 . 4)))))
                                5
