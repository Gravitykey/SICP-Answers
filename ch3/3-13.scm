(define (make-cycle x)
    (set-cdr! (last-pair x) x)
    x)

(define (last-pair x)
    (if (null? (cdr x))
        x
        (last-pair (cdr x))))

(define z (make-cycle (list 'a 'b 'c)))

(last-pair z)

; 执行后程序进入了死循环
; 列表('a 'b 'c)理论上'c末尾的格子应该指向'()，结果被改为了开头的'a
; 对'c这个单元执行cdr操作时，会直接拿到'a，对'a cdr又拿到'b，对'b cdr拿到'c

;  ,-------------------,
;  |                   |
;  v                   |
; ( . ) -> ( . ) -> ( . )
;  |        |        |
;  v        v        v
;  'a       'b       'c