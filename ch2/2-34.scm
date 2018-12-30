(load "accumulate.scm")

(define (hornel-eval x coefficient-sequence)
    (accumulate 
        (lambda(this-coeff higher-terms)
            (+ this-coeff (* higher-terms x))
        )
        0
        coefficient-sequence))

;测试
(hornel-eval 2 '(1 3 0 5 0 1))
;Value: 79  // 1 + 3*2 + 5*8 + 32 


