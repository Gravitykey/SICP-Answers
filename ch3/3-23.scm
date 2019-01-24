; 双端队列
; 需使用双向链表

; 构建双向链表的节点
(define (make-node item prev) (cons item prev))
(define (get-node-prev node) (cdr node))
(define (get-node-item node) (car node))
(define (set-node-prev! node prev-node) (set-cdr! node prev-node))


; 操作链表的过程
(define (front-ptr deque) (car deque))
(define (rear-ptr deque) (cdr deque))
(define (set-front-ptr! deque node) (set-car! deque node))
(define (set-rear-ptr! deque node) (set-cdr! deque node))
(define (empty-deque? deque) (null? (front-ptr deque)))
(define (make-deque) (cons '() '()))

(define (front-deque deque)
  (if (empty-deque? deque)
      (error "FRONT called with an empty deque" (print-deque deque))
      (get-node-item (car (front-ptr deque)))))
(define (rear-deque deque)
  (if (empty-deque? deque)
      (error "REAR called with an empty deque" (print-deque deque))
      (get-node-item (car (rear-ptr deque)))))

(define (front-insert-deque! deque item)
    (let ((new-pair (cons (make-node item '()) '())))
        (cond ((empty-deque? deque)
               (set-front-ptr! deque new-pair)
               (set-rear-ptr! deque new-pair)
               "front insert done")
            (else
               (set-node-prev! (car (front-ptr deque)) new-pair )
               (set-cdr! new-pair (front-ptr deque))
               (set-front-ptr! deque new-pair)
               "front insert done"))))

(define (rear-insert-deque! deque item)
    (let ((new-pair (cons (make-node item '()) '())))
        (cond ((empty-deque? deque)
               (set-front-ptr! deque new-pair)
               (set-rear-ptr! deque new-pair)
               "rear insert done")
              (else
               (set-node-prev! (car new-pair) (rear-ptr deque))
               (set-cdr! (rear-ptr deque) new-pair)
               (set-rear-ptr! deque new-pair)
               "rear insert done"))))

(define (front-delete-deque! deque)
    (cond ((empty-deque? deque)
            (error "DELETE! called with an empty deque" (print-deque deque)))
          ((null? (cdr (front-ptr deque)))
            (set-front-ptr! deque '())
            (set-rear-ptr! deque '())
            "deque now empty")
          (else
            (set-node-prev! (cadr (front-ptr deque)) '()) 
            (set-front-ptr! deque (cdr (front-ptr deque)))
            "front delete done")))

(define (rear-delete-deque! deque)
    (cond ((empty-deque? deque)
            (error "DELETE! called with an empty deque" (print-deque deque)))
          ((null? (cdr (front-ptr deque)))
            (set-front-ptr! deque '())
            (set-rear-ptr! deque '())
            "deque now empty")
          (else (set-rear-ptr! deque (get-node-prev (car (rear-ptr deque))))
                (set-cdr! (rear-ptr deque) '())
                "rear delete done")))

; 必须做一个打印过程，否则直接返回列表，解释器尝试输出时会无限递归
(define (print-deque deque)
    (map  (lambda (x) (get-node-item x)) (front-ptr deque)))



; 测试
(define dq1 (make-deque))
(front-insert-deque! dq1 'f1)
(print-deque dq1)
(front-insert-deque! dq1 'f2)
(print-deque dq1)
(rear-insert-deque! dq1 'r1)
(print-deque dq1)
(rear-insert-deque! dq1 'r2)
(front-deque dq1)
(rear-deque dq1)
(print-deque dq1)
(front-delete-deque! dq1)
(print-deque dq1)
(rear-delete-deque! dq1)
(print-deque dq1)
(front-delete-deque! dq1)
(print-deque dq1)
(rear-delete-deque! dq1)
(print-deque dq1)
(front-delete-deque! dq1)


; ;;;;;;;;;;;;;;;;测试序列，结果符合预期
; 1 ]=> ; 测试
; (define dq1 (make-deque))
; ;Value: dq1

; 1 ]=> (front-insert-deque! dq1 'f1)
; ;Value 13: "front insert done"

; 1 ]=> (print-deque dq1)
; ;Value 14: (f1)

; 1 ]=> (front-insert-deque! dq1 'f2)
; ;Value 15: "front insert done"

; 1 ]=> (print-deque dq1)
; ;Value 16: (f2 f1)

; 1 ]=> (rear-insert-deque! dq1 'r1)
; ;Value 17: "rear insert done"

; 1 ]=> (print-deque dq1)
; ;Value 18: (f2 f1 r1)

; 1 ]=> (rear-insert-deque! dq1 'r2)
; ;Value 17: "rear insert done"

; 1 ]=> (front-deque dq1)
; ;Value: f2

; 1 ]=> (rear-deque dq1)
; ;Value: r2

; 1 ]=> (print-deque dq1)
; ;Value 19: (f2 f1 r1 r2)

; 1 ]=> (front-delete-deque! dq1)
; ;Value 20: "front delete done"

; 1 ]=> (print-deque dq1)
; ;Value 21: (f1 r1 r2)

; 1 ]=> (rear-delete-deque! dq1)
; ;Value 22: "rear delete done"

; 1 ]=> (print-deque dq1)
; ;Value 23: (f1 r1)

; 1 ]=> (front-delete-deque! dq1)
; ;Value 20: "front delete done"

; 1 ]=> (print-deque dq1)
; ;Value 24: (r1)

; 1 ]=> (rear-delete-deque! dq1)
; ;Value 25: "deque now empty"

; 1 ]=> (print-deque dq1)
; ;Value: ()

; 1 ]=> (front-delete-deque! dq1)
; ;DELETE! called with an empty deque ()
; ;To continue, call RESTART with an option number:
; ; (RESTART 1) => Return to read-eval-print level 1.
