;书p82 fold-left的定义
(define (fold-left op initial sequence)
    (define (iter result rest)
        (if (null? rest)
            result
            (iter (op result (car rest))
                (cdr rest))))
    (iter initial sequence))

;fold-right即accumulate
(load "accumulate.scm")
(define (fold-right op initial sequence)
    (accumulate op initial sequence))

;题目
; (define (reverse sequence)
;     (fold-right (lambda (x y) <??>) '() sequence))

; (define (reverse sequence)
;     (fold-left (lambda (x y) <??>) '() sequence))


(define (reverse-r sequence)
    (fold-right (lambda (x rest) 
            (append rest (list x)))
     '() sequence))

(define (reverse-l sequence)
    (fold-left (lambda (res x) (cons x res)) '() sequence))

(reverse-r '(1 2 3 4 5))
(reverse-r '((1) (2) (3) (4) (5)))

(reverse-l '(1 2 3 4 5))
(reverse-l '((1) (2) (3) (4) (5)))
