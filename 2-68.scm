(load "p112.scm")
(define sample-tree 
    (make-code-tree (make-leaf 'A 4)
                    (make-code-tree
                        (make-leaf 'B 2)
                        (make-code-tree
                            (make-leaf 'D 1)
                            (make-leaf 'C 1)))))

(define sample-message '( 0 1 1 0 0 1 0 1 0 1 1 1 0))


; 书上给的编码框架
(define (encode message tree)
    (if (null? message)
        '()
        (append (encode-symbol (car message) tree)
                (encode (cdr message) tree))))



; 需要自己编写encode-symbol
; 编写in?谓词，判断是否在左右的符号中，如果symbols只有一个，那么可以返回结果了。
(define (encode-symbol symbol tree)
    (define (in? x lst)
        (if(null? lst) #f 
            (if (eq? x (car lst)) #t (in? x (cdr lst)))))
    (define (loop symbol tree res)
        (cond   ((null? tree) (error "Bad tree,or Bad symbol --" symbol))
                ((null? (cdr (symbols tree))) res)
                ((in? symbol (symbols (left-branch tree)))
                    (loop symbol (left-branch tree) (append res '(0))))
                ((in? symbol (symbols (right-branch tree)))
                    (loop symbol (right-branch tree) (append res '(1))))
                (else (error "Bad symbol --" symbol))))
    (loop symbol tree '()))


; 测试

(encode  '(a d a b b c a) sample-tree)
;Value 14: (0 1 1 0 0 1 0 1 0 1 1 1 0)  与2-67相同

(encode-symbol 'a sample-tree)
;Value 15: (0)

(encode-symbol 'b sample-tree)  
;Value 16: (1 0)

(encode-symbol 'c sample-tree)
;Value 17: (1 1 1)

(encode-symbol 'd sample-tree)
;Value 18: (1 1 0)

(encode-symbol 'AFF sample-tree)
;Bad symbol -- aff