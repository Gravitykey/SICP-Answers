(load "accumulate.scm")


(define (map p sequence)
    (accumulate (lambda (x y) (cons (p x) y)) '()  sequence))

;测试
(map (lambda (x) (* x 10)) '(1 2 3 4 5 6))
;Value 13: (10 20 30 40 50 60)


(define (my-append seq1 seq2)
    (accumulate cons seq2 seq1))

;测试
(my-append '(1 2 3 4) '(5 6 7 8))
;Value 14: (1 2 3 4 5 6 7 8)


(define (my-length sequence)
    (accumulate  (lambda(x y)(+ 1 y)) 0 sequence))
;测试
(my-length '(1 2 3 4 5))
;Value: 5