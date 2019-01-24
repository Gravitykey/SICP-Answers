(define memo-fib
  (memoize ((lambda (n)
            (cond ((= n 0) 0)
            ((= n 1) 1)
            (else (+ (memo-fib (-n 1))
                     (memo-fib (-n 2)))))))))

(define (memoize f)
    (let ((table (make-table)))
      (lambda (x)
        (let ((previously-computed-result (lookup x table)))
      ;or操作有短路作用，如果第一个参数不为假，那么直接返回第一个参数，且不计算后面的
          (or previously-computed-result
            ; 如果lookup x table 返回的是#f，那么会执行下面的语句
            ; 执行f x ，将结果插入参数x对应的表格，然后返回result 
            (let ((result (f x)))
              (insert! x result table)
              result))))))

; 环境图略

; 容易产生疑问的地方：
; 为什么可以多次递归调用memo-fib，而不破坏memoize内的table
; 每次递归memo-fib的时候，不会产生新的table吗？
; 乍一看代码很有迷惑性，写的有些绕，好像memoize被调用了多次。
; 仔细看memoize的代码，它的返回结果是一个lambda表达式。

; memoize返回的是一个过程。且绑定给了memo-fib。
; 注意，memo-fib下面的过程并不是定义的memo-fib，这个以n为参数的lambda实际上是传给memoize的参数

; 执行完define memo-fib后，memoize处理后的生成的过程会与memo-fib绑定
; 递归的时候，调用memo-fib，就是调用这个已经绑定好的过程。
; 此处并不会重新去执行memoize。

; 或者我们换个清晰点的写法

(define (calc-fib n)
  (cond ((= n 0) 0)
    ((= n 1) 1)
    (else (+ (memo-fib (-n 1)) ;这里写memo-fib的时候，有点预见未来的性质了
             (memo-fib (-n 2))))))

; 注意，这里memo-fib仅仅是绑定一个名字，并不是定义过程
; 它绑定的是(memozie calc-fib的返回值)
(define memo-fib (memoize calc-fib))

;;;;;;;;;;;;;;;;;;;;;;;;
; 如果定义为(memoize fib),还能工作吗?
; 不行
; 如果只是简单使用fib，不会记忆中间步骤。
; 比如算第4项，算完后只会记住第4项，而中间过程中的fib(3) fib(2)的结果是丢失的
; 再次计算fib(5)时，同样也拿不到fib(4)的值
; 递归过程中仍然存在大量计算。


