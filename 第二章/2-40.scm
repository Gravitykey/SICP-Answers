;导入p83的内容
(load "p83.scm")

(define (unique-pairs n)
    (flatmap (lambda (i) 
                (if (null? i)
                    '()
                    (map (lambda (j) 
                            (list i j)) 
                        (enumerate-interval 1 (- i 1))))) 
        (enumerate-interval  1 n)))

;重新定义 prime-sum-pairs
(define (prime-sum-pairs n)
    (map make-pair-sum (filter prime-sum? (unique-pairs n))))

;(prime-sum-pairs 12)