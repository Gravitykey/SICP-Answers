(define (squarer a b)
  (define (process-new-value)
    (if (has-value? b)
      (if (< (get-value b) 0)
        (error "square less than 0 -- SQUARER" (get-value b))
        (set-value! a (sqrt (get-value b)) me))
      (if (has-value? a)
        (set-value! b (square (get-value a)) me))))
  (define (process-forget-value)
    (forget-value! a me)
    (forget-value! b me))
  (define (me request)
    (cond ((eq? request 'I-have-a-value)
            (process-new-value))
          ((eq? request 'I-lost-my-value)
            (process-forget-value))
          (else (error "Unknown request -- SQUARER" request))))
  (connect a me)
  (connect b me))


; 测试
(load "ch3-3-5.scm")

(define a (make-connector))
(define b (make-connector))
(define a2 (make-connector))
(define b2 (make-connector))

(squarer a b)
(squarer a2 b2)

(probe "first A" a)
(probe "first B" b)

(probe "another A" a2)
(probe "another B" b2)

(set-value! a 3 'user)
; Probe: first A = 3
; Probe: first B = 9
; ;Value: done

(set-value! b2 16 'user)
; Probe: another B = 16
; Probe: another A = 4
; ;Value: done