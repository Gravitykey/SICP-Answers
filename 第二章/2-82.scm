; 更通用的方法


; 把列表中的类型设法转成第一个参数的类型

;       列表空？空，报错误没有对应方法：不空，继续下面的操作
;       能转吗？能转，则转：不能转，保留原来的类型，插回去
;           得到一个转换后的参数表
;           map该转换后的表得到tags，然后用此去get相应过程
;           有对应过程吗？有，apply一下：没有，cdr出后面的参数，递归到开头，再次尝试执行转换

    
(define (apply-generic op . args) 
    ; 尝试把列表转换到某个类型，如无法转则保留原类型
    (define (try-coerce-list lst type) 
        (map (lambda (x) 
                (let ((proc (get-coercion (type-tag x) type))) 
                    (if proc (proc x) x))) 
            lst))
   
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