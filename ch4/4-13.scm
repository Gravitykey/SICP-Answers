; 没有必要删除上层frame里的约束。这种行为容易造成很多意想不到的后果。
; 这里不方便直接使用4-12里面的循环框架。因为需要在链表中拆链，必须记录上一个节点。

;链表起始元素不删
(define (make-unbound! var env)
    (define (env-loop env)
        (define (scan frame)
            (cond   ((or (null? frame) (null? (cdr frame))) 'Nothing-happend)
                    ((eq? var (get-frame-var (cadr frame))) (set-cdr!  frame (cddr frame)))
                    ((eq? var (get-frame-var (car frame))) ;表的起始元素不真删
                        (set-car! (car frame) '**DELETED_VAR)
                        (set-cdr! (car frame) '**DELETED_VAL))
                    (else (scan (cdr frame)))))
        (if (eq? env the-empty-environment)
            (error "Can't do unbound in EMPTY_ENV")
            (let ((frame (first-frame env)))
                (scan frame))))
    (env-loop env))

; 测试
(load "4-12.scm")
(display "************4-13************")

(make-unbound! 'b ex_env1);b在外层frame，理应没反应
;Value: nothing-happend

ex_env1
;Value 13: (((m . 21) (a . 111) (n . 22)) ((a . 1) (b . 2) (c . 3333)))


(make-unbound! 'a ex_env1); 理应删除值为111的a
ex_env1
;Value 13: (((m . 21) (n . 22)) ((a . 1) (b . 2) (c . 3333)))


(make-unbound! 'm ex_env1); 理应修改掉m
ex_env1
;Value 13: (((**deleted_var . **deleted_val) (n . 22)) ((a . 1) (b . 2) (c . 3333)))
