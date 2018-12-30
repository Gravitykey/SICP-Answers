; 因为number，real-part等被定义为了安装包的内部过程，所以需要在各自包内分别添加。这样也易于维护。

; 在基本操作包末尾添加如下
(put 'equ? '(scheme-number scheme-number) (lambda (x y) (= x y)))

; 在有理数包里添加
(put 'equ? '(rational rational) 
    (lambda (x y) 
        (and(= (number x) (number y))
            (= (denom x) (denom y)))))

; 在复数包添加
(put 'equ? '(complex complex) 
    (lambda (x y) 
        (and(= (real-part x) (real-part y))
            (= (imag-part x) (imag-part y)))))