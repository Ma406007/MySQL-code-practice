create table account
(
    id    int auto_increment primary key comment '主键ID',
    name  varchar(20) comment '姓名',
    money int comment '余额'
) comment '账户表';
insert into account (id, name, money)
values (null, '张三', 2000),
       (null, '李四', 2000);

-- 恢复数据
update account
set money = 2000
where name = '张三'
   or name = '李四';

-- 转账操作(张三给李四转账1000)
-- 1.查询张三账户余额
select *
from account
where name = '张三';

-- 2.将张三账户余额-1000
update account
set money = money - 1000
where name = '张三';

-- 3.将李四账户余额+1000
update account
set money = money + 1000
where name = '李四';


-- 事务操作
-- 查看/设置事务的提交方式
-- select @@autocommit;查看事务的提交方式

-- 方法一
-- set @@autocommit = 0;设置事务的提交方式(1:自动提交,0:手动提交)
-- 提交事务
-- commit;
-- 回滚事务
-- rollback;

-- 方法二
-- 开启事务
-- start transaction 或 begin;
-- 提交事务
-- commit;
-- 回滚事务
-- rollback;



-- 事务的四大特性(ACID)
-- 原子性:事务是不可分割的最小操作单元,要么全部成功,要么全部失败
-- 一致性:事务完成时,必须使所有的数据都保持一致状态
-- 隔离性:数据库系统提供的隔离机制,保证事务在不受外部并发操作影响的独立环境下运行
-- 持久性:事务一旦提交或回滚,它对数据库中的数据的改变就是永久的


-- 并发事务的问题(需要模拟要用命令行窗口模拟两个并发事件)
-- 脏读:一个事务读取到了另一个事务未提交的数据
-- 不可重复读:一个事务先后读取同一条记录,但两次读取的数据不同,称之为不可重复读
-- 虚读(幻读):一个事务按条件查询数据时,没有对应的数据行,但是在插入数据时,又发现这行数据已经存在,好像出现了"幻影"(以解决不可重复读为前提才会出现的问题)


-- 事务的隔离级别(事务隔离级别越高,性能越低)
-- 读未提交:read uncommitted (会出现脏读,不可重复读,虚读)
-- 读已提交:read committed (会出现不可重复读,虚读)
-- 可重复读:repeatable read(默认) (会出现虚读)
-- 串行化:serializable (不会出现任何问题)

-- 查看事务的隔离级别
-- select @@transaction_isolation;
-- 设置事务的隔离级别
-- set session/global transaction isolation level 隔离级别;(session:当前会话,global:全局)