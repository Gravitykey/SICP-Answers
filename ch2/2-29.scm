(define (make-mobile left right)
    (list left right))

(define (make-branch len structure)
    (list len structure))
;自定义部分
;
;左分支
(define (left-branch mobile)
    (car mobile))
;右分支
(define (right-branch mobile)
    (cadr mobile))

;长度
(define (branch-length branch)
    (car branch))
;构件
(define (branch-structure branch)
    (cadr branch))

;总重量
(define (total-weight structure)
    (let loop((x structure))
        (if(pair? x)
            (+ (loop (branch-structure (left-branch x)))
                (loop (branch-structure (right-branch x))))
            x
        )
    )
)

;平衡
;计算力矩
(define (torque branch)
    (* (branch-length branch) (total-weight (branch-structure branch))))

(define (balance? structure)
    (let loop((x structure))
        (if (pair? x)
            (and (= (torque (left-branch x)) (torque(right-branch x)))
                (and (loop (branch-structure( left-branch x))) 
                    (loop (branch-structure( right-branch x)))
                )
            )
            #t
        )
    )
)

;平衡
(define m (make-mobile (make-branch 10 20)( make-branch 10 20)))
;平衡
(define n (make-mobile 
            (make-branch 10 (make-mobile 
                                (make-branch 4 5) 
                                (make-branch 5 4)
                            )
            ) 
            ( make-branch 10 9 )))
;不平衡
(define p (make-mobile (make-branch 1 1) (make-branch 2 2)))

(balance? m)
(balance? n)
(balance? p)


;改变构造方式
(define (make-mobile left right)
    (cons left right))
(define (make-branch len structure)
    (cons len structure))

;*************下面是需要动手改动的地方**********

;左分支
(define (left-branch mobile)
    (car mobile))
;右分支
(define (right-branch mobile)
    (cdr mobile))

;长度
(define (branch-length branch)
    (car branch))
;构件
(define (branch-structure branch)
    (cdr branch))


;新测试(直接复制，但是改掉名称)
(define m2 (make-mobile (make-branch 10 20)( make-branch 10 20)))

(define n2 (make-mobile 
            (make-branch 10 (make-mobile 
                                (make-branch 4 5) 
                                (make-branch 5 4)
                            )
            ) 
            ( make-branch 10 9 )))

(define p2 (make-mobile (make-branch 1 1) (make-branch 2 2)))

(balance? m2)
(balance? n2)
(balance? p2)
