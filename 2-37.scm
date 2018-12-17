(load "accumulate.scm")

(define (dot-product v w)
    (accumulate + 0 (map * v w)
))

; (define (matrix-*-vector m v)
;     (map <??> m)
; )

(define (matrix-*-vector m v)
    (map (lambda (line) (dot-product v line)) m)
)

; (define (transpos mat)
;     (accumulate-n <??> <??> mat))
; 交换行列

(define (transpos mat)
    (accumulate-n cons '() mat))


; (define (matrix-*-matrix m n)
;     (let ((cols (transpos n)))(
;         (map <??> m)
;     ))
; )

(define (matrix-*-matrix m n)
    (let ((cols (transpos n)))
        (map (lambda(x)
            (matrix-*-vector cols x)
        ) m)
    )
)

; 测试
(matrix-*-vector '((1 2 3)(4 5 6)(7 8 9)) '(1 2 3))
(transpos '((1 2 3)(4 5 6)(7 8 9)))
(matrix-*-matrix '((1 2 3)(4 5 6)) '((1 4)(2 5)(3 6)))

; 1 ]=> ; 测试
; (matrix-*-vector '((1 2 3)(4 5 6)(7 8 9)) '(1 2 3))
; ;Value 13: (14 32 50)

; 1 ]=> (transpos '((1 2 3)(4 5 6)(7 8 9)))
; ;Value 14: ((1 4 7) (2 5 8) (3 6 9))

; 1 ]=> (matrix-*-matrix '((1 2 3)(4 5 6)) '((1 4)(2 5)(3 6)))
; ;Value 15: ((14 32) (32 77))