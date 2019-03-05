; 该方法要确保test-and-set!的原子性
(define (make-semaphore n)
    (define (acquire)
        (if (test-and-set! n)
            (acquire)))
    (define (release)
        (set! n (+ n 1)))
    (define (dispatch m)
        (cond ((eq? m 'acquire) (acquire))
              ((eq? m 'release) (release))))
    dispatch
)


(define (test-and-set! cell)
    (without-interrupts
        (lambda()
    (if (= n 0)
        #t
        (begin (set! n (- n 1))
               #f)))))
