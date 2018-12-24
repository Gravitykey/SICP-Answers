; 因为number，real-part等被定义为了安装包的内部过程，所以需要在各自包内分别添加。这样也易于维护。


; 在基本操作包末尾添加如下
(put '=zero? '(scheme-number) (lambda (x) (= x 0)))

; 在有理数包里添加
(put '=zero? '(rational) 
    (lambda (x) (= x 0)))

; 在复数包添加
(put '=zero? '(complex) 
    (lambda (x) 
        (and(= (real-part x) 0)
            (= (imag-part x) 0 ))))