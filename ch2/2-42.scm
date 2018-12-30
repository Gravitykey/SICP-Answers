;载入组件
(load "flatmap.scm")
(load "enumerate.scm")

;八皇后问题，下面是书上给的框架

(define (queens board-size )
    (define (queen-cols k)
        (if (= k 0)
            (list empty-board)
            (filter 
                (lambda (positions) (safe? k positions))
                (flatmap
                    (lambda (rest-of-queens) 
                        (map (lambda (new-row) 
                                (adjoin-position new-row k rest-of-queens))
                            (enumerate-interval 1 board-size)))
                    (queen-cols (- k 1))))))
    (queen-cols board-size))

;使用到的未定义过程
;empty-board 空棋盘
;safe? k positions 检测当前是否安全
;重点在棋盘的表示以及判断攻击

;表示方法，国际象棋从左下到右上坐标增大，行为 1 2 3 4 5 6 7 8  列为 a b c d e f g h
;设list中的值为行号
;书p85的图可视作 (6 2 7 1 4 8 5 3)

(define empty-board '())

;直接用cons把新加入的插到头部就好
(define (adjoin-position new-row k rest-of-queens)
    (cons new-row rest-of-queens)
)

;判断没有用到书上提供的参数k，直接递归到剩余序列结束。
;因为攻击范围是米字形，然而是在一侧新插入列，其实需要判断的是 - 方向和 < 方向。
;对角方向攻击到的值， 正好是本列皇后位置 加减 到目标列的横向距离
;比如，若本列皇后为3，前一列的2 3 4会受到攻击，再往前一列的 1 3 5 会受到攻击

(define (safe? k positions)
    (let loop( (v (car positions)) (rest (cdr positions)) (distance 1) )
        (if (null? rest)
            #t
            (if (or (= v (car rest))  (= (+ v distance) (car rest))  (= (- v distance) (car rest)))
                #f
                (loop v (cdr rest) (+ 1 distance)))
        )))

(queens 8)

;多做了个计时测试，调用时使用(time-test 10 (real-time-clock))
;n=11时会爆栈 n=10 在deepin 15.8 x64  thinkpad x200s sl9400上面跑 4.3s

(define (time-test n start-time)
    (begin (length(queens n)) (newline) (/ (- (real-time-clock) start-time) 1000.0)))