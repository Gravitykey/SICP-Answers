(load "p112.scm")
; 以对偶表为参数，生成Huffman树

; 书上给出的框架

(define (generate-huffman-tree pairs)
    (successive-merge (make-leaf-set pairs)))

; 想法：先将对生成为节点，然后依次插入有序序列
; 结束后从序列最开始取两个，组成树，然后插回序列，直到序列中剩一个元素，即为树

(define (successive-merge nodes)
    ; 做一个排序过程先排序
    (define (build-set items pair-sets)
        (if (null? items)
        pair-sets
        (build-set (cdr items) (adjoin-set (car items) pair-sets))))
    
    (define (loop res)
        (if (null? (cdr res))
            (car res) ; 这里不做car，会多包装一层括号
            (loop (adjoin-set (make-code-tree (car res) (cadr res)) (cddr res)))
        ))
    
    (loop (build-set nodes '() )))


; 测试
(generate-huffman-tree '((A 4) (B 2) (C 1) (D 1)))
;Value 13: ((leaf a 4) ((leaf b 2) ((leaf d 1) (leaf c 1) (d c) 2) (b d c) 4) (a b d c) 8)

(generate-huffman-tree '((C 1) (B 2) (D 1) (A 4)))
;Value 14: ((leaf a 4) ((leaf b 2) ((leaf d 1) (leaf c 1) (d c) 2) (b d c) 4) (a b d c) 8)

