(load "2-68.scm")
(load "2-69.scm")

(define s-pairs 
    '((A 2)(NA 16)(BOOM 1)(SHA 3)(GET 2)(YIP 2)(JOB 2)(WAH 1)))

(define s-tree (generate-huffman-tree s-pairs))


(encode 
    '(Get a job
     Sha na na na na na na na na 
     Get a job 
     Sha na na na na na na na na 
     Wah yip yip yip yip yip yip yip yip yip 
     Sha boom) s-tree)

;Value 14: 
;(0 1 1 0 0 1 1 1 0 1 0 0 0 0 1 1
; 1 1 1 1 1 1 1 0 1 1 0 0 1 1 1 0
; 1 0 0 0 0 1 1 1 1 1 1 1 1 1 0 0
; 0 0 0 1 0 1 0 1 0 1 0 1 0 1 0 1
; 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1
; 0 1 0 1 0 1 0 0 1 0 0 0 1)
; 总共93 bit

(decode '(0 1 1 0 0 1 1 1 0 1 0 0 0 0 1 1 1 1 1
 1 1 1 1 0 1 1 0 0 1 1 1 0 1 0 0 0 0 1 1 1 1 1 
 1 1 1 1 0 0 0 0 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 
 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 0 
 1 0 0 0 1) s-tree)
;Value 15: (get a job sha na na na na na na na na get a job sha na na na na na na nana wah yip yip yip yip yip yip yip yip yip sha boom)

; huffman编码的结果是93bit，如果采用定长编码，共8个符号，每个占3bit，那么需要36*3 即108bit

