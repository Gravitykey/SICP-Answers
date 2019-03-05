; 定义mul-streams
(define (mul-streams s1 s2)
    (stream-map * s1 s2))


; 流是第n个元素的阶乘(从0数)
; (define factorials (cons-stream 1 (mul-streams <??> <??>)))
(define factorials (cons-stream 1 
                        (mul-streams 
                            factorials
                            (stream-cdr integers))))

; 流程
; 流的第一项为 1
; 第二项为 (mul-streams factorials (stream-cdr integers))
;         结果为 (cons-stream 2 (mul-streams 
;                                 (mul-streams factorials (stream-cdr integers))
;                                 (3..4..5..6)))
; 结果正确