create table borrow(rollin int, name varchar(20),dt_issue date, nameofbook varchar(50),status char(1));
insert into borrow values(1,'aa','20-Aug-2024','dbms','I');
insert into borrow values(2,'cc','20-Jul-2024','db','I');
insert into borrow values(3,'bb','30-Jul-2024','db1','I');
create table fine(roll int, rdate date, fineamt int);

Declare 
roll int;
famount int:=0;
idate date;
days int;
sta char(1);

begin
  roll:=:r;
  select dt_issue,status into idate,sta from borrow where rollin=roll;
  if sta='I' then
   days := SYSDATE()- idate;
   dbms_output.put_line('No of days' || days);
   
   if(days>= 15 and days <=30)then 
      famount:=(days-15)*5;
   elsif (days >30)then
      famount:=((days-30)*50);
   end if;
   dbms_output.put_line('Fine amount' || famount);
   insert into fine values(roll,SYSDATE(),famount);
   update borrow set STATUS='R' where rollin=roll;

 else
   dbms_output.put_line('Status is R');
 end if;

EXCEPTION WHEN NO_DATA_FOUND THEN
        dbms_output.put_line(' Roll no does not exist');
   
end;


