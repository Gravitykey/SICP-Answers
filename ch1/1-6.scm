; 新写的new-if
(define (new-if  predicate then-clause else-clause)
    (cond (predicate then-clause)
          (else else-clause)))

; 用这个new-if去求平方根会爆栈
; 因为then-clause和else-clause是从参数传进去的。
; 解释器遇到这两个参数都会执行一次。而题目中说的else-clause是个递归
; 这会导致else-clause会无限执行下去
; 而if 和 cond是解释器自带的语句，只有在需要的时候才会对分支进行求值。
