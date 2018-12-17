;p34的质数算法，用费马法实现


(define (prime? n)
    (define (expmod base exp m)
        (cond ((= exp 0) 1)
            ((even? exp) 
                (remainder(square (expmod base (/ exp 2) m)) m))
            (else (remainder (* base (expmod base (- exp 1) m)) m)
            )))

    (define (fermat-test n)
        (define (try-it a)
            (= (expmod a n n) a))
        (try-it (+ 1 (random (- n 1))))
    )

    (define (fast-prime? n times)
        (cond ((= times 0) #t)
                ((fermat-test n) (fast-prime? n (- times 1)))
                (else #f)
        ))
    (fast-prime? n 8))


;times给小了容易出问题，尤其是遇到小数字。如果不嫌麻烦可以分开定义，100以下用开方法。
;times给5的时候有很大概率把6算成质数，数越小，times越小，出错概率越大。
;给大了会影响计算效率。100以上给5应该就可以了,实测200000次可以pass
;下面是一个测试用的，可以传入t

(define (prime-for-test-run? n t)
    (define (expmod base exp m)
        (cond ((= exp 0) 1)
            ((even? exp) 
                (remainder(square (expmod base (/ exp 2) m)) m))
            (else (remainder (* base (expmod base (- exp 1) m)) m)
            )))

    (define (fermat-test n)
        (define (try-it a)
            (= (expmod a n n) a))
        (try-it (+ 1 (random (- n 1))))
    )

    (define (fast-prime? n times)
        (cond ((= times 0) #t)
                ((fermat-test n) (fast-prime? n (- times 1)))
                (else #f)
        ))
    (fast-prime? n t))




(define (times-test n times times-to-run)
    (let loop((x times-to-run)) 
        (if(= x 0)
            (display "passed")
            (if(prime-for-test-run? n times)
                (display "BOOM")
                (loop(- x 1))))))

;(times-test 100 5 200000)

; (prime? 17)
; (prime? 9)
; (prime? 7)
; (prime? 5)
; (prime? 11)
; (prime? 7889732)

;(prime? 100001651)