(define (my-reverse lst )
    (if (null? lst) '() (cons (my-reverse(cdr lst)) (car lst) )))
(newline)
(display (my-reverse '(1 2 3 4 5 )))

;以上实现有问题，末尾木有'()导致不是正常列表

;下面是let的循环实现

(define (my-reverse2 lst)
    (let loop((lst1 lst) (result '()))
        (if (null? lst1) 
            result 
            ( loop (cdr lst1) (cons (car lst1) result))
        )
    )
)
(newline)
(display (my-reverse2 '(1 2 3 4 5)))
