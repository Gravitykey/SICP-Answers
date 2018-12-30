; 需要修改的地方，是读取tag，添加tag，获取contents时加一层number?的判断

(define (attach-tag type-tag contents)
    (if (number? contents)
        contents
        (cons type-tag contents)))

(define (type-tag datum)
    (cond   ((number? datum) 'scheme-number)
            ((pair? datum) (car datum))
            (else (error "Bad tagged datum -- TYPE-TAG" datum))))

(define (contents datum)
    (cond ((number? datum) datum)
          ((pair? datum) (cdr datum))
          (else (error "Bad tagged datum -- CONTENT" datum))))

