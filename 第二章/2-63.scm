; 必要的组件

(define (entry tree) (car tree))
(define (left-branch tree) (cadr tree))
(define (right-branch tree) (caddr tree))
(define (make-tree entry left right)
  (list entry left right))

(define (tree->list-1 tree)
  (if (null? tree)
      '()
      (append (tree->list-1 (left-branch tree))
              (cons (entry tree)
                    (tree->list-1 (right-branch tree))))))

(define (tree->list-2 tree)
  (define (copy-to-list tree result-list)
    (if (null? tree)
        result-list
        (copy-to-list (left-branch tree)
                      (cons (entry tree)
                            (copy-to-list (right-branch tree)
                                          result-list)))))
  (copy-to-list tree '()))


; 图2-16的几棵树
(define tree-a  (make-tree 7 
                    (make-tree 3 
                        (make-tree 1 '() '()) 
                        (make-tree 5 '() '())) 
                    (make-tree 9 '() 
                        (make-tree 11 '()  '()))))

(define tree-b  (make-tree 3 
                    (make-tree 1 '() '()) 
                    (make-tree 7 
                        (make-tree 5 '() '()) 
                        (make-tree 9 '() (make-tree 11 '() '())))))

(define tree-c  (make-tree 5 
                    (make-tree 3 
                        (make-tree 1 '() '()) '()) 
                    (make-tree 9 
                        (make-tree 7 '() '())
                        (make-tree 11 '() '()))))

; 测试

(tree->list-1 tree-a)
(tree->list-2 tree-a)

(tree->list-1 tree-b)
(tree->list-2 tree-b)

(tree->list-1 tree-c)
(tree->list-2 tree-c)

; 所有结果都是(1 3 5 7 9 11)

; tree->list-1的算法非常容易理解，即把左树递归展开，连上根节点，再连上递归展开的右树
; tree->list-2的算法是递归到最右面的叶子节点，然后cons上根节点之后，再继续向左cons

; 从效率上讲，第一种算法用了append ，而且做了左右两边分别递归，内存开销比第二种单纯的cons大一些。


