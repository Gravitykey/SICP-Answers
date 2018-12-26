(define (square-tree tree)
    (tree-map square tree))

;实现部分
(define (tree-map proc tree)
    (if (null? tree)
        '()
        (if (pair? tree)
            (cons (tree-map proc (car tree)) (tree-map proc (cdr tree)))
            (proc tree))))

(define (square x)
    (* x x))

;测试
(square-tree '(1 2 3 (4 5 (6 7) 8) 9))
;Value 13: (1 4 9 (16 25 (36 49) 64) 81)
