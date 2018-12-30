; 3.3的代码，未修改过
(define (make-account  balance init-pwd)
    (define (withdraw amount)
        (if (>= balance amount)
            (begin (set! balance (- balance amount)) balance )
            "Insufficient funds"))
    (define (deposit amount)
        (set! balance (+ balance amount))
        balance)
    (define (prompt arg)
        "Incorrect password")
    (define (dispatch pwd m)
        (cond   ((not (eq? init-pwd pwd)) prompt)
                ((eq? m 'withdraw) withdraw)
                ((eq? m 'deposit) deposit)
                (else (error "Unknown request -- MAKE-ACCOUNT" m))))
    dispatch)

; 别名
(define (make-joint original-acc original-pwd new-pwd)
    (define (prompt arg) "Incorrect password")
    (define (dispatch pwd m)
        (cond   ((not (eq? new-pwd pwd)) prompt)
                (else (original-acc original-pwd m))))
    ; 感觉还是绑定时验证下原密码比较好
    ; 给目标账户充值0，如果返回的是数字，不报错，说明密码正确
    (if (number? ((original-acc original-pwd 'deposit) 0))
            dispatch
            (error "Incorrect password,can't bind account --MAKE-JOINT")))

; 测试
(define peter-acc (make-account 100 'peter-password ))

(define paul-acc (make-joint peter-acc 'peter-password 'paul-password))

((paul-acc 'paul-password 'withdraw) 10)
;Value: 90

((peter-acc 'peter-password 'withdraw) 10)
;Value: 80

((peter-acc 'peter-password 'deposit) 5)
;Value: 85

((paul-acc 'paul-password 'deposit) 5)
;Value: 90

; 如果绑定时密码错误
(define bob-acc (make-joint peter-acc 'peter-password-but-wrong 'bob-password))
;Incorrect password,can't bind account --MAKE-JOINT
;To continue, call RESTART with an option number:
; (RESTART 1) => Return to read-eval-print level 1.


; 如果调用时密码错误
((paul-acc 'paul-password-but-wrong 'deposit) 5)
;Value 13: "Incorrect password"

