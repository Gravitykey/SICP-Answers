;生成相异的三元组 i，j，k使得和为s
;题目要求有序，所以不能单纯套用2-40中定义出的unique-pairs，干脆敲掉重写。
;穷举i，j，k，在下一轮循环中，敲掉已经出现过的数

(load "flatmap.scm")
(load "enumerate.scm")
(define (remove item seq)
    (filter (lambda (x) (not (= x item))) seq))

(define (three-equals-s n s)
    (define (make-triple n s)
        (flatmap (lambda (i)
            (flatmap (lambda (j)
                (map (lambda (k)
                        (list i j k)) 
                    ;第三层循环取 n和 s-i-j 二者里面较小的数
                    (remove j (remove i (enumerate-interval 1 (if(< (- s i j) n) (- s i j) n) ))))) 
            (remove i (enumerate-interval 1 n )))) 
        (enumerate-interval 1 n )))
    (filter (lambda (x) (= s (+ (car x) (cadr x) (caddr x))))
            ;元组中最大的数不会大于s-3
            (make-triple (if (> n (- s 3)) (- s 3) n) s))
)

(three-equals-s 5 8)