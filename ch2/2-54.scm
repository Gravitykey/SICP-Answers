;自定义一个equal

;如果一个为空，另一个不为空，返回f
;如果一个是pair，另一个不是，返回f
;如果都是pair，递归pair内容
;如果相等，递归下一个元素
;如果都是空，返回t

(define (my-equal? seq1 seq2)
    (cond 
          ;二者一空一不空
          ((and 
            (or (null? seq1) (null? seq2))
            (not (and (null? seq1) (null? seq2))))
            #f) 
          ;二者一个是pair一个不是
          ((and
            (or (pair? seq1) (pair? seq2))
            (not (and (pair? seq1) (pair? seq2))))
            #f)
          ;二者都是pair
          ((and (pair? seq1) (pair? seq2))
            (if(my-equal? (car seq1) (car seq2)) (my-equal? (cdr seq1) (cdr seq2)) #f))
          ;二者皆空
          ((and (null? seq1) (null? seq2)) #t)
          ;最后直接对比
          (else (eq? seq1 seq2))
    )   
)

;测试

(eq?
  (equal? '(this is a list) '(this is a list) )
  (my-equal? '(this is a list) '(this is a list) )
)

(eq?
  (equal? '(this is a list) '(this (is a) list) )
  (my-equal? '(this is a list) '(this (is a) list) )
)

(eq?
  (equal? '(1 2 3) '(1 2 3) )
  (my-equal? '(1 2 3) '(1 2 3) )
)

(eq?
  (equal? '(1 2 (3)) '(1 2 (3)) )
  (my-equal? '(1 2 (3)) '(1 2 (3)) )
)

(eq?
  (equal? '() '() )
  (my-equal? '() '() )
)

(eq?
  (equal? 65 65)
  (my-equal? 65 65)
)

;以上测试全部为#t