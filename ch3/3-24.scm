; 需要改动assoc过程，在参数上加一个判断用的proc
(define (assoc key records proc?)
    (cond ((null? records) #f)
        ((proc? key (caar records)) (car records))
        (else (assoc key (cdr records) proc?))))

(define (make-table same-key?)
    (let ((local-table (list '*table*)))
    (define (lookup key-1 key-2)
      (let ((subtable (assoc key-1 (cdr local-table) same-key?)))
        (if subtable 
          (let ((record (assoc key-2 (cdr subtable) same-key?)))
            (if record
                (cdr record)
                #f))
    #f)))
    
    (define (insert! key-1 key-2 value)
      ; 调用assoc时需要传入判断用的过程
      (let ((subtable (assoc key-1 (cdr local-table) same-key?)))
        (if subtable
          (let ((record (assoc key-2 (cdr subtable) same-key?)))
            (if record
              (set-cdr! record value)
              (set-cdr! subtable
                        (cons (cons key-2 value)
                              (cdr subtable)))))
          (set-cdr! local-table
                    (cons (list key-1
                                (cons key-2 value))
                          (cdr local-table)))))
      'ok)

    (define (dispatch m)
        (cond ((eq? m 'lookup-proc) lookup)
            ((eq? m 'insert-proc!) insert!)
            (else (error "Unknown operation --TABLE" m))))
    dispatch
))

; 写一个简单判断过程
(define (simple-equal key1 key2)(equal? key1 key2))

; 做put/get 过程
(define operation-table (make-table simple-equal))
(define get (operation-table 'lookup-proc))
(define put (operation-table 'insert-proc!))

(put 'm 'n 1)
(get 'm 'n)
;Value: 1

(get 'a 'b)
;Value: #f


