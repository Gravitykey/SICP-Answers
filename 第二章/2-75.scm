(define (make-from-mag-ang r a)
    (define (dispatch op)
        (cond   ((eq? op 'real-part) (* r (cos a)))
                ((eq? op 'imag-parg) (* r (sin a)))
                ((eq? op 'magnitude) r)
                ((eq? op 'angle) a)
                (else (error "Unknown op -- MAKE-FORM-MAG-ANG" op))))
    dispatch)

; 测试
(define x (make-from-mag-ang 2 (/ 3.141592653 4)))
(x 'real-part)
(x 'imag-parg)
(x 'magnitude)
(x 'angle)

; 1 ]=> (x 'real-part)
; ;Value: 1.4142135625816183

; 1 ]=> (x 'imag-parg)
; ;Value: 1.4142135621645717

; 1 ]=> (x 'magnitude)
; ;Value: 2

; 1 ]=> (x 'angle)
; ;Value: .78539816325

