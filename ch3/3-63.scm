; 书中原始版本
(define (sqrt-stream x)
    (define guesses
        (cons-stream 1.0 
                     (stream-map (lambda (guess) (sqrt-improve guess x)) 
                                 guesses)))
    guesses)

; 题目中给出版本
(define (sqrt-stream x)
    (cons-stream 1.0
                 (stream-map (lambda (guess) (sqrt-improve guess x))
                             (sqrt-stream x))))

; 区别，第一个版本中，在sqrt-stream 内部绑定了guesses这一约束
; 执行完cons-stream后，guesses约束存在于(sqrt-stream x)的内部
; 当继续执行stream-map时，调用guesses，会从已存在的约束中找guesses。
; 而系统自带的delay会存储计算过的流。也就是guesses的计算结果会被保存起来。当下一次计算时，会直接返回已知值。

; 题目中给出的版本，在stream-map中，每次调用(sqrt-stream x)，都会返回一个全新的流。里面的每一项与之前重复，但是必须从头重新计算
; 这一动作无疑会导致计算量爆炸。

; 如果改掉delay，造成的结果也是计算量爆炸