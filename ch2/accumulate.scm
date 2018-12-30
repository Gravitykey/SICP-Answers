;书上78页给出的accumulate定义
(define (accumulate op initial sequence)
    (if(null? sequence)
        initial
        (op (car sequence) (accumulate op initial (cdr sequence)))))

;练习2-36中的accumulate-n
(define (accumulate-n op init seqs)
    (if(null? (car seqs))
        '()
        (cons (accumulate op init 
                (let loop1((x seqs))
                    (if (null? x)
                        '()
                        (cons (caar x) (loop1 (cdr x)))
                    )))
              (accumulate-n op init 
                (let loop2((x seqs))
                    (if (null? x)
                        '()
                        (cons (cdar x) (loop2 (cdr x)))
                    ))))))