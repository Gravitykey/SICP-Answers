; (define (deriv exp var)
;   (cond ((number? exp) 0)
;         ((variable? exp) (if (same-variable? exp var) 1 0))
;         ((sum? exp)
;          (make-sum (deriv (addend exp) var)
;                    (deriv (augend exp) var)))
;         ((product? exp)
;          (make-sum
;            (make-product (multiplier exp)
;                          (deriv (multiplicand exp) var))
;            (make-product (deriv (multiplier exp) var)
;                          (multiplicand exp))))
;         <more rules can be added here>
;         (else (error "unknown expression type -- DERIV" exp))))


; 改成数据驱动
(define (deriv exp var)
   (cond ((number? exp) 0)
         ((variable? exp) (if (same-variable? exp var) 1 0))
         (else ((get 'deriv (operator exp)) (operands exp)
                                            var))))
(define (operator exp) (car exp))
(define (operands exp) (cdr exp))
; a）上面做了什么。为什么无法将谓词number? same-variable?也加入数据导向分派中？
; 因为number? 和 variable? 是语言内置的过程，且功能单一，参数也是基本类型。判断数字和变量是求导过程
; 需要进行的基本操作。强行放入只会画蛇添足造成麻烦。

b)
