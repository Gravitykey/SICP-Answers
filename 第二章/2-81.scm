; a）
; 强制转换转换会导致无限递归
; 因为转换后的类型还是原类型。
; 在改变后的apply-generic里面，转换语句为

; (cond   (t1->t2 (apply-generic op (t1->t2 a1) a2))
;         (t2->t1 (apply-generic op a1 (t2->t1 a2)))
;         (else (error "No method for these types" (list op type-tags))))

; 注意，在这里，转换后进行了apply-generic的递归调用。
; 但是 自己 转换到 自己 的类型，会导致调用后的apply-generic重复上一层的情况，与未转换没有差异
; 递归会一直进行下去
; 直到报错


; b)
; 这个叫Louis没有解决任何问题，只是在挖坑。
; 原来的情况下，apply-generic遇上不能转换的情况还有可能报错，现在直接会让程序跑崩

; c)
; 按理说目前的apply-generic不会产生什么问题，只要没有人作死往转换表中填写自己转自己的过程。
; 如果有，直接打死就好了。
; 如果非要加，也是防御性的

(define (apply-generic op . args)
  (let ((type-tags (map type-tag args)))
    (let ((proc (get op type-tags)))
      (if proc
          (apply proc (map contents args))
          (if (= (length args) 2)
              (let ((type1 (car type-tags))
                    (type2 (cadr type-tags))
                    (a1 (car args))
                    (a2 (cadr args)))
                (let ((t1->t2 (get-coercion type1 type2))
                      (t2->t1 (get-coercion type2 type1)))
                ;   在cond开头加一个判断条件
                  (cond ((equal? type1 type2) 
                         (error "Bad Coercion -- two same type:" (type1 type2)))
                        (t1->t2
                         (apply-generic op (t1->t2 a1) a2))
                        (t2->t1
                         (apply-generic op a1 (t2->t1 a2)))
                        (else
                         (error "No method for these types"
                                (list op type-tags))))))
              (error "No method for these types"
                     (list op type-tags)))))))
