; 书上给出的fibs
(define fibs 
  (cons-stream 0
               (cons-stream 1
                            (add-streams (stream-cdr fibs)
                                         fibs))))

; 因为有记忆优化，每次求一项时，只需计算一次。前面的项可以由记忆直接返回
; 如果不使用记忆，那么每计算第n项，必须重新计算n-1项
; 这时斐波那契数列的每一项的数值为该项需要计算的次数
; 其复杂度约为黄金比例的O(1.618^n)

