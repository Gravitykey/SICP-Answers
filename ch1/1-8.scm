(define (cube x)
    (* x x x))

(define (cube-root x)
    (cube-root-iter 1.0 x))

(define (cube-root-iter guess x)
    (if (good-enough? guess x)
        guess
        (cube-root-iter (improve guess x)
                        x)))

(define (good-enough? guess x)
    (< (abs (- (cube guess) x))
       0.001))

(define (improve guess x)
    (/ (+ (/ x (square guess)) (* 2 guess))
       3))

; 测试
(cube-root (* 6 6 6))
(cube-root (* 2 2 2))
(cube-root (* 62 62 62))

; 1 ]=> ; 测试
; (cube-root (* 6 6 6))
; ;Value: 6.000000000047538

; 1 ]=> (cube-root (* 2 2 2))
; ;Value: 2.000004911675504

; 1 ]=> (cube-root (* 62 62 62))
; ;Value: 62.00000000000001
