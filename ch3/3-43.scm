#| 
1、
因为原始账户余额为 10 20 30,
且交换是顺序进行，每次交换又是独立的
所以不管怎么换，还是10 20 30这三个数

2、
如果不加锁，会导致意外结果
举例

线程1 读账户1 得10
线程2 读账户2 得20
线程3 交换账户1，账户3 ,此时账户1为30，账户3为10
线程1 读账户2得20
线程2 读账户3得10
线程1 从账户2转 10 给账户1  此时账户1为40  账户2为10
线程2 从账户2转 10 给账户3  此时账户2为0  账户3为20

最后结果 账户1 40， 账户2 0，账户3,20
|#