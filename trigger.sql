create database if not exists testDB;
use testDB;
create table if not exists testTbl (id int, txt varchar(10));
insert into testTbl values(1, '레드벨벳');
insert into testTbl values(2, '잇지');
insert into testTbl values(3, '블랙핑크');

drop trigger if exists testTrg;
delimiter //
create trigger testTrg
	after delete
    on testTbl
    for each row
begin
	set @msg = '가수 그룹이 삭제됨' ;
end //
delimiter ;

set @msg = '';
insert into testTbl values(4, '마마무');
select @msg;
update testTbl set txt = '블핑' where id = 3;
select @msg;
delete from testTbl where id = 4;
select @msg;

select * from usertbl;

drop trigger if exists backUserTbl_UpdateTrg;
delimiter //
create trigger backUserTbl_UpdateTrg
	after update
    on userTBL
    for each row
begin 
	insert into backup_userTbl values(OLD.userID, OLD.name, OLD.birthYear, OLD.addr, OLD.mobile1, OLD.mobile2, OLD.height, OLD.mDate, '수정', curdate(), current_user());
end //
delimiter ;

drop trigger if exists backUserTbl_DeleteTrg;
delimiter //
create trigger backUserTbl_DeleteTrg
	after delete
    on userTBL
    for each row
begin
	insert into backup_userTbl values( OLD.userID, OLD.name, OLD.birthYear, OLD.addr, OLD.mobile1, OLD.mobile2, OLD.mDate, '삭제', curdate(), current_user());
end //
delimiter ;

update userTbl set addr = '몽고' where userID = 'JKW';
delete from userTbl where height >= 177;

select * from backup_userTbl;

truncate table userTbl;

drop trigger if exists userTbl_insertTrg;
delimiter //
create trigger userTbl_InsertTrg -- 트리거 이름
	after insert
    on userTBL
    for each row
begin
	signal sqlstate '45000'
		set message_text = '데이터의 입력을 시도했습니다. 귀하의 정보가 서버에 기록되었습니다.';
end //
delimiter ;


















