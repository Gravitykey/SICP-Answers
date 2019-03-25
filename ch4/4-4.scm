(define (and? exp) (tagged-list? exp 'and))
(define (or? exp) (tatgged-list? exp 'or))
(define (untagged-clauses exp) (cdr exp))
(define (first-exp clauses) (car clauses))
(define (rest-exp clauses) (cdr clauses))
(define (last-exp? clauses) (null? (cdr clauses)))

(define (eval-and exp env)
    (define (loop clauses)
      (cond ((null? clauses) #t)
            ((last-exp? clauses) (eval (first-exp clauses) env))
            ((eval (first-exp clauses) env) (loop (rest-exp clauses env)))
            (else #f)))
    (loop (untagged-clauses exp)))

; 这里or跟书上的不完全相同，它会返回第一个真值，而不只是true
(define (eval-or exp env)
    (define (loop clauses)
      (cond ((null? clauses) #f)
            ((last-exp? clauses) (eval (first-exp clauses) env))
            ((not (eval (first-exp clauses) env)) (loop (rest-exp clauses env)))
            (else (eval (first-exp) env))))
    (loop (untagged-clauses exp)))


; 派生表达式
(define (and->if exp)
    (expand-and-clauses (untagged-clauses exp)))
    
(define (expand-and-clauses clauses)
    (if (null? clauses)
        #t
        (let ((first (car clauses))
              (rest (cdr clauses)))
            (if (null? rest)
                first 
                (make-if first
                       (expand-and-clauses rest)
                       #f)))))

(define (or->if exp)
    (expand-or-clauses (untagged-clauses exp)))

(define (expand-or-clauses clauses)
    (if (null? clauses)
        #f
        (let ((first (car clauses))
              (rest (cdr clauses)))
            (if (null? rest)
                first 
                (make-if first
                       first
                       (expand-or-clauses rest))))))