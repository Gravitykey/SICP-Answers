; 书上给的random-in-range定义
(define (random-in-range low high)
    (let ((range (- high low)))
        (+ low (random range))))

; 书p155给出的蒙特卡洛测试过程
(define (monte-carlo trials experiment)
    (define (iter trials-remaining trials-passed)
        (cond ((= trials-remaining 0) (/ trials-passed trials))
            ((experiment) (iter (- trials-remaining 1) (+ trials-passed 1)))
            (else (iter (- trials-remaining 1) trials-passed))))
    (iter trials 0))

; 定义谓词P，即圆内
(define (P? x0 y0 r px py)
    (<= (+  (* (- px x0) (- px x0))
            (* (- py y0) (- py y0)))
        (* r r)))

; 定义测试过程的生成器
(define (test-builder x0 y0 r x1 x2 y1 y2)
    (lambda () (P? x0 y0 r (random-in-range x1 x2) (random-in-range y1 y2))))

; 在2x2的矩形中测试圆心为1,1，半径为1的圆，结果理论值为pi/4
; 如果不用浮点数做参数，会导致随机数生成出来的都是整数
(monte-carlo 1000000 (test-builder 1.0 1.0 1.0 0.0 2.0 0.0 2.0))

;Value: 157139/200000

;得到的结果约等于3.14278



