; 使用闭包重写队列
; 由于历史原因，书上给的代码在当前的mit-scheme内部不能运行。
; 在当今的mit-scheme内，let内部不能再使用define，所以头部需要更改
(define (make-queue)
  (define front-ptr '())
  (define rear-ptr '())
    (define (set-front-ptr! item) (set! front-ptr item))
    (define (set-rear-ptr! item) (set! rear-ptr item))
    (define (empty-queue?) (null? front-ptr))
    (define (front-queue)
      (if (empty-queue?)
        (error "FRONT called with an empty queue" front-ptr)
        (car front-ptr)))
    (define (insert-queue! item)
        (let ((new-pair (cons item '())))
            (cond ((empty-queue?)
                (set-front-ptr! new-pair)
                (set-rear-ptr! new-pair)
                front-ptr)
                (else
                (set-cdr! rear-ptr new-pair)
                (set-rear-ptr! new-pair)
                front-ptr))
        ))
    (define (delete-queue!)
        (cond ((empty-queue?)
                (error "DELETE! called with an empty queue"))
            (else (set-front-ptr! (cdr front-ptr)) "done...")))

    (define (dispatch m)
      (cond ((eq? m 'empty?) (empty-queue?))
            ((eq? m 'print) front-ptr)
            ((eq? m 'insert) insert-queue!)
            ((eq? m 'delete) (delete-queue!))
            ((eq? m 'front) (front-queue))
            (else (error "No such method --" m))
      ))
    dispatch)

; 测试
(define q1 (make-queue))
(q1 'empty?)
((q1 'insert) 3)
((q1 'insert) 4)
(q1 'front)
(q1 'print)
(q1 'delete)
(q1 'print)
(q1 'empty?)
(q1 'delete)
(q1 'delete)
; ; ;;;;;;;;;;;;;;;;结果
; 1 ]=> ; 测试
; (define q1 (make-queue))
; ;Value: q1

; 1 ]=> (q1 'empty?)
; ;Value: #t

; 1 ]=> ((q1 'insert) 3)
; ;Value 13: (3)

; 1 ]=> ((q1 'insert) 4)
; ;Value 13: (3 4)

; 1 ]=> (q1 'front)
; ;Value: 3

; 1 ]=> (q1 'print)
; ;Value 13: (3 4)

; 1 ]=> (q1 'delete)
; ;Value 14: "done..."

; 1 ]=> (q1 'print)
; ;Value 15: (4)

; 1 ]=> (q1 'empty?)
; ;Value: #f

; 1 ]=> (q1 'delete)
; ;Value 14: "done..."

; 1 ]=> (q1 'delete)
; ;DELETE! called with an empty queue
; ;To continue, call RESTART with an option number:
; ; (RESTART 1) => Return to read-eval-print level 1.
