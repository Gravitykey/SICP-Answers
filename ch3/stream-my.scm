
; 注意! mit-scheme中，delay,force以及流相关的操作已经有完整的实现。
; 不推荐重写delay，force等一系列过程!!
; 此文件中，所有stream开头的过程，全部被替换为my-stream开头
; 为的是避免与解释器自带过程的冲突
; https://en.wikipedia.org/wiki/Scheme_(programming_language)
; 页面中检索delay会有相关信息

; 更新！！！！
; 该文件尝试改动失败，重写所有过程并不能正确生效。
; 好像 (lambda() x )会被自动处理成#[promise xx]类型
; 用自定义的my-force去执行会出问题。
; 但是用原生force，流末尾的lambda会被认作#[compound-procedure xx]
; 同样导致执行错误
; 该文件弃用

(define the-empty-my-stream '())
(define (my-stream-null? s) (null? s))

(define (my-stream-ref s n)
    (if (= n 0)
        (my-stream-car s)
        (my-stream-ref (my-stream-cdr s) (- n 1))))

(define (my-stream-map proc s)
    (if (my-stream-null? s)
        the-empty-my-stream
        (cons-stream (proc (my-stream-car s))
                     (my-stream-map proc (my-stream-cdr s)))))

(define (my-stream-for-each proc s)
    (if (my-stream-null? s)
        'done
        (begin (proc (my-stream-car s))
               (my-stream-for-each proc (my-stream-cdr s)))))

(define (display-my-stream s)
    (my-stream-for-each display-line s))

(define (display-line x)
    (newline)
    (display x))

(define (my-stream-car stream) (car stream))
(define (my-stream-cdr stream) (force (cdr stream)))

(define (cons-my-stream a b)
    (cons a (my-delay b)))

(define (stream-enumerate-interval low high)
    (if (> low high)
        the-empty-my-stream
        (cons-my-stream low (stream-enumerate-interval (+ low 1) high))))

(define (my-stream-filter pred stream)
    (cond ((my-stream-null? stream) the-empty-stream)
          ((pred (my-stream-car stream)) 
            (cons-my-stream (my-stream-car stream)
                         (my-stream-filter pred (my-stream-cdr stream))))
          (else (my-stream-filter pred (my-stream-cdr stream)))))


(define (my-delay x) (memo-proc (lambda () x)))

(define (my-force delayed-object)
    (delayed-object))

(define (memo-proc proc)
    (let ((already-run? #f) (result #f))
        (lambda ()
            (if (not already-run?)
                (begin (set! result (proc))
                       (set! already-run? #t)
                       result)
                result))))
