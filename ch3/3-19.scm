; 常量空间的算法，是龟兔算法，即快慢指针。判断链表有环的常用算法。
; 一个指针每次走一步，另一个走两步。如果有环，那么在环内两个指针总会相遇。
; 如果其中一个指针结束，那么说明没有环。

; 但是！ 这种算法不适用于嵌套的表。与3-18中，第一种方法的情形相似。

(define (cycle? lst)
    (define (self-cdr x)
        (if (pair? x)
            (cdr x)
            '()))
    (define (iter slow fast)
        (cond ((null? slow) #f)
              ((null? fast) #f)
              ((eq? slow fast) #t)
              (else (iter (self-cdr slow) (self-cdr (self-cdr fast))))))
    (iter lst (self-cdr (self-cdr lst))))


; 做环用的过程
(define (last-pair x)
    (if (null? (cdr x))
        x
        (last-pair (cdr x))))
(define (make-cycle x) 
    (set-cdr! (last-pair x) x)
    x)

(define a-cycle (make-cycle (list 'a 'b 'c)))
(define x '(1 2 3 4))

; 测试
(cycle? x);Value: #f
(cycle? a-cycle);Value: #t
(cycle? (make-cycle x));Value: #t