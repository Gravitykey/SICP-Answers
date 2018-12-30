;a) 中缀表达式处理，只需要修改谓词和函数

(load "2-56.scm")

(define (sum? x)
    (and (pair? x) (eq? (cadr x) '+)))

(define (addend s)
    (car s))

(define (augend s)
    (caddr s))

(define (product? x)
    (and (pair? x) (eq? (cadr x) '*)))

(define (multiplier p)
    (car p))

(define (multiplicand p)
    (caddr p))

(define (make-sum a1 a2)
    (cond   ((=number? a1 0) a2)
            ((=number? a2 0) a1)
            ((and (number? a1) (number? a2)) (+ a1 a2))
            (else (list  a1 '+ a2))))

(define (make-product m1 m2)
    (cond   ((or (=number? m1 0) (=number? m2 0)) 0)
            ((=number? m1 1) m2)
            ((=number? m2 1) m1)
            ((and (number? m1) (number? m2)) (* m1 m2))
            (else (list  m1 '* m2))))

(define (exponentiation? x)
    (and (pair? x) (eq? (cadr x) '** )))

(define (base x)
    (car x))

(define (exponent x)
    (caddr x))

(define (make-expoentiation b e)
    (cond   ((=number? e 0) 1)
            ((=number? e 1) b)
            ((=number? b 1) 1)
            (else (list  b '** e))))

;测试

(deriv '(x + (3 * (x + (y + 2)))) 'x)
;Value: 4

(deriv '((x * (x * (3 + (x + y)))) + (x + y)) 'x)
;Value 14: (((x * (x + (3 + (x + y)))) + (x * (3 + (x + y)))) + 1)

(deriv '(3 * (x ** 3)) 'x)
;Value 15: (3 * (3 * (x ** 2)))


; b) 
; 可行，不改动deriv的前提下，修改谓词和构造函数，可以做出带优先级的处理程序
; 简而言之就是在构造连加的过程中，给乘法加括号
; 
; 如果一个表达式中，出现任何一个+，那么这个式子为加法式
; 如果一个表达式中，运算符全部为*，那么这个式子为乘法式
; 原因如下：如果只判断开头的运算符，出现 （ax*bx*cx+dx)情形时，作为连乘判断，如果不改动求导过程，会使第四项dx无法处理
; 构造过程：当有 + 存在时，把+号左边加上括号，+号右边加上括号作为加数和被加数 
; 如(ax*bx+cx*d) 该表达式因为存在加号，会被识别为加法式，加号左端和右端分别取成加数(ax*bx)和被加数(cx*d) 

; 定义一个has-op?过程,检测序列里是否有符号
(define (has-op? op lst)
    (if (null? lst)
        #f
        (if (eq? (car lst) op)
            #t
            (has-op? op (cdr lst)))))

;重新定义加法谓词
(define (sum? x)
    (and (pair? x) (has-op? '+ x)))
;乘法式要求必须是干净的全乘
(define (product? x)
    (and (pair? x) (has-op? '* x) (not (has-op? '+ x))))

;找一个符号，从两边拆分
(define (divide-by-op op left right)
    ;;这里定义unpack把只有1个元素的列表解包成单个元素，否则后面过程会对'()做car操作导致报错
    (define (unpack x)
        (if (null? (cdr x))
            (car x)
            x))
    (if (eq? op (car right))
        ; 把左右两边打包返回
        (list (unpack left) (unpack(cdr right)))
        (divide-by-op op (append left (list (car right))) (cdr right)))
)

;重写加数和被加数
(define (addend s)
    (car (divide-by-op '+ '() s)))

(define (augend s)
    (cadr (divide-by-op '+ '() s)))

(define (multiplicand p)
    ; a * b ? c
    ; (define a (car p))
    ; (define op1 (cadr p))
    (define b (caddr p))
    (define b+list (cdddr p))
    
    (if (null? b+list) b (cddr p)))


; 测试
(deriv '(x + 3 * (x + y + 2)) 'x)
;Value: 4

(deriv '(x + (3 * (x + (y + 2)))) 'x)
;Value: 4

(deriv '((x * (x * (3 + (x + y)))) + (x + y)) 'x)
;Value 14: (((x * (x + (3 + (x + y)))) + (x * (3 + (x + y)))) + 1)

(deriv '(3 * (x ** 3)) 'x)
;Value 15: (3 * (3 * (x ** 2)))

; 测试乘加混合
(deriv '(x + 3 * (x + y + 2) * x * 2 + 66 * x) 'x)
;Value 18: (1 + ((3 * (((x + y + 2) * 2) + (x * 2))) + 66))

; 测试通过