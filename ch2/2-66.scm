; 原lookup
(define (lookup given-key set-of-records)
    (cond ((null? set-of-records) false)
        ((equal？ given-key (key (car set-of-records))) (car set-of-records))
        (else (lookup given-key (cdr set-of-records)))))

; 二叉树实现的lookup
(define (lookup-tree given-key tree-of-records)
    (cond ((null? tree-of-records) false)
        ((equal? given-key (key (entry-tree tree-of-records))) (entry-tree tree-of-records))
        ((< given-key (key (entry-tree tree-of-records))) (lookup-tree given-key (left-branch tree-of-records)))
        (else (lookup-tree given-key (right-branch tree-of-records)))))

