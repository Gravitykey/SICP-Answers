(define (ripple-carry-adder a-list b-list s-list c) 
    (let ((c-list (map (lambda (x) (make-wire)) (cdr a-list))) 
          (c-0 (make-wire))) 
      (map full-adder 
           a-list 
           b-list 
           (append c-list (list c-0)) 
           s-list 
           (cons c c-list)) 
      'ok)) 