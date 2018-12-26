; 排序集合上union-set的O(n)实现

(define (union-set set1 set2)
    (cond   ((null? set1) set2)
            ((null? set2) set1)
            ((< (car set1) (car set2)) (cons (car set1) (union-set (cdr set1) set2)))        
            ((> (car set1) (car set2)) (cons (car set2) (union-set set1 (cdr set2))))        
            ((= (car set1) (car set2)) (cons (car set1) (union-set (cdr set1) (cdr set2))))))

; 测试

(union-set '(1 3 5 7 9) '(2 4 6 8 10 12))
;Value 13: (1 2 3 4 5 6 7 8 9 10 12)

(union-set '(1 3 5 7 9) '(1 3 5 7 9 11))
;Value 14: (1 3 5 7 9 11)

(union-set '(2 4 6 8 10 12) '(1 3 5 7 9 11))
;Value 15: (1 2 3 4 5 6 7 8 9 10 11 12)

(union-set '() '())
;Value: ()

(union-set '(1 2 3) '())
;Value 16: (1 2 3)

(union-set '() '(1 2 3))
;Value 17: (1 2 3)