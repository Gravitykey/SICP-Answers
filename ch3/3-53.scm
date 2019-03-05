#| 
描述元素:
(define s (cons-stream 1 (add-streams s s)))


(stream-car s) 值为 1
(stream-cdr s) 值为 (add-streams s s)
    即(add-streams
         (cons-stream 1 (add-streams s s)
         (cons-stream 1 (add-streams s s)))
    执行一次结果为
    (cons-stream 2 (add-streams (add-streams s s) (add-streams s s)))

    (add-streams s s)的值已求，即上面一行
    那么流的下一项 的stream-car 值为4
    同理，流的元素为
    1,2,4,8,16...即2的n-1次方

|#