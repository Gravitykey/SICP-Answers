; 对于可重复的表

; element-of-set？可以继续使用之前的
(define (element-of-set? x set)
    (cond   ((null? set) #f)
            ((equal? x (car set)) #t)
            (else (element-of-set? x (cdr set)))))

; adjoin-set可以省略查找是否存在的步骤
(define (adjoin-set x set) (cons x set))

; union-set可以省略去重
(define (union-set set1 set2)
    (cond ((null? set1) set2)
        ((null? set2) set1)
        (else (cons (car set1) (union-set (cdr set1) set2)))))

; intersection-set 交集
; 为了去重，需要加一个result
(define (intersection-set set1 set2)
    (define (loop set1 set2 result)
        (cond  ((or (null? set1) (null? set2)) result)
                ((and   (element-of-set? (car set1) set2)
                        (not (element-of-set? (car set1) result))) 
                    (loop (cdr set1) set2  (cons (car set1) result)))
                (else (loop (cdr set1) set2 result))))
    (loop set1 set2 '())
)

; 测试
(adjoin-set 3 '(3 4 5 6))
;Value 13: (3 3 4 5 6)

(union-set '(1 2 3 4) '(3 4 5 6))
;Value 14: (1 2 3 4 3 4 5 6)

(intersection-set '(1 2 3 4 2 3) '(3 4 5 6 7 3 4))
;Value 15: (4 3)

; 这种结构频繁插入时效率会高一些，但是内存开销太大。重复数据少的时候会合算一些。
; 求交集时复杂度会增加，因为要去重，需要在已求出的结果里面多查找一次

; 总而言之数据量只要大了，没什么实用价值
