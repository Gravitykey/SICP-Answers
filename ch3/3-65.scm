(define (add-streams s1 s2)(stream-map + s1 s2))
(define (partial-sums s)
    (cons-stream
        (stream-car s)
        (add-streams (partial-sums s)
                     (stream-cdr s))))

(define (ln2-summands n)
    (cons-stream (/ 1.0 n)
                 (stream-map - (ln2-summands (+ n 1)))))

(define ln2-stream (partial-sums (ln2-summands 1)))

(define (euler-transform s)
    (let ((s0 (stream-ref s 0))
          (s1 (stream-ref s 1))
          (s2 (stream-ref s 2)))
        (cons-stream (- s2 (/ (square (- s2 s1))
                             (+ s0 (* -2 s1) s2)))
                     (euler-transform (stream-cdr s)))))

(define (make-tableau transform s)
    (cons-stream s (make-tableau transform (transform s))))

(define (accelerated-sequence transform s)
    (stream-map stream-car (make-tableau transform s)))


; 速度比较
(stream-head ln2-stream 9)
;Value 13: (1. .5 .8333333333333333 .5833333333333333 .7833333333333332 .6166666666666666 .7595238095238095 .6345238095238095 .7456349206349207)

(stream-head (euler-transform ln2-stream) 9)
;Value 14: (.7 .6904761904761905 .6944444444444444 .6924242424242424 .6935897435897436 .6928571428571428 .6933473389355742 .6930033416875522 .6932539682539683)

(stream-head (accelerated-sequence euler-transform ln2-stream) 9)
;Value 15: (1. .7 .6932773109243697 .6931488693329254 .6931471960735491 .6931471806635636 .6931471805604039 .6931471805599445 .6931471805599427)

; 超级加速器的收敛速度是指数级的