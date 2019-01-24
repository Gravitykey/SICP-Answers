(define (make-table) 
    (define (entry tree) (car tree)) 
    (define (left-branch tree) (cadr tree)) 
    (define (right-branch tree) (caddr tree)) 
    (define (make-tree entry left right) 
      (list entry left right)) 
   
    (define (node-key entry) 
      (car entry)) 
    (define (node-value entry) 
      (cdr entry)) 
    (define (make-node key value) 
      (cons key value)) 
    (define (set-value! node value) 
      (set-cdr! node value)) 
   
    (let ((root (list ))) 
   
      (define (lookup key) 
        (define (iter tree) 
          (cond ((null? tree) #f) 
                (else 
                 (let ((node (entry tree)) 
                       (left (left-branch tree)) 
                       (right (right-branch tree))) 
                   (cond ((= key (node-key node)) (node-value node)) 
                         ((< key (node-key node)) (iter left)) 
                         ((> key (node-key node)) (iter right))))))) 
        (iter root)) 
   
      (define (insert! key value) 
        (define (iter tree) 
          (cond ((null? tree) (make-tree (make-node key value) '() '())) 
                (else 
                 (let ((node (entry tree)) 
                       (left (left-branch tree)) 
                       (right (right-branch tree))) 
                   (cond ((= key (node-key node)) 
                          (set-value! node value) 
                          tree) 
                         ((< key (node-key node))  
                          (make-tree node (iter left) right)) 
                         ((> key (node-key node)) 
                          (make-tree node left (iter right)))))))) 
        (set! root (iter root))) 
   
      (define (dispatch m) 
        (cond ((eq? m 'lookup-proc) lookup) 
              ((eq? m 'insert-proc!) insert!) 
              ((eq? m 'display) (display root) (newline)) 
              (else (error "Unknown operation -- TREE" m)))) 
   
      dispatch)) 
   
(define (show tree) (tree 'display)) 
(define (lookup tree key) ((tree 'lookup-proc) key)) 
(define (insert! tree key value) ((tree 'insert-proc!) key value))

(define op-table (make-table))
(define (get key) (lookup op-table key))
(define (put key value) (insert! op-table key value))

(put 1 'first)
(put 2 'second)

(get 1)
;Value: first
(get 2)
;Value: second
(show op-table)
; ((1 . first) () ((2 . second) () ()))
