; a） application? 这个过程直接检查表达式是不是pair。只要是复合的list或者其它exp都会被当成application
;     特例情况必须在前面排除。否则会被当成一般情况被eval掉。
;     题中讲的(define x 3)会被当成普通的过程来执行，而不是把define认成关键字。

; b） 改变如下
(define (application? exp) (tagged-list? exp 'call)) 
    (define (operator exp) (cadr exp)) 
    (define (operands exp) (cddr exp)) 