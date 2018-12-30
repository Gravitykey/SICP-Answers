;扩充乘幂
(load "p100.scm")

(define (exponentiation? x)
    (and (pair? x) (eq? (car x) '** )))

(define (base x)
    (cadr x))

(define (exponent x)
    (caddr x))

(define (make-expoentiation b e)
    (cond   ((=number? e 0) 1)
            ((=number? e 1) b)
            ((=number? b 1) 1)
            (else (list '** b e))))

;重写求导过程

(define (deriv exp var)
    (cond ((number? exp) 0)
        ((variable? exp)
            (if(same-variable? exp var) 1 0))
        ((sum? exp)
            (make-sum (deriv (addend exp) var)
                    (deriv (augend exp) var)))
        ((product? exp)
            (make-sum
                (make-product (multiplier exp)
                        (deriv (multiplicand exp) var))
                (make-product (deriv (multiplier exp) var)
                        (multiplicand exp))))
        ((exponentiation? exp)
            (make-product
                (make-product 
                    (exponent exp) 
                    (make-expoentiation (base exp) (- (exponent exp) 1))) 
                (deriv (base exp) var)))
        (else (error "unknown expression type --DERIV" exp))))


;test (2x**3 + 4x)  should  (6x**2 + 4)

(deriv '(+ (* 2 (** x 3)) (* 4 x)) 'x)
;Value 13: (+ (* 2 (* 3 (** x 2))) 4)