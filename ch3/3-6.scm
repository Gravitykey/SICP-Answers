; 按书上的写法，做一个伪随机生成器 见155页底部注释
; 该方法也叫LCG法，可以搜索有关资料 
(define (rand-update x) 
    (let ((a 16807) (b 1) (m 65536)) 
        (modulo (+ (* a x) b) m))) 
  
; 生成一个闭包
(define (rand-factory) 
    (let ((seed 0)) 
        (define (dispatch m) 
            (cond ((eq? m 'reset) (lambda (x)(set! seed x))) 
                ((eq? m 'generate) (begin (set! seed (rand-update seed)) 
                                        seed)) 
                (else error "invalid operation" m))) 
        dispatch))

; 绑定rand
(define rand (rand-factory))

; 测试
; 默认随机种子是0
(rand 'generate)
;Value: 1
(rand 'generate)
;Value: 16808
(rand 'generate)
;Value: 31897

; 把种子重置为0

((rand 'reset) 0)
;Value: 31897
; set!的返回值是赋值之前的值，所以这里是上次的随机结果

(rand 'generate)
 ;Value: 1

(rand 'generate) 
;Value: 16808

;生成结果跟第一次相同

; 换种子666 
((rand 'reset) 666)

(rand 'generate)
;Value: 52343
(rand 'generate) 
;Value: 39074

; 再次重置为666
((rand 'reset) 666)
 
(rand 'generate) 
;Value: 52343
(rand 'generate) 
;Value: 39074