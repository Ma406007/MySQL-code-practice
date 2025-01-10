insert into emp
values (7, '灭绝', 60, '财务总监', 8500, '2002-09-12', 1, 3);
insert into emp
values (8, '周芷若', 19, '会计', 48000, '2006-06-02', 7, 3);
insert into emp
values (9, '丁敏君', 23, '出纳', 5250, '2009-05-13', 7, 3);
insert into emp
values (10, '赵敏', 20, '市场部总监', 12500, '2004-10-12', 1, 2);
insert into emp
values (11, '鹿杖客', 56, '职员', 3750, '2006-10-03', 10, 2);
insert into emp
values (12, '鹤笔翁', 19, '职员', 3750, '2007-05-09', 10, 2);
insert into emp
values (13, '方东白', 19, '职员', 5500, '2009-02-12', 10, 2);
insert into emp
values (14, '张三丰', 88, '销售总监', 14000, '2004-10-12', 1, 4);
insert into emp
values (15, '俞莲舟', 38, '销售', 4600, '2004-10-12', 14, 4);
insert into emp
values (16, '宋远桥', 40, '销售', 4600, '2004-10-12', 14, 4);
insert into emp
values (17, '陈友凉', 42, null, 2000, '2011-10-12', 1, null);

create table salgrade
(
    grade int,
    losal int,
    hisal int
) comment '薪资等级表';

insert into salgrade
values (1, 0, 3000);
insert into salgrade
values (2, 3001, 5000);
insert into salgrade
values (3, 5001, 8000);
insert into salgrade
values (4, 8001, 10000);
insert into salgrade
values (5, 10001, 15000);
insert into salgrade
values (6, 15001, 20000);
insert into salgrade
values (7, 20001, 25000);
insert into salgrade
values (8, 25001, 30000);

-- practice
-- 1.查询员工的姓名,年龄,职位,部门信息(隐式内连接)
-- 表:emp, dept
-- 连接条件:emp.dept_id = dept.id
select e.name, e.age, e.job, d.name
from emp e,
     dept d
where e.dept_id = d.id;

-- 2.查询年龄小于30岁的员工的姓名,年龄,职位,部门信息(显示内连接)
-- 表:emp, dept
-- 连接条件:emp.dept_id = dept.id
select e.name, e.age, e.job, d.name
from emp e
         inner join dept d on e.dept_id = d.id
where e.age < 30;

-- 3.查询拥有员工的部门ID,部门名称
-- 表:emp, dept
-- 连接条件:emp.dept_id = dept.id
select distinct d.id, d.name
from emp e,
     dept d
where e.dept_id = d.id;

-- 4.查询所有年龄大于40岁的员工,及其所属的部门名称;如果员工没有分配部门,也要显示出来
-- 表:emp, dept
-- 连接条件:emp.dept_id = dept.id
select e.*, d.name
from emp e
         left join dept d on e.dept_id = d.id
where e.age > 40;

-- 5.查询所有员工的工资等级
-- 表:emp, salgrade
-- 连接条件:emp.salary between salgrade.losal and salgrade.hisal
select e.name, e.salary, s.grade
from emp e,
     salgrade s
where e.salary between s.losal and s.hisal;

-- 6.查询研发部所有员工的信息以及工资等级
-- 表:emp, salgrade, dept
-- 连接条件:emp.salary between salgrade.losal and salgrade.hisal, emp.dept_id = dept.id
-- 查询条件:dept.name = '研发部'
select e.*, s.grade
from emp e,
     dept d,
     salgrade s
where e.dept_id = d.id
  and e.salary between s.losal and s.hisal
  and d.name = '研发部';

select e.*, s.grade
from emp e
         inner join salgrade s on e.salary between s.losal and s.hisal
where e.dept_id = 1;

-- 7.查询研发部员工的平均工资
-- 表:emp, dept
-- 连接条件:emp.dept_id = dept.id
select avg(e.salary)
from emp e,
     dept d
where e.dept_id = d.id
  and d.name = '研发部';

-- 8.查询工资比灭绝高的员工信息
-- 表:emp
select *
from emp e
where e.salary > (select salary from emp e where e.name = '灭绝');

-- 9.查询比平均薪资高的员工信息
select *
from emp
where salary > (select avg(salary) from emp);

-- 10.查询低于本部门平均工资的员工信息
select *, (select avg(e1.salary) from emp e1 where e1.dept_id = e2.dept_id) '平均薪资'
from emp e2
where e2.salary < (select avg(e1.salary) from emp e1 where e1.dept_id = e2.dept_id);

-- 11.查询所有的部门信息,并统计部门的员工人数
select d.id, d.name, (select count(*) from emp e where e.dept_id = d.id) '人数'
from dept d;

-- 12.查询所有学生的选课情况,展示出学生名称,学号,课程名称
-- 表:student, course, student_course
-- 连接条件: student.id = student_course.studentid, course.id = student_course.courseid
select s.name, s.no, c.name
from student s,
     student_course sc,
     course c
where s.id = sc.studentid
  and sc.courseid = c.id;