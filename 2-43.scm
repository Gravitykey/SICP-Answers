;载入组件
(load "flatmap.scm")
(load "enumerate.scm")

;拷贝2-42的代码，并改变flatmap里面的顺序

(define (queens board-size )
    (define (queen-cols k)
        (if (= k 0)
            (list empty-board)
            (filter 
                (lambda (positions) (safe? k positions))
                (flatmap
                    (lambda (new-row) 
                        (map (lambda (rest-of-queens) 
                                (adjoin-position new-row k rest-of-queens))
                                (queen-cols (- k 1))))
                    (enumerate-interval 1 board-size)))))
    (queen-cols board-size))



(define empty-board '())

(define (adjoin-position new-row k rest-of-queens)
    (cons new-row rest-of-queens)
)

(define (safe? k positions)
    (let loop( (v (car positions)) (rest (cdr positions)) (distance 1) )
        (if (null? rest)
            #t
            (if (or (= v (car rest))  (= (+ v distance) (car rest))  (= (- v distance) (car rest)))
                #f
                (loop v (cdr rest) (+ 1 distance)))
        )))


;改顺序之后n=7用时 14.5s，改之前0.041s
;改变顺序之后，每次尝试新加一个列k，都会递归调用board-size 次生成（k-1）的解，复杂度变为阶乘


;多做了个计时测试，调用时使用(time-test 10 (real-time-clock))
;2-42题的测试数据
;n=11时会爆栈 n=10 在deepin 15.8 x64  thinkpad x200s sl9400上面跑 4.3s
;n=8 0.177s
(define (time-test n start-time)
    (begin (length(queens n)) (newline) (/ (- (real-time-clock) start-time) 1000.0)))