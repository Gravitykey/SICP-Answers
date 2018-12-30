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


; test
; (define acc (make-account 100 'a-password ))
; ;Value: acc

; 1 ]=> ((acc 'a-password 'withdraw) 40)
; ;Value: 60

; 1 ]=> ((acc 'a-wrong-password 'withdraw) 50)
; ;Value 13: "Incorrect password"