(define (subsets s)
    (if (null? s)
        (list '()) ;这一行写成 '()会出问题,刚开始lambda写对了，发现这里卡了。
        (let ( (rest (subsets (cdr s))) )
            (append rest (map (lambda (x) (cons (car s) x)) rest)))))

(subsets '(1 2 3))
;Value 13: (() (3) (2) (2 3) (1) (1 3) (1 2) (1 2 3))

;卡空序列的原因，'()  和 (list '()) 并不等价
;前者是一个元素，后者是一个序列