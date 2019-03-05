; 注意! mit-scheme中，delay,force等流操作已经有完整的实现。
; 不推荐重写
; 该文件中尽量使用解释器自带的原生过程，不去重定义，避免冲突

; mit-scheme 9.1.1中
; 自带的force生成的类型为#[promise xx]，这是原生delay才会生成的类型。
; 如果使用自定义的force来执行会触发
; ;The object #[promise 13] is not applicable.
; 如果使用原生force来执行整个过程,则会导致在前几步发生下面情况情况
; ;The object #[compound-procedure 13], passed as an argument to force, is not a promise.

; 具体细节没搞明白，stream-my文件已废，调试失败


; https://en.wikipedia.org/wiki/Scheme_(programming_language)
; 页面中有流操作的相关信息


(define (display-stream s)
    (stream-for-each display-line s))

(define (display-line x)
    (newline)
    (display x))


(define (stream-enumerate-interval low high)
    (if (> low high)
        the-empty-stream
        (cons-stream low (stream-enumerate-interval (+ low 1) high))))




