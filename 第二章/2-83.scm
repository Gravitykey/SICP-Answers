; 在整数安装包末尾添加raise 
(put 'raise 'integer  
    (lambda (x) (make-rational x 1))) 

; 在有理数安装包末尾添加raise
(put 'raise 'rational 
    (lambda (x) (make-real (/ (numer x) (denom x)))))

; 在实数安装包末尾添加raise 
(put 'raise 'real 
    (lambda (x) (make-from-real-imag x 0)))

; 还要定义一个raise过程
(define (raise x) (apply-generic 'raise x))  