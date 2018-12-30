; 加入一个局部变量，超7次报警

(define (call-the-cops)
    (error "Police is coming~~"))

(define (make-account  balance init-pwd)
; 在尝试在let内部define，好像不成功，改成直接define
    (define incorrect-count 0)
    (define incorrect-limit 7)
    (define (withdraw amount)
        (if (>= balance amount)
            (begin (set! balance (- balance amount)) balance )
            "Insufficient funds"))
    (define (deposit amount)
        (set! balance (+ balance amount))
        balance)
    (define (incorrect arg)
        (begin 
            (set! incorrect-count (+ incorrect-count 1)) 
            (if (>= incorrect-count incorrect-limit)
                (call-the-cops)
                (cons "Incorrect password" incorrect-count))))
    (define (clear-incorrect-count) (set! incorrect-count 0))
    (define (dispatch pwd m)
        (cond   ((not (eq? init-pwd pwd)) incorrect)
                ((eq? m 'withdraw) (begin (clear-incorrect-count) withdraw))
                ((eq? m 'deposit) (begin (clear-incorrect-count) deposit))
                (else (error "Unknown request -- MAKE-ACCOUNT" m))))
    dispatch)

; 测试
(define acc (make-account 100 'a-password ))
((acc 'a-password 'withdraw) 40)
((acc 'a-password 'withdraw) 40)
((acc 'a-wrong-password 'withdraw) 40)
((acc 'a-wrong-password 'withdraw) 40)
((acc 'a-password 'withdraw) 1)
((acc 'a-wrong-password 'withdraw) 40)
((acc 'a-wrong-password 'withdraw) 40)
((acc 'a-wrong-password 'withdraw) 40)
((acc 'a-wrong-password 'withdraw) 40)
((acc 'a-wrong-password 'withdraw) 40)
((acc 'a-wrong-password 'withdraw) 40)
((acc 'a-wrong-password 'withdraw) 40)
((acc 'a-wrong-password 'withdraw) 40)
((acc 'a-wrong-password 'withdraw) 40)

; 测试结果
; (define acc (make-account 100 'a-password ))
; ;Value: acc

; 1 ]=> ((acc 'a-password 'withdraw) 40)
; ;Value: 60

; 1 ]=> ((acc 'a-password 'withdraw) 40)
; ;Value: 20

; 1 ]=> ((acc 'a-wrong-password 'withdraw) 40)
; ;Value 13: ("Incorrect password" . 1)

; 1 ]=> ((acc 'a-wrong-password 'withdraw) 40)
; ;Value 14: ("Incorrect password" . 2)

; 1 ]=> ((acc 'a-password 'withdraw) 1)
; ;Value: 19

; 1 ]=> ((acc 'a-wrong-password 'withdraw) 40)
; ;Value 15: ("Incorrect password" . 1)

; 1 ]=> ((acc 'a-wrong-password 'withdraw) 40)
; ;Value 16: ("Incorrect password" . 2)

; 1 ]=> ((acc 'a-wrong-password 'withdraw) 40)
; ;Value 17: ("Incorrect password" . 3)

; 1 ]=> ((acc 'a-wrong-password 'withdraw) 40)
; ;Value 18: ("Incorrect password" . 4)

; 1 ]=> ((acc 'a-wrong-password 'withdraw) 40)
; ;Value 19: ("Incorrect password" . 5)

; 1 ]=> ((acc 'a-wrong-password 'withdraw) 40)
; ;Value 20: ("Incorrect password" . 6)

; 1 ]=> ((acc 'a-wrong-password 'withdraw) 40)
; ;Police is coming~~
; ;To continue, call RESTART with an option number:
; ; (RESTART 1) => Return to read-eval-print level 1.

; 2 error> ((acc 'a-wrong-password 'withdraw) 40)
; ;Police is coming~~
; ;To continue, call RESTART with an option number:
; ; (RESTART 2) => Return to read-eval-print level 2.
; ; (RESTART 1) => Return to read-eval-print level 1.