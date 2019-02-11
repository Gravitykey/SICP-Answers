(load "ch3-3-5.scm")
(define (cv value)
  (define z (make-connector))
  (constant value z)
  z)

(define (c/ x y)
  (define z (make-connector))
  (multiplier z y x)
  z)

(define (c* x y)
  (define z (make-connector))
  (multiplier x y z)
  z)

(define (c+ x y)
  (define z (make-connector))
  (adder x y z)
  z)

(define (c- x y)
  (define z (make-connector))
  (adder z y x)
  z)


; 测试

(define (celsius-fahrenheit-converter x)
  (c+ (c* (c/ (cv 9 ) (cv 5))
          x)
      (cv 32)))
(define C (make-connector))
(define F (celsius-fahrenheit-converter C))
(probe "Celsius temp" C)
(probe "Fahrenheit temp" F)
(set-value! C 37 'user)

; Probe: Celsius temp = 37
; Probe: Fahrenheit temp = 493/5
; ;Value: done