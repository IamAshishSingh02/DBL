create database asgn5;
use asgn5;

create table stud_marks(
    roll number(5) primary key,
    name varchar2(30),
    total_marks number(5)
);

create table result(
    roll number(5),
    name varchar2(30),
    class varchar2(20)
);

-- procedure for grading
create or replace procedure proc_grade(
    p_roll in number,
    p_name in varchar2,
    p_marks in number
) is
    v_class varchar2(20);
begin
    if p_marks between 990 and 1500 then
        v_class := 'distinction';
    elsif p_marks between 900 and 989 then
        v_class := 'first class';
    elsif p_marks between 825 and 899 then
        v_class := 'higher second class';
    else
        v_class := 'fail';
    end if;

    insert into result values(p_roll, p_name, v_class);
end;
/

-- function for grading
create or replace function func_grade(
    p_marks in number
) return varchar2 is
    v_class varchar2(20);
begin
    if p_marks between 990 and 1500 then
        v_class := 'distinction';
    elsif p_marks between 900 and 989 then
        v_class := 'first class';
    elsif p_marks between 825 and 899 then
        v_class := 'higher second class';
    else
        v_class := 'fail';
    end if;
    return v_class;
end;
/

begin
    proc_grade(1, 'Ashish', 1200);
    proc_grade(2, 'Ashu', 950);
    proc_grade(3, 'Random1', 860);
    proc_grade(4, 'Random2', 700);
end;
/

select * from result;
