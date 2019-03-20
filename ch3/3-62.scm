; 根据3-61
; S·X = 1
; X = 1 / S
; 设有S1
; S1 / S  =  S1 · X

(load "3-61.scm")

(define (div-series s1 s2)
    (cond ((eq? 0 (stream-car s2)) (error "constant term of s2 can't be 0!"))
          (else (mul-series s1 (daoshu s2)))))

; 测试
(define sine-series (cons-stream 0 (integrate-series cosine-series)))
(define cosine-series (cons-stream 1 (integrate-series (stream-map (lambda (x) (* x -1)) sine-series))))
(define (add-streams s1 s2)(stream-map + s1 s2))

(define (integrate-series stm)
    (define (inner s a)
        (cons-stream (* (/ 1 a) (stream-car s)) 
                     (inner (stream-cdr s) (+ a 1))))
    (inner stm 1))

; 设构造tan的级数
(define tan-series (div-series sine-series cosine-series))
(stream-head tan-series 10)
;Value 13: (0 1 0 1/3 0 2/15 0 17/315 0 62/2835)
; 结果正确！