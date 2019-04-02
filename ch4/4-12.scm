; 这三个过程都是在env中搜索约束
; 主要需要的参数
; var需要找到约束名
; val设置的值
; env 环境
; hit-action找到后的动作
; miss-action找不到的动作
; frame-end-action当前frame结束的动作

; 存在的问题问题：env-loop frame env 只能明着传进去，略有不足
; 框架本体
(define (search-loop var val env hit-action fail-action frame-end-action)
    (define (env-loop env)
        (define (scan frame)
            (cond ((null? frame) (frame-end-action frame env env-loop))
                    ((eq? var (get-frame-var (car frame))) (hit-action frame env))
                    (else (scan (cdr frame)))))
        (if (eq? env the-empty-environment)
            (fail-action env)
            (let ((frame (first-frame env)))
                (scan frame))))
    (env-loop env))

; 定义三个功能
(define (lookup-variable-value var env)
    (search-loop
        var
        #f
        env
        (lambda (frame env) (get-frame-val (car frame)))
        (lambda (env) (error "Unbound variable " var))
        (lambda (frame env env-loop) (env-loop (enclosing-environment env)))))

(define (set-variable-value! var val env)
    (search-loop
        var
        val
        env
        (lambda (frame env) (set-cdr! (car frame) val))
        (lambda (env) (error "Unbound variable -- SET!" var))
        (lambda (frame env env-loop) (env-loop (enclosing-environment env)))))

(define (define-variable!  var val env)
    (search-loop
        var
        val
        env
        (lambda (frame env) (set-cdr! (car frame) val))
        (lambda (env) (error "Can't define a variable to EMPTY ENV!"))
        (lambda (frame env env-loop) (add-binding-to-frame! var val (first-frame env)))))





        
; 测试
; (在这里把4-11的内容补充一下)
(define (enclosing-environment env) (cdr env))
(define (first-frame env) (car env))
(define the-empty-environment '())
(define (make-frame variables values)
    (if (null? variables)
        (list (cons '*empty-environment-head* '*You-try-to-visit-a-illegal-variable*))
        (map cons variables values)))
(define (get-frame-var p) (car p))
(define (get-frame-val p) (cdr p))
(define (frame-variables frame) (map car frame))
(define (frame-values frame) (map cdr frame))
(define (add-binding-to-frame! var val frame)
        (set-cdr! frame (cons (cons var val) (cdr frame))))
(define (extend-environment vars vals base-env)
    (if (= (length vars) (length vals))
        (cons (make-frame vars vals) base-env)
        (if (< (length vars) (length vals))
            (error "Too many arguments supplied" vars vals)
            (error "Too few arguents supplied" vars vals))))


; 套用4-11的数据
(define env1 (extend-environment '(a b c) '(1 2 3) the-empty-environment))
env1
;Value 13: (((a . 1) (b . 2) (c . 3)))


(define env2 (extend-environment '(d) '(4) env1))
env2
;Value 14: (((d . 4)) ((a . 1) (b . 2) (c . 3)))

(define env_empty (extend-environment '() '() the-empty-environment))
env_empty
;Value 15: (((*empty-environment-head* . *you-try-to-visit-a-illegal-variable*)))

(define ex_env1 (extend-environment '(m n) '(21 22) env1))
ex_env1
;Value 16: (((m . 21) (n . 22)) ((a . 1) (b . 2) (c . 3)))

(lookup-variable-value 'n ex_env1)
;Value: 22

(lookup-variable-value 'a ex_env1)
;Value: 1

(define-variable! 'a 111 ex_env1)

ex_env1
;Value 16: (((m . 21) (a . 111) (n . 22)) ((a . 1) (b . 2) (c . 3)))

(set-variable-value! 'c 3333 env2)

(lookup-variable-value 'c ex_env1)
;Value: 3333

; 测试通过