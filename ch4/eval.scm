;;;;;;;;;;;; page253
(define (eval exp env)
    (cond ((self-evaluating? exp) exp)
        ((variable? exp) (lookup-variable-value exp env))
        ((quoted? exp) (text-of-quotation exp))
        ((assignment? exp) (eval-assignment exp env))
        ((definition? exp) (eval-definition exp env))
        ((if? exp) (eval-if exp env))
        ((lambda? exp) (make-procedure (lambda-parameters exp)
                                       (lambda-body exp)
                                       env))
        ((begin? exp) (eval-sequence (begin-actions exp) env))
        ((cond? exp) (eval (cond->if exp) env))
        ((application? exp) (apply (eval (operator exp) env)
                            (list-of-values (operands exp) env)))
        (else (error "Unknown expression type -- EVAL" exp))))


(define (apply procedure arguments)
    (cond ((primitive-procedure? procedure) (apply-primitive-procedure procedure arguments))
          ((compound-procedure? procedure) (eval-sequence (procedure-body procedure)
                                                          (extend-environment
                                                                (procedure-parameters procedure)
                                                                arguments
                                                                (procedure-environment procedure))))
          (else error "Unknown procedure type -- APPLY" procedure)))

; 获取过程参数
(define (list-of-values exps env)
    (if (no-operands? exps)
        '()
        (cons (eval (first-operand exps) env)
              (list-of-values (rest-operands exps) env))))

; 条件
(define (eval-if exp env)
    (if (true? (eval (if-predicate exp) env))
        (eval (if-consequent exp) env)
        (eval (if-alternative exp) env)))

; 执行序列
(define (eval-sequence exps env)
    (cond ((last-exp? exps) (eval (first-exp exps) env))
        (else (eval (first-exp exps env))
              (eval-sequence (rest-exps exps) env))))

; 赋值和定义
(define (eval-assignment exp env)
    (set-variable-value! (assignment-variable exp)
                         (eval (assignment-value exp) env)
                         env))

(define (eval-definition exp env)
    (define-variable! (definition-variable exp)
                      (eval (definition-value exp) env)
                      env)
    'ok)

;;;;;;;;;;;;; 语法规范

; 是否是自求值
(define (self-evaluating? exp)
    (cond ((number? exp) #t)
          ((string? exp) #t)
          (else #f)))

; 是否是符号
(define (variable? exp) (symbol? exp))
(define (quoted? exp) (tagged-list? exp 'quote))
(define (text-of-quotation exp) (cadr exp))

(define (tagged-list? exp tag)
    (if (pair? exp)
        (eq? (car exp) tag)
        #f))

; 赋值
(define (assignment? exp)
    (tagged-list? exp 'set!))

(define (assignment-variable exp) (cadr exp))
(define (assignment-value exp) (caddr exp))

; 定义
(define (definition? exp)
    (tagged-list? exp 'define))

(define (definition-variable exp)
    (if (symbol? (cadr exp))
        (cadr exp) ;(define x 5)
        (caadr exp))) ;(define (proc x y))

(define (definition-value exp)
    (if (symbol? (cadr exp))
        (caddr exp)
        (make-lambda (cdadr exp) ;参数
                     (cddr exp)))) ;lambda主体

; lambda
(define (lambda? exp) (tagged-list? exp 'lambda))
(define (lambda-parameters exp) (cadr exp))
(define (lambda-body exp) (cddr exp))

; lambda构造函数
(define (make-lambda parameters body)
    (cons 'lambda (cons parameters body)))

; 条件式
(define (if? exp) (tagged-list? exp 'if))
(define (if-predicate exp) (cadr exp))
(define (if-consequent exp) (caddr exp))
(define (if-alternative exp)
    (if (not (null? (cdddr exp)))
        (cadddr exp)
        #f))

; if 构造函数
(define (make-if predicate consequent alternative)
    (list 'if predicate consequent alternative))

; begin语句序列
(define (begin? exp) (tagged-list? exp 'begin))
(define (begin-actions exp) (cdr exp))
(define (last-exp? seq) (null? (cdr exp)))
(define (first-exp seq) (car seq))
(define (rest-exps seq) (cdr seq))

; 把序列构造成begin
(define (sequence->exp seq)
    (cond ((null? seq) seq)
          ((last-exp? seq) (first-exp seq))
          (else (make-begin seq))))
(define (make-begin seq) (cons 'begin seq))

; 如果不是上面的类型，那么是应用
(define (application? exp) (pair? exp))
(define (operator exp) (car exp))
(define (operands exp) (cdr exp))
(define (no-operands? ops) (null? (cdr exp)))
(define (first-operand ops) (car ops))
(define (rest-operands ops) (cdr ops))

; 派生表达式 cond
(define (cond? exp) (tagged-list? exp 'cond))
(define (cond-clauses exp) (cdr exp))
(define (cond-else-clause? clause) 
    (eq? (cond-predicate clause) 'else))
(define (cond-predicate clause) (car clause))
(define (cond-actions clause) (cdr clause))

(define (cond->if exp)
    (expand-clauses (cond-clauses exp)))

(define (expand-clauses clauses)
    (if (null? clauses)
        #f
        (let ((first (car clauses))
              (rest (cdr clauses)))
          (if (cond-else-clause? first)
              (if (null? rest)
                  (sequence->exp (cond-actions first)) 
                  (error "ELSE clause isn't last -- COND->IF" clauses))
              (make-if (cond-predicate first)
                       (sequence->exp (cond-actions first))
                       (expand-clauses rest))))))
