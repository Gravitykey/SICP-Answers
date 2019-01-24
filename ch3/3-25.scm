  (define (make-table) 
    (let ((local-table (list '*table*))) 
      (define (assoc key records) 
        (cond ((null? records) false) 
              ((equal? key (caar records)) (car records)) 
              (else (assoc key (cdr records))))) 
   
      (define (lookup key-list) 
        (define (iter keys table) 
          (cond ((null? keys) false) ;为空时 
                ((null? (cdr keys))  ;只有一个key时 
                 (let ((record (assoc (car keys) (cdr table)))) 
                   (if record 
                       (cdr record) 
                       false))) 
                ;有多个key时,先取出一个，用于找到subtable，然后剩下的再循环再 
                (else 
                 (let ((subtable (assoc (car keys) (cdr table)))) 
                   (if subtable 
                       (iter (cdr keys) subtable) 
                       false))))) 
        (iter key-list local-table)) 
   
      (define (insert! value key-list) 
        (define (iter keys table)
             ;这是当没有找到key对应的subtable时，需要创建新的subtable 
          (cond ((null? table)   
                 (if (null? (cdr keys)) 
                     (cons (car keys) value) 
                     (list (car keys) (iter (cdr keys) '())))) 
                ;只有一个key 
                ((null? (cdr keys)) 
                    (let ((record (assoc (car keys) (cdr table)))) 
                      (if record 
                          (set-cdr! record value) 
                          (set-cdr! table 
                                    (cons (cons (car keys) value) 
                                          (cdr table)))))) 
                 ;有多个key
                (else  
                 (let ((subtable (assoc (car keys) (cdr table)))) 
                   (if subtable 
                       (iter (cdr keys) subtable) 
                       (set-cdr! table 
                                 (cons (list (car keys) 
                                             (iter (cdr keys) '()))   ;没找到subtable时，创建新的，然后循环(cdr keys) 
                                       (cdr table)))))))) 
        (iter key-list local-table) 
        'ok)     
      (define (dispatch m) 
        (cond ((eq? m 'lookup-proc) lookup) 
              ((eq? m 'insert-proc!) insert!) 
              (else (error "Unknown operation -- TABLE" m)))) 
      dispatch)) 
   
  (define (lookup table . key-list) ((table 'lookup-proc) key-list)) 
  (define (insert! table value . key-list) ((table 'insert-proc!) value key-list))