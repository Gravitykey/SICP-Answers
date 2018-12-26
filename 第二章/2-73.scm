; 载入get/put的实现，否则无法进行
(load "put_get.scm")

; 需要用到的前置过程
(define (variable? x )
    (symbol? x))

(define (same-variable? v1 v2)
    (and (variable? v1) (variable? v2) (eq? v1 v2)))

; 改成数据驱动
(define (deriv exp var)
   (cond ((number? exp) 0)
         ((variable? exp) (if (same-variable? exp var) 1 0))
         (else ((get 'deriv (operator exp)) (operands exp)
                                            var))))
(define (operator exp) (car exp))
(define (operands exp) (cdr exp))


; a）上面做了什么。为什么无法将谓词nu mber? same-variable?也加入数据导向分派中？

; 因为number? 和 variable? 是简单调用语言内置的过程，且功能单一，参数也是基本类型。判断数字和变量是求导过程
; 需要进行的基本操作。强行放入只会画蛇添足造成麻烦。


; b)写出和式和积的求导过程，并安装到表格里
(define (install-sum-product-deriv)
    ; 前置小过程
    ; 因为之前的参数传进来是exp，而此处变成了(operands exp)所以这里要改取数方式 
    (define (addend s)
        (car s))
    (define (augend s)
        (cadr s))
    (define (multiplier p)
        (car p))
    (define (multiplicand p)
        (cadr p))

    (define (=number? exp num)
        (and (number? exp) (= exp num)))
    (define (make-sum a1 a2)
        (cond   ((=number? a1 0) a2)
                ((=number? a2 0) a1)
                ((and (number? a1) (number? a2)) (+ a1 a2))
                (else (list '+ a1 a2))))
    (define (make-product m1 m2)
        (cond   ((or (=number? m1 0) (=number? m2 0)) 0)
                ((=number? m1 1) m2)
                ((=number? m2 1) m1)
                ((and (number? m1) (number? m2)) (* m1 m2))
                (else (list '* m1 m2))))

    ; 计算加法导数
    (define (deriv-sum exp var)
        (make-sum (deriv (addend exp) var)
                (deriv (augend exp) var)))

    (define (deriv-product exp var)
        (make-sum
            (make-product (multiplier exp)
                    (deriv (multiplicand exp) var))
            (make-product (deriv (multiplier exp) var)
                    (multiplicand exp)))
    )

    ; 放入表
    (put 'deriv '+ deriv-sum)
    (put 'deriv '* deriv-product)
    ; 第为第四问做的改动
    (put '+ 'deriv deriv-sum)
    (put '* 'deriv deriv-product)
)
    ; 测试

    (install-sum-product-deriv)
    (deriv '(+ 3 x) 'x)
    (deriv '(* x x) 'x)
    (deriv '(* x (+ x 3)) 'x)


; c)加入对幂求导

(define (install-expoentiation-deriv)
    (define (base x)
        (car x))
    (define (exponent x)
        (cadr x))
    (define (=number? exp num)
        (and (number? exp) (= exp num)))
    (define (make-product m1 m2)
        (cond   ((or (=number? m1 0) (=number? m2 0)) 0)
                ((=number? m1 1) m2)
                ((=number? m2 1) m1)
                ((and (number? m1) (number? m2)) (* m1 m2))
                (else (list '* m1 m2))))
    (define (make-expoentiation b e)
        (cond   ((=number? e 0) 1)
                ((=number? e 1) b)
                ((=number? b 1) 1)
                (else (list '** b e))))
    (define (deriv-expoentiation exp var)
        (make-product
            (make-product 
                (exponent exp) 
                (make-expoentiation (base exp) (- (exponent exp) 1))) 
            (deriv (base exp) var)))
    
    ; 放入表
    (put 'deriv '** deriv-expoentiation)
    ; 第四问的改动
    (put '** 'deriv deriv-expoentiation)
)

    ; 测试
    (install-expoentiation-deriv)
    (deriv '(+ (** x 3) (* 5 x)) 'x)
    ;Value 19: (+ (* 3 (** x 2)) 5)


; d)在这一简单的袋鼠运算器中，表达式的类型就是构造起他们来的代数运算符。假定我们想以另一种相反的方式做索引，使得deriv里完成分派的代码像下面这样：
    ; ((get (operator exp) 'deriv) (operands exp) var)
    ; 求导系统需要做哪些相应改动？

    ; 翻转索引项即可，已放至安装代码最后
    ; 然后重写求导

(define (deriv exp var)
   (cond ((number? exp) 0)
         ((variable? exp) (if (same-variable? exp var) 1 0))
         (else ((get  (operator exp) 'deriv) (operands exp)
                                            var))))

    ; 测试
    (equal? (get '+ 'deriv) (get 'deriv '+))
    (equal? (get '* 'deriv) (get 'deriv '*))
    (equal? (get '** 'deriv) (get 'deriv '**))
    ; 以上结果全是#t

    (deriv '(+ (** x 3) (* 5 x)) 'x)
    ;Value 21: (+ (* 3 (** x 2)) 5)