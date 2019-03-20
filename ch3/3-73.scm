(define ones (cons-stream 1 ones))
(define (scale-stream stream factor)
    (stream-map (lambda (x) (* x factor)) stream))
(define (add-streams s1 s2)(stream-map + s1 s2))



(define (RC r c dt)
    (define (ints s-i v0)
        (define inner
        (cons-stream (+ v0 (* r (stream-car s-i)))
                     (add-streams (scale-stream s-i (/ dt c))
                                  inner)))
        inner)
    ints)

; 测试
(define rc1 (rc 5 1 0.5))
(define l (rc1 ones 3))
(stream-head l 10)
;Value 13: (8 8.5 9. 9.5 10. 10.5 11. 11.5 12. 12.5)
; 结果正确