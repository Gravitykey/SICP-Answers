; (let ((a 1) (b 2)) (body))
(define (let? exp) (tagged-list? exp 'let))
(define (let-params exp) (cadr exp))
(define (let-body exp) (cddr exp))
(define (get-let-var p) (car p))
(define (get-let-value p) (cadr p))
(define (let-vars exp) (map get-let-var (let-params exp)))
(define (let-values exp) (map get-let-value (let-params exp)))
(define (let->lambda exp)
    (list (make-lambda (let-vars exp)
                         (let-body exp))
            (let-values exp)))

; 同时在eval的cond里面加入这一行
; ((let? exp) (eval (let->lambda exp) env))

; 测试
(define (make-lambda parameters body)
    (cons 'lambda (cons parameters body)))

(let->lambda '(let ((x 1) (y 2)) (body)))
;Value 13: ((lambda (x y) (body)) (1 2))
; 测试通过