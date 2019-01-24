; 做环用的过程
(define (last-pair x)
    (if (null? (cdr x))
        x
        (last-pair (cdr x))))
(define (make-cycle x) 
    (set-cdr! (last-pair x) x)
    x)


; 这道题有些歧义
; 如果只是简单的list，不由递归构造(正如书上所说像3-13那种)，那么使用类似3-17的程序稍加修改即可

(define (cycle? x) 
    (define visited '()) 
    (define (iter x) 
      (cond 
        ((and (pair? x) (not (memq x visited)))
            (begin 
            (set! visited (cons x visited))
            (iter (cdr x))))
        ((memq x visited) #t)
        (else #f)))
    (iter x))

; 测试下

(define a-cycle (make-cycle (list 'a 'b 'c)))
(define x '(1 2 3 4))

(cycle? x) ;#f
(cycle? a-cycle) ;#t

; 但是构造如下
(define special (cons a-cycle x))
(cycle? special) ;Value: #f
; 可见，如果car内部包含了环，那么这个过程并不能得出正确的结果
; 如果想试下，此时直接在环境下敲入special并回车，会无限打印刷屏
; 其实嵌套的表，已经不属于通常所说的链表的范畴了，因为car和cdr可以随意设置，得出结构的更像是图。


; 做一下改版
(define (cycle-v2? x) 
    (define visited '()) 
    (define (iter x) 
      (cond 
        ((and (pair? x) (not (memq x visited)))
            (begin 
            (set! visited (cons x visited))
            ; 修改下面这行，增加了对(car x)的判断
            (or (iter (car x))(iter (cdr x)))))
        ((memq x visited) #t)
        (else #f)))
    (iter x))

(cycle-v2? special);Value: #t
(cycle-v2? x);Value: #f
(cycle-v2? a-cycle);Value: #t
; 修正了car内部环测不出的问题，但是引入了新的问题
(cons x x)
;Value 13: ((1 2 3 4) 1 2 3 4)
(cycle-v2? (cons x x));Value: #t ；；；；；；；；；；；这里有问题

;没有环的结构被当成了环 



; 方案3，实测可行
; 不使用set!，不做元素记录
; 此法并非原创，不过确实十分巧妙。可见的缺点，应该是很耗内存。

; 解释一下，方案2的问题，归根到底在于visited里面的数据，是所有递归中的所有过程共用的。
; 环的本质是该元素本身，在起点到达这个元素的【这一条】路径上出现过。而不是在所有路径中被遍历过
; 使用方案3中的cons组成新表去参与递归，而不是用set!，是把每条路径单独分离了，
; 每次执行递归的时候，visited表里面保存着这唯一一条线路，
; 而不是像set!时，所有路径的遍历记录混在一起。

(define (cycle-v3? lst) 
    (define (iter x visited) 
      (cond ((not (pair? x)) #f) 
            ((memq x visited) #t) 
            (else (or (iter (car x) (cons x visited)) 
                      (iter (cdr x) (cons x visited)))))) 
    (iter lst '()))

; 结果符合预期
(cycle-v3? special);Value: #t
(cycle-v3? x);Value: #f
(cycle-v3? (cons x x));Value: #f
(cycle-v3? a-cycle);Value: #t