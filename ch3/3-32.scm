; 先来看一下and-gate的代码
(define (and-gate a1 a2 output)
  (define (and-action-procedure)
    (let ((new-value (logical-and (get-signal a1) (get-signal a2))))
      (after-delay and-gate-delay 
        (lambda()
          (set-signal! output new-value)))))
  (add-action! a1 and-action-procedure)
  (add-action! a2 and-action-procedure))

; 
; 从0，1变为1,0
; FIFO时的发生顺序：
; a1 0 -> 1  a2=1 output -> 1
; a2 1 -> 0  a1=1 output -> 0
; LIFO时发生顺序：
; a2 1 -> 0  a1=0 output -> 0
; a1 0 -> 1  a2=0 output -> 0

; 这两种顺序下，output的状态不完全相同
; FIFO时，output的值会发生0->1->0的变化，0->1时，set-signal!会向后传播动作
; 这一点与设计and-gate时，添加action时的顺序相同
; 而LIFO时output不会发生变化

; 这两种状态不完全等价。

; 其实可以看出，在模拟的过程中，因为使用了赋值语句来保存状态，其先后顺序会导致状态变化。
; 后面的语句依赖于前面的语句的执行结果来确定自己的结果。
; 这也就是前面章节说的set!的副作用。
; 而FIFO顺序是严格按照定义时的顺序执行的。LIFO则不是

