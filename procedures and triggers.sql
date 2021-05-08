create database person;
use person;
create table user(
     `user_id` VARCHAR(25) NOT NULL,
     `email` VARCHAR(255) NOT NULL,
     `username` VARCHAR(25) NOT NULL,
     `password` VARCHAR(255) NOT NULL,
      PRIMARY KEY (`user_id`));
create table summary(
   id varchar(25) not null,
    total_user varchar(25) not null,
    yahoo varchar(25) not null,
    hotmail varchar(25) not null,
     gmail varchar(25) not null,
     primary key(id));
delimiter //
CREATE PROCEDURE s (IN var1 varchar(25),IN var2 varchar(25),IN var3 varchar(25),IN var4 varchar(25),IN var5 varchar(25))
    begin
    insert into summary values(var1,var2,var3,var4,var5);
     end//

call s(1,2,1,0,1);
CREATE PROCEDURE s2 (IN var1 varchar(25),IN var2 varchar(25),IN var3 varchar(25),IN var4 varchar(25))
    begin
    insert into user values(var1,var2,var3,var4);
    end//
    delimiter ;
call s2(1,"abc123","def321","abc123@yahoo.com");
 
create procedure yahooavg(out var1 varchar(25))
    begin
    select avg(yahoo) into var1 from summary;
     end//
delimiter ;
call yahooavg(@out);
select @out;
delimiter //
create procedure mingmail(out var1 varchar(25))
   begin
     select min(gmail) into var1 from summary;
   end//
delimiter ;
 call mingmail(@out);

delimiter //
create procedure maxhotmail(out var1 varchar(25))
     begin
    select max(hotmail) into var1 from summary;
    end//
delimiter ;
 call maxhotmail(@out);
delimiter //
create procedure tu()
begin
update summary set total_user=total_user+1
where yahoo<=hotmail ;
end //
delimiter ;
call tu();
delimiter //
create trigger ins after insert
on person.user for each row
begin
 update summary
  set total_user=total_user+1;
   end //
insert into user values('3','qwe','rew','qwe@gmail.com')//
 create trigger del after delete
 on person.user for each row
  begin
  update summary
  set total_user=total_user-1;
   end //
delete from  user where user_id="3"//
