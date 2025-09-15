create database asgn4Library;
use asgn4Library;

create table borrower (
    roll_no int,
    name varchar(50),
    dateofissue date,
    nameofbook varchar(50),
    status char(1)
);

create table fine (
    roll_no int,
    finedate date,
    amt int
);

insert into borrower values
(101, 'Ashish', '2025-08-01', 'DBMS', 'i'),
(102, 'Ashu', '2025-08-20', 'CNS', 'i');

delimiter $$

create procedure return_book(in p_rollno int, in p_book varchar(50))
begin
    declare v_days int;
    declare v_fine int default 0;
    declare v_dateissue date;

    declare exit handler for sqlexception
    begin
        select 'error occurred while processing!' as message;
    end;

    -- get issue date
    select dateofissue into v_dateissue
    from borrower
    where roll_no = p_rollno and nameofbook = p_book and status = 'i';

    -- calculate days
    set v_days = datediff(curdate(), v_dateissue);

    -- fine calculation
    if v_days between 15 and 30 then
        set v_fine = v_days * 5;
    elseif v_days > 30 then
        set v_fine = (30 * 5) + ((v_days - 30) * 50);
    end if;

    -- update borrower status
    update borrower
    set status = 'r'
    where roll_no = p_rollno and nameofbook = p_book;

    -- insert into fine table if fine > 0
    if v_fine > 0 then
        insert into fine values (p_rollno, curdate(), v_fine);
    end if;

    select concat('book returned. days: ', v_days, ' fine: ', v_fine) as message;
end$$

delimiter ;

call return_book(101, 'dbms');
select * from borrower;
select * from fine;
