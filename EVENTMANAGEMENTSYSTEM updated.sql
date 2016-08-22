create   database event_management_system

//DDL COMMANDS

Create table STUDENT(email varchar(50) primary key , class varchar(50) , name varchar(50),mem_type varchar(50),contact_no varchar(20) check( LEN(contact_no)=10  ))


alter table STUDENT drop column mem_type

Create table COMMITTEE(com_name varchar(50) primary key ,staff_head varchar(50))
--Create table COMMITTEE(com_id  varchar(50) primary key ,staff_head varchar(50))

alter table COMMITTEE add  cid int

Create table SOCIETY( soc_name varchar(50) primary key foreign key references COMMITTEE 
, mem_amt int ,mem_dur INT )


Create table COUNCIL(council_name varchar(50) primary key  foreign key references COMMITTEE , 
 major_event varchar(50))
 

Create table COUNCIL_REPRESENTATIVE(email varchar(50) foreign key references STUDENT ,
council_name varchar(50) foreign key references COUNCIL , POST varchar(50) not null )

Create table SOC_REPRESENTATIVE(email varchar(50) foreign key references STUDENT ,
society_name varchar(50) foreign key references SOCIETY , POST varchar(50) not null )


Create table SOC_NORMAL_MEMBER(email varchar(50) foreign key references STUDENT ,
society_name varchar(50) foreign key references SOCIETY )



drop table EEVENT

--Create table EEVENT(  ID INT IDENTITY(1,1),
        event_id  AS 'event_' + CAST(ID AS VARCHAR(10)) PERSISTED primary key ,event_date date , 
        com_id varchar(50) references COMMITTEE )
 
Create table EEVENT(event_name varchar(50) primary key , event_date date , org_name varchar(50)
 references COMMITTEE )

drop tABLE EEVENT
 SELECT * FROM EEVENT

 insert into  EEVENT values(,'2016-09-16','ISTEVESIT')


 Create table COMPETITION( comp_name varchar(50) primary key foreign key references EEVENT
 , winner varchar(50) default null)
 

 Create table WORKSHOP(wkp_name varchar(50) primary key foreign key references EEVENT
 , activity varchar(50),speaker varchar(50))

 
create table PARTICIPATES (emailid  varchar(50) foreign key references STUDENT
,eventname  varchar(50) foreign key references EEVENT,primary key(emailid,eventname) )



 
 //INSERTING VALUES


 select * from STUDENT

 Insert into STUDENT values('rajeevkumar.yadav@ves.ac.in','D15','Rajeevkumar Yadav',9657583510)
 Insert into STUDENT values('ravi.yadav@ves.ac.in','D15','Ravi Yadav',9657425580)
 Insert into STUDENT values('amey.parab@ves.ac.in','D15','Amey Parab',9568745254)
 Insert into STUDENT values('anjali.jaisinghani@ves.ac.in','D15','Anjali Jaisinghani',9865684654)
 Insert into STUDENT values('rahul.shetty@ves.ac.in','D15','Rahul Shetty',7658485546)
 Insert into STUDENT values('neeraj.harjani@ves.ac.in','D15','Neeraj Harjani',7658485454)
 Insert into STUDENT values('deepa.tursani@ves.ac.in','D15','Deepa Tursani',9858485546)
 
 
 select * from COMMITTEE

 Insert into  COMMITTEE values('CSIVESIT','Manoj Sabnis')
 Insert into  COMMITTEE values('IEEEVESIT','Anushree Prabhu')
 Insert into  COMMITTEE values('ISTEVESIT','Ravishankar Singh')
 Insert into  COMMITTEE values('CULTURALVESIT','PRINCIPAL')
 Insert into  COMMITTEE values('SORTVESIT','PRINCIPAL')
 Insert into  COMMITTEE values('SPORTSVESIT','PRINCIPAL')

update COMMITTEE SET cid=6 where com_name='SPORTSVESIT'
 

 Select * from SOCIETY

 Insert into  SOCIETY values('CSIVESIT',900,3)
 Insert into  SOCIETY values('ISTEVESIT',500,3)
 Insert into  SOCIETY values('IEEEVESIT',1900,3)

 Select * from COUNCIL

 Insert into COUNCIL  values('CULTURALVESIT','ILLUSION')
 Insert into COUNCIL  values('SORTVESIT','SORTWEEK')
 Insert into COUNCIL  values('SPORTSVESIT','SPHURTI')


 Select * from SOC_REPRESENTATIVE

Insert into SOC_REPRESENTATIVE values('anjali.jaisinghani@ves.ac.in','ISTEVESIT','senior PRO')
Insert into SOC_REPRESENTATIVE values('amey.parab@ves.ac.in','CSIVESIT','senior PRO')


Select * from SOC_NORMAL_MEMBER

insert into  SOC_NORMAL_MEMBER values('rajeevkumar.yadav@ves.ac.in','ISTEVESIT')
insert into  SOC_NORMAL_MEMBER values('rahul.shetty@ves.ac.in','ISTEVESIT')


Select * from COUNCIL_REPRESENTATIVE

insert into  COUNCIL_REPRESENTATIVE values('neeraj.harjani@ves.ac.in','CULTURALVESIT','incharge')
insert into  COUNCIL_REPRESENTATIVE values('deepa.tursani@ves.ac.in','SORTVESIT','incharge')


Select * from EEVENT
Select * from COMPETITION


Insert into EEVENT values('GD','2016-09-15','ISTEVESIT')
Insert into EEVENT values('BLOOD DONATION CAMP','2016-09-15','SORTVESIT')


--CONSTRAINTS


Create view EVENTCOMP (compname,eventdate)  AS select event_name,event_date from EEVENT

SELECT * FROM EEVENT

1)

Create trigger dataentry on EVENTCOMP instead of insert
as
begin 
DECLARE  @COMPNAME varchar(50),@EVENTDATE date,@comname varchar(50)

select @COMPNAME=compname,@EVENTDATE=eventdate from inserted

-- changes to be made after creating website
select @comname=com_name from COMMITTEE where cid=(ROUND((6 - 5* RAND()), 0))

insert into EEVENT VALUES(@COMPNAME,@EVENTDATE,@comname)
insert into COMPETITION(comp_name) VALUES(@COMPNAME)

end




insert into EVENTCOMP VALUES('PUZZLESOLVING','2016-09-16')

2)

Select * from EEVENT
Select * from WORKSHOP

Create view EVENTWKP (wkpname,eventdate,activity,speaker)  AS select event_name,
event_date,activity,speaker from EEVENT as e JOIN WORKSHOP as w ON e.event_name=w.wkp_name



Create trigger dataentry2 on EVENTWKP instead of insert
as
begin 
DECLARE  @WKPNAME varchar(50),@EVENTDATE date,@comname varchar(50),@ACTIVITY varchar(50),@speaker varchar(50)

select @WKPNAME=wkpname,@EVENTDATE=eventdate,@ACTIVITY=activity,@speaker=speaker from inserted

-- changes to be made after creating website
select @comname=com_name from COMMITTEE where cid=(ROUND((6 - 5* RAND()), 0))

insert into EEVENT VALUES(@WKPNAME,@EVENTDATE,@comname)
insert into WORKSHOP VALUES(@WKPNAME,@ACTIVITY,@speaker)

end
