create database asgn5;
use asgn5;

create table stud_marks (
  roll int primary key,
  name varchar(30),
  total_marks int
);

create table result (
  roll int,
  name varchar(30),
  class varchar(30)
);

delimiter $$

-- procedure for grading
create procedure proc_grade(in p_roll int, in p_name varchar(30), in p_marks int)
begin
    declare v_class varchar(30);

    -- error handler
    declare exit handler for sqlexception
    begin
        select 'error occurred while processing proc_grade' as message;
        rollback;
    end;

    if p_marks between 990 and 1500 then
        set v_class = 'distinction';
    elseif p_marks between 900 and 989 then
        set v_class = 'first class';
    elseif p_marks between 825 and 899 then
        set v_class = 'higher second class';
    else
        set v_class = 'fail';
    end if;

    insert into stud_marks (roll, name, total_marks) values (p_roll, p_name, p_marks);
    insert into result (roll, name, class) values (p_roll, p_name, v_class);
end$$

-- function for grading
create function func_grade(p_marks int) returns varchar(30)
deterministic
begin
    declare v_class varchar(30);

    if p_marks between 990 and 1500 then
        set v_class = 'distinction';
    elseif p_marks between 900 and 989 then
        set v_class = 'first class';
    elseif p_marks between 825 and 899 then
        set v_class = 'higher second class';
    else
        set v_class = 'fail';
    end if;

    return v_class;
end$$

delimiter ;

call proc_grade(1, 'Ashish', 1200);
call proc_grade(2, 'Ashu', 950);
call proc_grade(3, 'random1', 860);
call proc_grade(4, 'random2', 700);

select * from stud_marks;
select * from result;
