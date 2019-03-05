(load "mutex.scm")

(define (counter)
    (let ((i 0))
        (lambda ()
            (set! i (+ 1 i))
            i)))
(define generate-account-id (counter))

; 首先加给账户加一个acc-id的属性

(define (make-account balance)
    
    (let ((acc-id (generate-account-id)))                       ; +
        (define (withdraw amount)
            (if (>= balance amount)
                (begin (set! balance (- balance amount))
                       balance)
                "Insufficient funds"))

        (define (deposit amount)
            (set! balance (+ balance amount))
            balance)

        (let ((balance-serializer (make-serializer)))
            (define (dispatch m)
                (cond
                    ((eq? m 'withdraw) withdraw)
                    ((eq? m 'deposit) deposit)
                    ((eq? m 'balance) balance)
                    ((eq? m 'serializer) balance-serializer)
                    ((eq? m 'id) acc-id)
                    (else (error "Unknown request -- MAKE-ACCOUNT" m))))

            dispatch)))

; 书p214给出的串行化交换过程
(define (exchange account1 account2)
    (let ((difference (- (account1 'balance)
                         (account2 'balance))))
        ((account1 'withdraw) difference)
        ((account2 'deposit) difference)))

(define (serialized-exchange account1 account2)
    (let ((serializer1 (account1 'serializer))
          (serializer2 (account2 'serializer)))
      ((serializer1 (serializer2 exchange))
        account1
        account2)))

; 按顺序锁
(define (ordered-serialized-exchange account1 account2)
    (if (< (account1 'id) (account2 'id))
        (ordered-serialized-exchange account1 account2)
        (ordered-serialized-exchange account2 account1)))

; 这样一来，加锁解锁顺序都按id大小顺序执行