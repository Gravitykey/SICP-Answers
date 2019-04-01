; 丘奇计数

; zero,它的参数是一个函数f，该函数需要一个x参数，f不对x做任何操作
(define zero (lambda(f) (lambda (x) x)))

; add-1 它的参数是n和f，该函数做完 ((n f) x) 之后，会对结果再做一次(f result)
(define (add-1 n)
    (lambda (f) 
        (lambda (x) 
            (f ((n f) x)))))

; 将zero代入add-1中，得到(add-1 zero)即
(lambda (f) 
    (lambda (x)
        (f 
            ; 下面是展开((n f)x)
            ; 第一步展开n成 (([lambda(f) (lambda(x) x)] f) x)
            ; 继续向内层代入 ([lambda(x) x] x)
            ; 得到最终结果
            x
        )))
; 即，(add-1 zero)最后的结果为one
(define one 
    (lambda (f)
        (lambda (x)
            (f x))))

; 定义two，即(add-1 one),用类似方法带入
(define two
    (lambda (f)
        (lambda (x)
            (f (f x)))))

; 那么参照add-1来定义plus过程
; add-1是做完 ((n f) x) 之后，会对结果再做一次(f result)
; 那么做m次(f result)即 n+m

(define (plus m n)
    (lambda (f)
        (lambda (x)
            ((m f) ((n f) x)))))


; 测试
; 定义f是打印 x是星号
(define (f x) (begin (newline)(display "--print-- ")(display x) x))
(define x '*)

((zero f) x)
((one f) x)
((two f) x)
(((plus two two) f) x)

; 1 ]=> ((zero f) x)
; ;Value: *

; 1 ]=> ((one f) x)
; --print-- *
; ;Value: *

; 1 ]=> ((two f) x)
; --print-- *
; --print-- *
; ;Value: *

; 1 ]=> (((plus two two) f) x)
; --print-- *
; --print-- *
; --print-- *
; --print-- *
; ;Value: *
