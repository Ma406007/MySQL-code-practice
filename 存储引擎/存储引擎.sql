-- 存储引擎:就是存储数据,建立索引,更新/查询数据等技术的实现方式.是基于表的,而不是基于库的,所以存储引擎也可被称为表类型

-- 查询建表语句 ---默认的存储引擎是InnoDB
show create table account;

-- 查看当前数据库支持的所有存储引擎
show engines;

-- 创建表my_myisam,使用MyISAM存储引擎
create table my_myisam
(
    id   int,
    name varchar(10)
) engine = MyISAM;

-- 创建表my_memory,使用Memory存储引擎
create table my_memory
(
    id   int,
    name varchar(10)
) engine = Memory;

-- 存储引擎的特点

-- InnoDB是一种兼顾高性能和高可靠性的通用存储引擎,在MySQL5.5之后的版本都是默认的存储引擎
-- 特点:DML操作遵循ACID原则,支持事务;行级锁,提高并发访问性能;支持外键foreign key约束,保证数据的完整性和正确性
-- 文件:xxx.ibd中xxx代表的是表名,InnoDB存储引擎的每张表都会对应这样一个表空间文件,存储该表的表结构(frm,sdi),数据和索引

-- MyISAM是MySQL的早期默认存储引擎
-- 特点:不支持事务,不支持外键;支持表锁,不支持行锁;访问速度快
-- 文件:xxx.sdi中xxx代表的是表名,存储表结构(frm,sdi);xxx.MYD中xxx代表的是表名,存储数据;xxx.MYI中xxx代表的是表名,存储索引

-- Memory引擎的表数据是存储在内存中的,由于受到硬件问题或断电问题的影响,只能将这些表作为临时表或缓存使用
-- 特点:内存存放;哈希索引;数据的处理速度快
-- 文件:xxx.sdi中xxx代表的是表名,存储表结构(frm,sdi)

-- InnoDB和MyISAM的三大区别:InnoDB支持事务,MyISAM不支持事务;InnoDB支持外键,MyISAM不支持外键;InnoDB支持行锁,MyISAM支持表锁

-- 存储引擎的选择
-- InnoDB:如果应用对事务的完整性有比较高的要求,在并发条件下要求数据的一致性,数据操作除了插入和查询以外,还包含很多的更新,删除操作,那么InnoDB存储引擎应该是比较合适的选择
-- MyISAM:如果应用是以读操作和插入操作为主,只有很少的更新和删除操作,并且对事务的完整性、并发性要求不是很高,那么选择这个存储引擎是比较合适的
-- Memory:将所有的数据全部存储到内存中,访问速度快,但是安全性不高,如果需要提高访问速度,就可以选择这个引擎