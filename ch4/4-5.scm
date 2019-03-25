; 原来的cond部分
(define (cond? exp) (tagged-list? exp 'cond))
(define (cond-clauses exp) (cdr exp))
(define (cond-else-clause? clause) 
    (eq? (cond-predicate clause) 'else))
(define (cond-predicate clause) (car clause))
; (define (cond-actions clause) (cdr clause))

; 添加对=>的支持 a => b

; clause第二项为=> 且有第三项
(define (cond-arrow-clause? clause)
    (and (not (null? (cddr clause))) 
         (eq? (cadr clause) '=>)))

(define (cond-arrow-actions clause) (cons (caddr clause) (cond-predicate clause)))
(define (cond-normal-actions clause) (cdr clause))
; 重写cond-actions
(define (cond-actions clause)
    (if (cond-arrow-clause? clause)
        (cond-arrow-actions clause))
        (cond-normal-actions clause))