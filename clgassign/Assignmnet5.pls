create table employee (id int, name varchar(20), salary number, hire_date date);
Insert into employee1 values(1,'aaa',20000,'2-Jan-2000');
Insert into employee1 values(2,'bbb',30000,'2-Jan-2020');
Insert into employee1 values(3,'ccc',20000,'2-Jul-2015'); 
Declare
   cursor ecur is select * from employee1;
   erec ecur%rowtype;
Begin
   open ecur;
   loop
      fetch ecur into erec;
      exit when ecur%NOTFOUND;
      dbms_output.put_line(erec.id||' '|| erec.name||'  '|| erec.salary);
   end loop;
   close ecur;
end;

Declare
   cursor ecur is select * from employee1;
   erec ecur%rowtype;
   yr number;
   incentive number:=0;
Begin
   open ecur;
   loop
      fetch ecur into erec;
      exit when ecur%NOTFOUND;
      yr:=(sysdate()-erec.hire_date)/365;
       If yr>5 then
          incentive:=erec.salary*0.05;
      Else
           If yr>10 then
              incentive:=erec.salary*0.1;
           End if;
       End if;

      dbms_output.put_line(erec.id||' '|| erec.name||'  '|| erec.salary);
      dbms_output.put_line('incentive '|| incentive);
   end loop;
   close ecur;
end;


