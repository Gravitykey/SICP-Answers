; 2-62做了有序表的O(n)的合并算法
; 2-63 2-64的树转表，表转树都是O(n)复杂度的

; 则要实现O(n)复杂度的树的并交处理，只要实现 树->表->处理->树 的步骤就好

; 实现前面缺少的O(n)的有序表相交

(define (intersection-set set1 set2)
    (cond   ((null? set1) '())
            ((null? set2) '())
            ((< (car set1) (car set2)) (intersection-set (cdr set1) set2))        
            ((> (car set1) (car set2)) (intersection-set set1 (cdr set2)))        
            ((= (car set1) (car set2)) (cons (car set1) (intersection-set (cdr set1) (cdr set2))))))

; 测试 (intersection-set '(1 2 3 4 5 6 7 8) '(2 4 6 8 10))
; Value 13: (2 4 6 8)

; 复制2-62的并集
(define (union-set set1 set2)
    (cond   ((null? set1) set2)
            ((null? set2) set1)
            ((< (car set1) (car set2)) (cons (car set1) (union-set (cdr set1) set2)))        
            ((> (car set1) (car set2)) (cons (car set2) (union-set set1 (cdr set2))))        
            ((= (car set1) (car set2)) (cons (car set1) (union-set (cdr set1) (cdr set2))))))

; 复制2-63 2-64的树处理
(define (entry tree) (car tree))
(define (left-branch tree) (cadr tree))
(define (right-branch tree) (caddr tree))
(define (make-tree entry left right)
  (list entry left right))

(define (tree->list tree)
  (define (copy-to-list tree result-list)
    (if (null? tree)
        result-list
        (copy-to-list (left-branch tree)
                      (cons (entry tree)
                            (copy-to-list (right-branch tree)
                                          result-list)))))
  (copy-to-list tree '()))


(define (partial-tree elts n)
  (if (= n 0)
      (cons '() elts)
        ;quotient 是取商数 
      (let ((left-size (quotient (- n 1) 2)))
        (let ((left-result (partial-tree elts left-size)))
          (let ((left-tree (car left-result))
                (non-left-elts (cdr left-result))
                (right-size (- n (+ left-size 1))))
            (let ((this-entry (car non-left-elts))
                  (right-result (partial-tree (cdr non-left-elts)
                                              right-size)))
              (let ((right-tree (car right-result))
                    (remaining-elts (cdr right-result)))
                (cons (make-tree this-entry left-tree right-tree)
                      remaining-elts))))))))

(define (list->tree elements)
    (car (partial-tree elements (length elements))))

; 组合
(define (intersection-tree tree1 tree2)
    (list->tree (intersection-set (tree->list tree1) (tree->list tree2))))
    
(define (union-tree tree1 tree2)
    (list->tree (union-set (tree->list tree1) (tree->list tree2))))

; 测试
(define tree-a (list->tree '(1 3 5 7 9 11)))
(define tree-b (list->tree '(2 4 6 8 9 10 11 12)))

(intersection-tree tree-a tree-b)
;Value 13: (9 () (11 () ()))
(union-tree tree-a tree-b)
;Value 14: (6 (3 (1 () (2 () ())) (4 () (5 () ()))) (9 (7 () (8 () ())) (11 (10 () ()) (12 () ()))))