create database asgn4Area;
use asgn4Area;

create table areas (
    radius int,
    area decimal(10,2)
);

delimiter $$

create procedure circle_area()
begin
    declare r int default 5;

    declare exit handler for sqlexception
    begin
        select 'error while inserting data!' as message;
    end;

    while r <= 9 do
        insert into areas values (r, 3.14 * r * r);
        set r = r + 1;
    end while;
end$$

delimiter ;

call circle_area();
select * from areas;
