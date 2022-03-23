create database sqldb;
use sqldb;
drop procedure if exists userProc1;
delimiter $$
create procedure userProc1(IN userName VARCHAR(10))
begin
	select * from userTBL where name = userName;
end $$
delimiter ;

call userProc1('조관우');

drop procedure if exists userProc2;
delimiter $$
create procedure userProc2(
	IN userBirth int,
    in userHeight int
)
begin 
	select * from userTbl
		where birthYear > userBirth AND height > userHeight;
END $$
delimiter ;

call userProc2(1970, 178);

drop procedure if exists userProc3;
delimiter $$
create procedure userProc3(
	in txtValue CHAR(10),
    out outValue int
)
begin 
	insert into testTBL value(null, txtValue);
    select max(id) into outValue from testTBL;
END $$
delimiter ;

create table if not exists testTBL(
	id int auto_increment primary key,
    txt char(10)
);

call userProc3 ('테스트값', @myValue);
select concat('현재 입력된 ID 값 ==>', @myValue);
select * from testTBL;

drop table if exists guguTBL;
create table guguTBL (txt VARCHAR(100));

drop procedure if exists whileProc;
delimiter $$
create procedure whileProc()
begin
	declare str varchar(100);
    declare i int;
    declare k int;
    set i = 2;
    
    while (i<10) do
		set str='';
        set k = 1;
        while (k <10) do
			set str = concat(str, ' ', i, 'x', k, '=', i*k);
            set k = k+1;
		end while;
        set i = i + 1;
        insert into guguTBL values(str);
	end while;
end $$
delimiter ;

call whileProc();
select * from guguTBL;

select routine_name, routine_definition from INFORMATION_SCHEMA.ROUTINES
where routine_schema = 'sqldb' AND routine_type = 'PROCEDURE';

select parameter_mode, parameter_name, dtd_identifier 
from INFORMATION_SCHEMA.PARAMETERS
where specific_name = 'userProc3';

show create procedure sqldb.userProc3;
            
    
    
    
    


















		 