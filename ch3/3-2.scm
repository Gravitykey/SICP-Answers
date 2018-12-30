; 考虑到不定数量参数的情况，内层lambda用可变个数参数形式
(define (make-monitored fun)
    (let ((count 0))
        (lambda (first . rest) 
            (cond   ((equal? first 'how-many-calls?) count )
                    ((eq    ual? first 'reset-count)(set! count 0))
                    (else (begin (set! count (+ count 1))
                            (apply fun (cons first rest))))))))

; 1 ]=> (define s (make-monitored sqrt))
; ;Value: s

; 1 ]=> (s 100)
; ;Value: 10

; 1 ]=> (s 'how-many-calls?)
; ;Value: 1

; 1 ]=> (s 4)
; ;Value: 2

; 1 ]=> (s 'how-many-calls?)
; ;Value: 2

; 1 ]=> (s 'reset-count)
; ;Value: 2

; 1 ]=> (s 'how-many-calls?)
; ;Value: 0