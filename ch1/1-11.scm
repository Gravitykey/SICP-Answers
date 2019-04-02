; 递归版本
(define (f n)
    (if (< n 3)
        n
        (+ (f (- n 1))
           (* 2 (f (- n 2)))
           (* 3 (f (- n 3))))))

; 迭代版本，从小往大算
(define (p n)
    (p-iter 2 1 0 0 n))

(define (p-iter a b c i n)
    (if (= i n)
        c
        (p-iter (+ a (* 2 b) (* 3 c)) 
                a
                b
                (+ i 1)
                n)))
