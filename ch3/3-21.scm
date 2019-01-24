(load "queue.scm")

(define q1 (make-queue))
(insert-queue! q1 'a)

(insert-queue! q1 'b)

(delete-queue! q1)

(delete-queue! q1)

; 因为队列的表示只是单纯的cons起头指针和尾指针
; 所以直接打印队列，出现的是队列元素，以及末尾元素
; 由于队列元素是以'()结尾，末尾元素作为队列的最后一个pair，其内部cdr也为'()
; 删除元素的操作，只是把头部指针设置为它当前的头部pair的cdr。此时并没有处理尾部指针
; 而队列中只有1个元素时，头尾指针都是这一个。删空队列时，指向队尾的指针依旧没有改变
; 于是就有了;Value 13: (() b)这种表示

; 那么可以如此定义print-queue
(define (print-queue queue)
    (front-ptr queue))

(define q2 (make-queue))
(print-queue (insert-queue! q1 'a))
;Value 14: (a)
(print-queue (insert-queue! q1 'b))
;Value 14: (a b)
(print-queue (delete-queue! q1))
;Value 15: (b)
(print-queue (delete-queue! q1))
;Value: ()
(print-queue (insert-queue! q1 'c))
;Value 16: (c)