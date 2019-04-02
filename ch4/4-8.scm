; 扩充支持命名let,只处理语法转换部分
; named-let -> (define name lambda) -> (name paras)

; (let func ((va 1)(vb 2)) (body))

(define (let? exp) (tagged-list? exp 'let))
(define (named-let?) (symbol? (cadr exp)))
(define (named-let-name exp) (cadr exp))
(define (named-let-params exp) (caddr exp))
(define (named-let-body exp) (cdddr exp))

(define (get-let-var p) (car p))
(define (get-let-value p) (cadr p))

(define (named-let-vars exp) (map get-let-var (named-let-params exp)))
(define (named-let-values exp) (map get-let-value (named-let-params exp)))
(define (make-define name body) (cons 'define (cons name body)))
(define (named-let->define exp)
    (list (make-define (cons (named-let-name exp) (named-let-vars exp)) (named-let-body exp))
          (cons (named-let-name exp) (named-let-values exp))))

; 测试
(named-let->define '(let func ((va 1)(vb 2)) ((body1)(body2))))
;Value 13: ((define (func va vb) ((body1) (body2))) (func 1 2))