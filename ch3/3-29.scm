; 布尔代数里的德·摩根律(反演律)(a+b)′=a′·b′，(a·b)′=a′+b′.
; (A or B) 等值于 (not ((not A) and (not B)))
; 于是可以重定义


(define (or-gate a1 a2 output)
  (let ((c1 (make-wire)) 
    (c2 (make-wire)) 
    (c3 (make-wire))) 
  (inverter a1 c1) 
  (inverter a2 c2) 
  (and-gate c1 c2 c3) 
  (inverter c3 output)))

; 延时：信号流经顺序为非门->与门->非门
; 总延时为 2个非门延时 加 与门延时

