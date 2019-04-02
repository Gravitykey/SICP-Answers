; 自带的map是预置好的功能，对第二个参数，即函数的解释，不会走我们自己的定义。

; 例如，'(map + (1 2) (3 4))被我们自己的求值器展开后，结果是
; (apply map (list 'application + env) (list 1 2) (list 3 4)))

; 系统自带的map 不会处理(list 'application + env)
; 所以最终解决方案还是自己再实现一遍map