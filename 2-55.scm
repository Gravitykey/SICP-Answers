(car ''abracadabra)

;等价于 

(car (quote (quote (abracadabra))))

;等价于
(car '(quote abracadabra))

;所以会输出quote