; 用raise修改apply-generic

; 定义一个raise-to
; 可以raise返回raise后的结果
; 不能raise返回x本身

(define (raise-to x target)
    (define (loop x target)
        (if (equal? (type-tag x) target)
            x
            (let ((proc (get 'raise (type-tag x))))
                (if proc
                    (loop (proc x) target)
                    #f ))))
    (let ((raised (loop x target)))
        (if raised
            raised
            x)))

; 这并不是一个很漂亮的解法。x会逐层raise，直到成为target类型。
; 当 循环中的x没有raise过程可用时，会返回最原始的x，即raise失败

; 对apply-generic的修改：
; 代码自2-82
(define (apply-generic op . args) 
    ;;;;;;;;;;;;;;;在这里修改;;;;;;;;;;;;;;
    (define (try-coerce-list lst type) 
        ; (map (lambda (x) 
        ;         (let ((proc (get-coercion (type-tag x) type))) 
        ;             (if proc (proc x) x))) 
        ;     lst))
        (map (lambda (x) (raise-to x type)) lst))
   
    ; 尝试应用转换后的lst 
    (define (apply-coerced lst) 
      (if (null? lst) 
        (error "Can't find methods to apply" (map type-tag args)) 
        (let ((coerced-list (try-coerce-list args (type-tag (car lst))))) 
          (let ((proc (get op (map type-tag coerced-list)))) 
            (if proc 
              (apply proc (map contents coerced-list)) 
              (apply-coerced (cdr lst))))))) 
   
    ; 如果首次传入的参数能直接查到，那么没必要继续转换
    (let ((type-tags (map type-tag args))) 
      (let ((proc (get op type-tags))) 
        (if proc 
          (apply proc (map contents args)) 
          (apply-coerced args))))) 
