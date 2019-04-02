; let*展开成let形式

(define (let*? exp) (tagged-list? exp 'let*))
(define (let*-params exp) (cadr exp))
(define (let*-body exp) (cddr exp))

(define (make-let params body)
    (cons 'let (cons params body)))

; 其实在递归中直接使用make-let 而不构造新的make-let* ，执行结果不会有问题，但是阅读上容易引起歧义
(define (make-let* params body)
    (cons 'let* (cons params body)))

(define (let*->let exp)
    (let ((params (let*-params exp)))
        (if (null? (cdr params))
            (make-let (list (car params)) (let*-body exp))
            (make-let (list (car params))
                      (list (let*->let (make-let* (cdr params) (let*-body exp))))))))

; 测试
(define e '(let* ((x 3) (y (+ x 2)) (z (+ x y 5))) (* x z)))

(let*? e)
(let*-params e)
(let*-body e)

(let*->let e)
; 测试结果
; (let ((x 3)) 
;   (let ((y (+ x 2))) 
;       (let ((z (+ x y 5))) (* x z))))