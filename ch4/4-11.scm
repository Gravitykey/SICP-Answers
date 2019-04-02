; 把var val双表改成单表pair元素


;对环境操作
(define (enclosing-environment env) (cdr env))

(define (first-frame env) (car env))

(define the-empty-environment '())


; 这里有个问题，如果var和val全都是空表，那么向frame中增加约束时，对'()使用set-cdr！会报错。
; 我的比较偷懒的解决方法可以是在每个空env里面放一个不会访问到的约束，保证该表不空
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

; 真6666
(define (lookup-variable-value var env)
    (define (env-loop env)
        (define (scan frame)
            (cond ((null? frame) (env-loop (enclosing-environment env)))
                  ((eq? var (get-frame-var (car frame))) (get-frame-val (car frame)))
                  (else (scan (cdr frame)))))
        (if (eq? env the-empty-environment)
            (error "Unbound variable" var)
            (let ((frame (first-frame env)))
                (scan frame))))
    (env-loop env))

(define (set-variable-value! var val env)
    (define (env-loop env)
        (define (scan frame)
            (cond ((null? frame) (env-loop (enclosing-environment env)))
                  ((eq? var (get-frame-var (car frame))) (set-cdr! (car frame) val))
                  (else (scan (cdr frame)))))
        (if (eq? env the-empty-environment)
            (error "Unbound variable -- SET!" var)
            (let ((frame (first-frame env)))
                (scan frame))))
    (env-loop env))

(define (define-variable! var val env)
    (let ((frame (first-frame env)))
        (define (scan frame)
            (cond ((null? frame) (add-binding-to-frame! var val (first-frame env)))
                  ((eq? var (get-frame-var (car frame))) (set-cdr! (car frame) val))
                  (else (scan (cdr frame)))))
        (scan frame)))


; 测试
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

