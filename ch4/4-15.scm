; 这道题目是图灵的停机问题
; 通俗的说，停机问题就是判断任意一个程序是否会在有限的时间之内结束运行的问题。
; 如果这个问题可以在有限的时间之内解决，则有一个程序判断其本身是否会停机并做出相反的行为，
; 这时候显然不管停机问题的结果是什么都不会符合要求。所以这是一个不可解的问题。

; (define (run-forever) (run-forever))
; (define (try p)
;  (if (halts? p p)
;      (run-forever)
;      'halted))

; 把try过程自身作为try的参数，求(try try)：
; (if (halts? try try))
; halts?过程判断(try try)是否能够终止

; 如果判断可以终止，那么程序将执行(run-forever)，从而(try try)进入无限循环，这与halts?过程的判断相矛盾。

; 如果判断不能终止，那么程序将执行'halted，从而(try try)返回'halted，终止，这也矛盾。

; 所以这就说明存在这样的过程try，以及参数try，使得halts?不能判断其求值是否终止