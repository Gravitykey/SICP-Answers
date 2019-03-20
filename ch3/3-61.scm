; 前置过程
(define (scale-stream stream factor)
    (stream-map (lambda (x) (* x factor)) stream))

(define (mul-series s1 s2)
    (cons-stream (* (stream-car s1) (stream-car s2))
                 (add-streams (scale-stream (stream-cdr s2) (stream-car s1)) 
                                          (mul-series (stream-cdr s1) s2))))

; 根据X=1-Sr * X
(define (daoshu s)
    (cons-stream 1 (mul-series (scale-stream  (stream-cdr s) -1) (daoshu s))))

