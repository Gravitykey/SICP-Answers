; 将元素插入有序集合
(define (adjoin-set x set)
    (cond ((null? set) (cons x set))
        ((= x (car set)) set)
        ((> x (car set)) (cons (car set) (adjoin-set x (cdr set))))
        (else (cons x set))    
    ))


; 测试

(adjoin-set 5 '(1 2 3 4 6 7))
;Value 13: (1 2 3 4 5 6 7)

(adjoin-set 5 '())
;Value 14: (5)

(adjoin-set 5 '(1 2 3 4))
;Value 15: (1 2 3 4 5)

(adjoin-set 5 '(1 2 3 4 5))
;Value 16: (1 2 3 4 5)

(adjoin-set 1 '(2 3 4))
;Value 17: (1 2 3 4)

(adjoin-set 7(adjoin-set 3 (adjoin-set 5 '())))
;Value 18: (3 5 7)