(load "ch3-3-5.scm")

; c = (* 0.5 (+ a b))
(define (averager a b c)
  (let ((u (make-connector))
        (v (make-connector)))
    (adder a b u)
    (multiplier u v c)
    (constant (/ 1 2) v)
    'OK))

; 测试
(define a (make-connector))
(define b (make-connector))
(define c (make-connector))

(averager a b c)
(probe "Num1" a)
(probe "Num2" b)
(probe "aver" c)

(set-value! a 4 'user)

#|
Probe: Num1 = 4
;Value: done
|#

(set-value! b 1 'user)
#| 
Probe: Num2 = 1
Probe: aver = 5/2
;Value: done 
|#
(forget-value! b 'user)
#| 
Probe: Num2 = ?
Probe: aver = ?
;Value: done
|#
(set-value! b 21 'user)
#| 
Probe: Num2 = 21
Probe: aver = 25/2
;Value: done
|#