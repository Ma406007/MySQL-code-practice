create table dept(
    id int auto_increment comment 'ID' primary key,
    name varchar(50) not null comment '部门名称'
)comment '部门表';
insert into dept(id, name) values
        (1, '研发部'), (2, '市场部'), (3, '财务部'), (4, '销售部'), (5, '总经办');

create table emp(
    id int auto_increment comment 'ID' primary key,
    name varchar(50) not null comment '姓名',
    age int comment '年龄',
    job varchar(20) comment '职位',
    salary int comment '薪资',
    entrydate date comment '入职时间',
    managerid int comment '直属领导ID',
    dept_id int comment '部门ID'
)comment '员工表';

insert into emp(id, name, age, job, salary, entrydate, managerid, dept_id)  values
        (1, '金庸', 66, '总裁', 20000, '2000-01-01', null, 5),(2, '张无忌', 20, '项目经理', 12500, '2005-12-05', 1, 1),
        (3, '杨逍', 33, '开发', 8400, '2000-11-03', 2, 1),(4, '韦一笑', 48, '开发', 11000, '2002-02-05', 2, 1),
        (5, '常遇春', 43, '开发', '10500', '2004-09-07', 3, 1),(6, '小昭', 19, '程序员鼓励师', 6600, '2004-10-12', 2 ,1);

-- 添加外键
alter table emp add constraint fk_emp_dept_id foreign key (dept_id) references dept(id);

-- 删除外键
alter table emp drop foreign key fk_emp_dept_id;

-- 外键的删除和更新行为
alter table emp add constraint fk_emp_dept_id foreign key (dept_id) references dept(id) on update cascade on delete cascade;
alter table emp add constraint fk_emp_dept_id foreign key (dept_id) references dept(id) on update set null on delete set null;

-- 多表关系
-- 多对多
create table student(
    id int auto_increment primary key comment '主键ID',
    name varchar(10) comment '姓名',
    no varchar(10) comment '学号'
)comment '学生表';
insert into student values (null, '黛绮丝', '2000100101'),(null, '谢逊', '2000100102'),(null, '殷天正', '2000100103'),(null, '韦一笑', '2000100104');

create table course(
    id int auto_increment primary key comment '主键ID',
    name varchar(10) comment '课程名称'
)comment '课程表';
insert into course values (null, 'Java'),(null, 'PHP'),(null, 'MySQL'),(null, 'Hadoop');

create table student_course(
    id int auto_increment primary key comment '主键',
    studentid int not null comment '学生ID',
    courseid int not null comment '课程ID',
    constraint fk_courseid foreign key (courseid) references course (id),
    constraint fk_studentid foreign key (courseid) references student (id)
)comment '学生课程中间表';
insert into student_course values (null,1,1),(null,1,2),(null,1,3),(null,2,2),(null,2,3),(null,3,4);

-- 一对一
create table tb_user(
    id int auto_increment primary key comment '主键ID',
    name varchar(10) comment '姓名',
    age int comment '年龄',
    gender char(1) comment '1:男,2:女',
    phone char(11) comment '手机号'
)comment '用户基本信息表';
insert into tb_user(id, name, age, gender, phone) values
        (null, '黄渤', 45, '1','18800001111'),
        (null, '冰冰', 35, '2','18800002222'),
        (null, '码云', 55, '1','18800003333'),
        (null, '李彦宏', 50, '1','18800004444');

create table tb_user_edu(
    id int auto_increment primary key comment '主键ID',
    degree varchar(20) comment '学历',
    major varchar(50) comment '专业',
    primaryschool varchar(50) comment '小学',
    middleschool varchar(50) comment '中学',
    university varchar(50) comment '大学',
    userid int unique comment '用户ID',
    constraint fk_userid foreign key (userid) references tb_user(id)
)comment '用户教育信息表';
insert into tb_user_edu (id, degree, major, primaryschool, middleschool, university, userid) values
        (null , '本科', '舞蹈', '静安区第一小学', '静安区第一中学', '北京舞蹈学院', 1),
        (null , '硕士', '表演', '朝阳区第一小学', '朝阳区第一中学', '北京电影学院', 2),
        (null , '本科', '英语', '杭州市第一小学', '杭州市第一中学', '杭州师范大学', 3),
        (null, '本科', '应用数学', '阳泉第一小学', '阳泉区第一中学', '清华大学', 4);


-- 多表查询(直接查是笛卡尔积,即两表行数的乘积,故需要消除无效的笛卡尔积)
select * from emp, dept where emp.dept_id = dept.id;


-- 内连接
-- 1.查询每个员工的姓名以及关联部门的名称(隐式内连接实现)
-- 表结构:emp,dept
-- 连接条件:emp.dept_id = dept.id
select emp.name, dept.name from emp, dept where emp.dept_id = dept.id;
-- 为表起别名(起了别名后就不能再使用原表名)
select e.name, d.name from emp e, dept d where e.dept_id = d.id;

-- 2.查询每个员工的姓名以及关联部门的名称(显示内连接实现) -- inner join ... on ...
-- 表结构:emp,dept
-- 连接条件:emp.dept_id = dept.id
select e.name, d.name from emp e inner join dept d on e.dept_id = d.id;
-- inner可以省略
select e.name, d.name from emp e join dept d on e.dept_id = d.id;

-- 左外连接(用的更多)
-- select 字段列表 from 表1 left [outer] join 表2 on 连接条件...;
-- 1.查询emp表的所有数据及关联部门的名称(左外连接实现)
select e.*, d.name from emp e left join dept d on e.dept_id = d.id;

-- 右外连接
-- select 字段列表 from 表1 right [outer] join 表2 on 连接条件...;
-- 2.查询dept表的所有数据及对应员工的信息(右外连接实现)
select d.*, e.* from emp e right join dept d on e.dept_id = d.id;
-- 等价于(左外->右外)
select d.*, e.* from dept d left join emp e on e.dept_id = d.id;

-- 自链接(可以是内连接也可以是外连接)
-- select 字段列表 from 表1 别名1 join 表1 别名2 on 连接条件...;
-- 1.查询员工表中员工的姓名及其直接上级的姓名
select e1.name, e2.name from emp e1 join emp e2 on e1.managerid = e2.id;
-- 2.查询所有员工emp及其领导的名字emp,如果没有领导也需要查询出来
select e1.name '员工', e2.name '领导' from emp e1 left join emp e2 on e1.managerid = e2.id;

-- 联合查询-union,union all
-- 对于union就是把多次查询的结果合并起来,但是会去重,对于union all就是把多次查询的结果合并起来,但是不去重
-- select 字段列表 from 表1 union [all] select 字段列表 from 表2...;
-- 多张表的列数必须保持一致,字段类型也是
-- 1.将薪资低于5000的员工和年龄大于50岁的员工全部查询出来
select emp.name from emp where emp.salary < 5000
union
select emp.name from emp where emp.age > 50;


-- 子查询:SQL语句中嵌套select语句(又称为嵌套查询)
-- select * from t1 where column1 = (select column1 from t2);
-- 根据查询结果不同分为四类:

-- 标量子查询(子查询结果为单个值)
-- 1.查询研发部的所有员工的信息
select * from emp where dept_id = (select id from dept where name = '研发部');
-- 2.查询在杨逍入职之后的员工信息
select * from emp where entrydate > (select entrydate from emp where name = '杨逍');

-- 列子查询(子查询结果为一列)
-- 1.查询研发部和总经办的所有员工的信息
select * from emp where dept_id in (select id from dept where name = '研发部' or name = '总经办');
-- 2.查询比研发部所有人工资都高的员工的信息
select * from emp where salary > all (select salary from emp where dept_id = (select id from dept where name = '研发部'));
-- 3.查询比研发部任意一人工资高的员工信息
select * from emp where salary > any (select salary from emp where dept_id = (select id from dept where name = '研发部'));

-- 行子查询(子查询结果为一行)
-- 1.查询与张无忌的薪资及直属领导相同的员工信息
select * from emp where (salary, managerid) = (select salary, managerid from emp where name = '张无忌');

-- 表子查询(子查询结果为多行多列)
-- 1.查询与杨逍的职位和薪资相同的员工信息
select * from emp where (salary, job) in (select salary, job from emp where name = '杨逍');
-- 2.查询入职日期是2001-01-01之后的员工信息及其部门信息
select e.*, d.* from (select * from emp where entrydate > '2001-01-01') e left join dept d on e.dept_id = d.id;