-- TABLE ARTIST_TYPE
DROP TABLE IF EXISTS tip_artist;

CREATE table tip_artist (
id_tip_artist serial, 
tip varchar(255) NOT NULL, 
PRIMARY KEY (id_tip_artist));


-- TABLE KORISNIK
DROP TABLE IF EXISTS korisnik;

CREATE TABLE korisnik (
id_korisnik serial primary KEY, 
username varchar ( 255 ) NOT NULL UNIQUE, 
name varchar ( 255 ) NOT NULL, 
last_name varchar ( 255 ) NOT NULL, 
password varchar ( 255 ) NOT NULL);

-- TABLE ARTIST
drop table if exists artist;

CREATE TABLE artist (
id_korisnik int not null,
id_tip_artist int not null, 
PRIMARY KEY (id_korisnik),
foreign key (id_korisnik) references korisnik (id_korisnik),
foreign key (id_tip_artist) references tip_artist (id_tip_artist));


-- TABLE MENADZER
drop table if exists menadzer;

CREATE TABLE menadzer (
id_korisnik int not null, 
PRIMARY KEY (id_korisnik),
foreign key (id_korisnik) references korisnik (id_korisnik));

-- TABLE ZANR
drop table if exists zanr;

CREATE TABLE zanr (
id_zanr serial, 
ime varchar(255) NOT NULL, 
PRIMARY KEY (id_zanr));

-- TABLE ARTIST_ZANR
drop table if exists artist_zanr;

CREATE TABLE artist_zanr (
id_zanr serial, 
id_korisnik int NOT NULL, 
PRIMARY KEY (id_zanr, id_korisnik),
foreign key (id_zanr) references zanr (id_zanr),
foreign key (id_korisnik) references artist (id_korisnik));


-- TABLE INSTRUMENT
drop table if exists instrument;

CREATE TABLE instrument (
id_instrument serial, 
tip_instrument varchar(255) NOT NULL, 
ime varchar(255) NOT NULL,  
PRIMARY KEY (id_instrument));

-- TABLE ARTIST_INSTRUMENT
drop table if exists artist_instrument;

CREATE TABLE Artist_Instrument (
iskustvo_instrument int not NULL,
id_instrument int NOT NULL,
id_korisnik int NOT NULL,
PRIMARY KEY (id_instrument, id_korisnik),
foreign key (id_instrument) references instrument (id_instrument),
foreign key (id_korisnik) references artist (id_korisnik));


-- TABLE BEND
drop table if exists bend;

CREATE TABLE bend (
id_bend serial,
ime varchar(255) NOT NULL,
godina_osnovanje date,
PRIMARY KEY (id_bend));

-- TABLE ALBUM
drop table if exists album;

CREATE TABLE album (
id_album serial, 
ime varchar(255) NOT NULL, 
id_bend int, 
PRIMARY KEY (id_album),
foreign key (id_bend) references bend (id_bend));

-- TABLE PESNA
drop table if exists pesna;

CREATE TABLE pesna (
id_pesna serial,
ime varchar(255) NOT NULL, 
datum date, 
id_zanr int, 
id_album int, 
PRIMARY KEY (id_pesna),
foreign key (id_zanr) references zanr (id_zanr),
foreign key (id_album) references album (id_album));

-- TABLE MEMBER_BEND
drop table if exists member_bend;

CREATE TABLE member_bend (
id_korisnik int,
id_bend int,
id_instrument int,
primary key (id_korisnik,id_bend,id_instrument),
foreign key (id_korisnik) references artist (id_korisnik),
foreign key (id_bend) references bend (id_bend),
foreign key (id_instrument) references instrument (id_instrument));

-- TABLE LOKACIJA
drop table if exists lokacija;

CREATE TABLE lokacija (
id_lokacija serial, 
ime varchar(255) NOT NULL, 
latitude int NOT NULL, 
longitude int NOT NULL, 
kapacitet int NOT NULL,
id_korisnik int, 
PRIMARY KEY (id_lokacija),
foreign key (id_korisnik) references menadzer (id_korisnik));

-- TABLE NASTAN
drop table if exists nastan;

CREATE TABLE nastan (
id_nastan serial, 
id_lokacija int NOT NULL, 
cena int NOT NULL, 
ime varchar(255) NOT NULL, 
PRIMARY KEY (id_nastan),
foreign key (id_lokacija) references lokacija (id_lokacija));

-- TABLE ODRZUVANJE_NASTAN
drop table if exists odrzuvanje_nastan;

CREATE TABLE odrzuvanje_nastan (
id_bend serial, 
id_nastan int NOT NULL, 
datum date NOT NULL, 
PRIMARY KEY (id_bend, id_nastan),
foreign key (id_bend) references bend (id_bend),
foreign key (id_nastan) references nastan (id_nastan));


-- TABLE TIP_OBJAVA
drop table if exists tip_objava;

CREATE TABLE tip_objava (
id_tip_objava serial, 
tip_objava varchar(255) NOT NULL, 
PRIMARY KEY (id_tip_objava));

-- TABLE OBJAVA_KORISNIK
drop table if exists objava_korisnik;

CREATE TABLE objava_korisnik (
id_objava_korisnik serial,
id_korisnik int NOT NULL, 
naslov varchar(255) NOT NULL, 
opis varchar(255) NOT NULL, 
id_tip_objava int NOT NULL, 
PRIMARY KEY (id_objava_korisnik),
foreign key (id_tip_objava) references tip_objava (id_tip_objava),
foreign key (id_korisnik) references korisnik (id_korisnik));

-- TABLE KOMENTAR
drop table if exists komentar;

CREATE TABLE komentar (
id_komentar serial,
id_korisnik int NOT NULL, 
id_objava_korisnik int NOT NULL,

PRIMARY KEY (id_komentar),
foreign key (id_korisnik) references korisnik (id_korisnik),
foreign key (id_objava_korisnik) references objava_korisnik (id_objava_korisnik));

-- TABLE REPLY
drop table if exists reply;

CREATE TABLE reply (
id_komentar int NOT NULL, 
id_reply int NOT NULL, 
PRIMARY KEY (id_komentar, id_reply),
foreign key (id_komentar) references komentar (id_komentar),
foreign key (id_reply) references komentar (id_komentar));

-- TABLE REAKCIJA
drop table if exists reakcija;

CREATE TABLE reakcija (
id_reakcija serial,
reakcija varchar(255), 
PRIMARY KEY (id_reakcija));

-- TABLE REAKCIJA_OBJAVA
drop table if exists reakcija_objava;

CREATE TABLE reakcija_objava (
id_objava_korisnik int NOT NULL, 
id_reakcija int NOT NULL,
id_korisnik int NOT NULL, 
PRIMARY KEY (id_objava_korisnik, id_reakcija),
foreign key (id_objava_korisnik) references objava_korisnik (id_objava_korisnik),
foreign key (id_korisnik) references korisnik (id_korisnik),
foreign key (id_reakcija) references reakcija (id_reakcija));

-- TABLE AUDICIJA
drop table if exists audicija;

CREATE TABLE audicija (
id_audicija serial, 
id_bend int NOT NULL, 
id_instrument int NOT NULL, 
poceten_datum date NOT NULL, 
kraen_datum date NOT NULL, 
id_tip_artist int NOT NULL, 
PRIMARY KEY (id_audicija),
foreign key (id_bend) references bend (id_bend),
foreign key (id_instrument) references instrument (id_instrument),
foreign key (id_tip_artist) references tip_artist (id_tip_artist));


-- TABLE SNIMKA
drop table if exists snimka;

CREATE TABLE snimka (
id_snimka serial, 
id_audicija int NOT NULL, 
datum date NOT NULL, 
link varchar(255) NOT NULL, 
PRIMARY KEY (id_snimka),
foreign key (id_audicija) references audicija (id_audicija),
foreign key (id_korisnik) references korisnik (id_korisnik));


-- TABLE KORISNIK_SNIMKA
drop table if exists korisnik_snimka;

CREATE TABLE korisnik_snimka (
id_korisnik int NOT NULL, 
id_snimka int NOT NULL, 
PRIMARY KEY (id_korisnik, id_snimka),
foreign key (id_korisnik) references artist (id_korisnik),
foreign key (id_snimka) references snimka (id_snimka));

drop table korisnik_snimka;


CREATE VIEW pesni_vo_album AS
select distinct p.ime as ime_pesna, a.ime as ime_album ,a.id_bend ,p.id_zanr 
FROM album a, pesna p
WHERE a.id_album=p.id_album

drop table pesni_vo_album 

create view album_zanr as 
select distinct p.ime_album ,z.ime 
from pesni_vo_album p, zanr z
where p.id_zanr =z.id_zanr 

create view korisnici_per_snimka
select
from korisnik_snimka ks ,audicija a ,snimka s, 
where s.id_audicija =a.id_audicija and ks.id_snimka =s.id_snimka and ks.id_korisnik 

drop view album_zanr 

select n.id_nastan , n.ime as nastan,count(b.id_bend) as bendovi,l.ime as lokacija,l.kapacitet
from nastan n
join lokacija l on n.id_lokacija = l.id_lokacija 
join odrzuvanje_nastan onas on onas.id_nastan = n.id_nastan 
join bend b on b.id_bend = onas.id_bend
group by (n.id_nastan,onas.id_nastan,l.ime,l.kapacitet,n.ime)


create view podatoci_za_instrumenti_artisti as
select k.name as ime_korisnik, k.last_name as prezime_korisnik  ,i.ime as instrument 
from korisnik k , artist a, artist_instrument ai, instrument i 
where k.id_korisnik =a.id_korisnik and ai.id_korisnik =a.id_korisnik  and ai.id_instrument = i.id_instrument

create view podatoci_za_zanr_artisti as
select k.name as ime_korisnik, k.last_name as prezime_korisnik  , z.ime as zanr
from korisnik k , artist a , artist_zanr az ,zanr z 
where k.id_korisnik =a.id_korisnik and a.id_korisnik = az.id_korisnik and z.id_zanr =az.id_zanr 

create view objava_details as
select ok.id_objava_korisnik ,ok.naslov ,ok.opis ,k.username as written_by,to2.tip_objava ,r.reakcija ,k2.komentar 
from objava_korisnik ok ,korisnik k ,tip_objava to2 ,reakcija_objava ro ,reakcija r,komentar k2 
where ok.id_objava_korisnik=k.id_korisnik and ok.id_tip_objava=to2.id_tip_objava  and ok.id_objava_korisnik =ro.id_objava_korisnik and r.id_reakcija =ro.id_reakcija and k2.id_objava_korisnik =ok.id_objava_korisnik  
--Objava detali
create view objava_details_join as
select ok.id_objava_korisnik ,ok.naslov ,ok.opis ,k.username as written_by, to2.tip_objava ,r.reakcija ,k2.komentar 
from objava_korisnik ok 
join korisnik k ON ok.id_objava_korisnik =k.id_korisnik 
join tip_objava to2 on ok.id_tip_objava =to2 .id_tip_objava 
join reakcija_objava ro on ok.id_objava_korisnik =ro.id_objava_korisnik 
join reakcija r on ro.id_reakcija =r.id_reakcija 
join komentar k2 on ok.id_objava_korisnik =k2.id_objava_korisnik 
--bezKomentar
create view objava_details_join_bezKomentar as
select ok.id_objava_korisnik ,ok.naslov ,ok.opis ,k.username as written_by, to2.tip_objava ,r.reakcija  
from objava_korisnik ok 
join korisnik k ON ok.id_objava_korisnik =k.id_korisnik 
join tip_objava to2 on ok.id_tip_objava =to2 .id_tip_objava 
join reakcija_objava ro on ok.id_objava_korisnik =ro.id_objava_korisnik 
join reakcija r on ro.id_reakcija =r.id_reakcija 
--
create view reakicii_po_objava as
select ok2.id_objava_korisnik ,ok2.naslov ,ok2.opis ,k3.username as written_by ,r.reakcija 
from objava_korisnik ok2 
join korisnik k3 on ok2.id_korisnik =k3.id_korisnik 
join reakcija_objava ro on ok2.id_objava_korisnik =ro.id_objava_korisnik 
join reakcija r on ro.id_reakcija =r.id_reakcija
where k3.id_korisnik =ro.id_korisnik 
group by ok2.id_objava_korisnik ,k3.username ,r.reakcija 
--komentari
create view komentari as
select ok.id_objava_korisnik,kom.komentar,k.username as kom_written_by
from komentar kom
join korisnik k on k.id_korisnik =kom.id_korisnik 
join objava_korisnik ok on kom.id_objava_korisnik =ok.id_objava_korisnik  
--left join
create view objava_details as
select ok.id_objava_korisnik ,ok.naslov ,ok.opis ,k.username as written_by, to2.tip_objava ,r.reakcija  ,k4.komentar 
from objava_korisnik ok 
join korisnik k ON ok.id_objava_korisnik =k.id_korisnik 
join tip_objava to2 on ok.id_tip_objava =to2 .id_tip_objava 
join reakcija_objava ro on ok.id_objava_korisnik =ro.id_objava_korisnik 
join reakcija r on ro.id_reakcija =r.id_reakcija 
left join komentar k4 on ok.id_objava_korisnik =k4.id_objava_korisnik 
--index
create index test
on objava_korisnik (id_tip_objava)

create index test2
on korisnik(username)



select * from album a where a.id_bend=

create view nastan_detali as
select n.id_nastan , n.ime as nastan,count(b.id_bend) as bendovi,l.ime as lokacija,l.kapacitet
from nastan n
join lokacija l on n.id_lokacija = l.id_lokacija
join odrzuvanje_nastan onas on onas.id_nastan = n.id_nastan
join bend b on b.id_bend = onas.id_bend
group by (n.id_nastan,onas.id_nastan,l.ime,l.kapacitet,n.ime)

CREATE VIEW pesna_detali AS
SELECT p.ime as pesna_ime, b.ime as bend_ime , a.ime as artist_ime, p.datum
FROM pesna p, bend b, album a
WHERE b.id_bend = a.id_bend AND a.id_album=p.id_album

create view br_nastani_po_bend as
select b.ime,count(n.id_nastan)
from bend b
join odrzuvanje_nastan onas on onas.id_bend = b.id_bend
join nastan n on n.id_nastan = onas.id_nastan
group by b.id_bend

create view member_bend_details as
select k.id_korisnik,k.username, k.name,k.last_name ,b.ime as bend ,i.ime as instrument from artist a
join korisnik k on a.id_korisnik = k.id_korisnik
join member_bend mb on mb.id_korisnik = a.id_korisnik
join bend b on mb.id_bend = b.id_bend
join instrument i on i.id_instrument = mb.id_instrument

-- audicija detali
create view audicija_details as
select a.id_audicija, b.ime as ime_bend,ta.tip as tip_artist,i.ime as instrument,a.poceten_datum ,a.kraen_datum
from audicija a
join bend b on a.id_bend = b.id_bend
join instrument i on i.id_instrument = a.id_instrument
join tip_artist ta on a.id_tip_artist = ta.id_tip_artist

--br nastani bend indexi
explain analyze select * from bend b where b.ime='Leg Peace';
---Detali za nastanot
explain analyze select * from nastan n where n.ime='Crack';
explain analyze select * from nastan n where n.id_nastan =8210;
explain analyze select * from lokacija l where l.ime  ='Surat';
explain analyze select * from lokacija l where l.kapacitet  =11553;
--Vo kolku bendovi e muzicar
explain analyze select * from korisnik k where k.username='AarenKevon71778';
-- Pesna detali
explain analyze select * from pesna p where p.ime='Needle Hunt';
explain analyze select * from bend b where b.ime='Active Salt';
explain analyze select * from pesna p where p.datum='1980-02-08';
-- Detail member bend
explain analyze select * from korisnik k where k.id_korisnik =80632;
explain analyze select * from korisnik k where k.username ='UrsulinaDorothy80632';
explain analyze select * from korisnik k where k.name='Joy' and k.last_name ='Sancho';
explain analyze select * from bend b where b.ime='Oxygen Former';
explain analyze select * from instrument i where i.ime='Harp';
-- Korisnik instrument
explain analyze select * from korisnik k where k.name='Kara-Lynn' and k.last_name='Elo' ;
explain analyze select * from instrument i  where i.ime ='Electric Guitar';
--korisnik zanr
explain analyze select * from zanr z  where z.ime ='ragga';
--objava detali
explain analyze select * from objava_korisnik ok where ok.naslov='dig dog';
explain analyze select * from tip_objava to2  where to2.tip_objava='d';
explain analyze select * from reakcija r  where r.reakcija ='upvote';
--audicija details
explain analyze select * from audicija a  where a.id_audicija =29725;
explain analyze select * from audicija a  where a.poceten_datum ='1995-06-25';
explain analyze select * from audicija a  where a.kraen_datum ='2008-12-26';
-- komentari

create index index_bend_ime
on bend (ime)

create index index_nastan_ime
on nastan (ime)

create index index_lokacija_ime
on lokacija (ime)

create index index_lokacija_kapacitet
on lokacija (kapacitet)

create index index_korisnik_username
on korisnik (username)

create index index_korisnik_id
on korisnik (id_korisnik)

create index index_pesna_ime
on pesna (ime)

create index index_pesna_datum
on pesna (datum)

create index index_zanr_ime
on zanr (ime)

create index index_objava_naslov
on objava_korisnik (naslov)

create index index_audicija_id
on audicija (id_audicija)

create index index_audicija_poceten
on audicija (poceten_datum)

create index index_audicija_kraen
on audicija (kraen_datum)
explain analyze select * from audicija a where a.kraen_datum ='2008-12-26';
--reply 1
CREATE OR REPLACE FUNCTION public.insertreply(_id_komentar integer, _id_reply integer)
 RETURNS TABLE(id_komentar integer, id_reply integer)
 LANGUAGE plpgsql
AS $function$
BEGIN
    INSERT INTO public.reply(id_komentar, id_reply)
    VALUES(_id_komentar, _id_reply);

   return query (select * from reply) ;
END;
$function$
;
--bend 2
CREATE OR REPLACE FUNCTION public.insertbend(_id_bend int,_ime varchar , _godina_osnovanje date)
 RETURNS TABLE(id_bend int,ime varchar, godina_osnovanje date)
 LANGUAGE plpgsql
AS $function$
	begin
		
	INSERT INTO public.bend(id_bend,ime, godina_osnovanje) VALUES(_id_bend,_ime, _godina_osnovanje);

   return query (select * from bend) ;
	END;
$function$
;

select insertbend(5000000,varchar 'proceduraBend',date '2008-12-26')
--korisnik 3
CREATE OR REPLACE FUNCTION public.insertkorisnik(_id_korisnik int,_username varchar , _name varchar,_last_name varchar,_password varchar)
 RETURNS TABLE(id_korisnik int,username varchar , "name" varchar,last_name varchar,"password" varchar)
 LANGUAGE plpgsql
AS $function$
	begin
		
	INSERT INTO public.korisnik (id_korisnik , username, "name", last_name, "password") VALUES(_id_korisnik , _username, _name, _last_name, _password);


   return query (select * from korisnik) ;
	END;
$function$
;

select insertkorisnik(100100,varchar 'proceduraUsername100100',varchar 'proceduraName',varchar 'proceduraLastname', varchar 'proceduraPassword')

--objava 4
CREATE OR REPLACE FUNCTION public.insertobjava(_id_objava_korisnik int ,_id_korisnik int,_naslov varchar,_opis varchar,_id_tip_objava int)
 RETURNS TABLE(id_objava_korisnik int ,id_korisnik int,naslov varchar,opis varchar,id_tip_objava int)
 LANGUAGE plpgsql
AS $function$
	begin
		
	INSERT INTO public.objava_korisnik  (id_objava_korisnik,id_korisnik,naslov,opis,id_tip_objava) VALUES(_id_objava_korisnik,_id_korisnik,_naslov,_opis,_id_tip_objava);


   return query (select * from objava_korisnik) ;
	END;
$function$
;

select insertobjava(4935890,29391,varchar 'proceduraNaslov',varchar 'proceduraOpis',2)
--instrument 5
CREATE OR REPLACE FUNCTION public.insertinstrument(_id_instrument int,_tip_instrument varchar,_ime varchar)
 RETURNS TABLE(id_instrument int,tip_instrument varchar,ime varchar)
 LANGUAGE plpgsql
AS $function$
	begin
		
	INSERT INTO public.instrument
(id_instrument,tip_instrument, ime) VALUES(_id_instrument,_tip_instrument,_ime);


   return query (select * from instrument ) ;
	END;
$function$
;
select insertinstrument(20,varchar 'proceduraString',varchar 'proceduraIme')
--pesna 6
CREATE OR REPLACE FUNCTION public.insertpesna(_id_pesna int ,_ime varchar,_datum date,_id_zanr int,_id_album int)
 RETURNS TABLE(id_pesna int ,ime varchar,datum date,id_zanr int,id_album int)
 LANGUAGE plpgsql
AS $function$
	begin
		
INSERT INTO public.pesna
(id_pesna,ime, datum, id_zanr, id_album)
VALUES(_id_pesna,_ime, _datum, _id_zanr, _id_album);


   return query (select * from pesna) ;
	END;
$function$
;

select insertpesna(183503,varchar 'proceduraIme',date '2008-12-26',1,1)

--audicija 7
CREATE OR REPLACE FUNCTION public.insertaudicija(_id_audicija int ,_id_bend int,_id_instrument int,_poceten_datum date,_kraen_datum date,_id_tip_artist int)
 RETURNS TABLE(id_audicija int ,id_bend int,id_instrument int,poceten_datum date,kraen_datum date,id_tip_artist int)
 LANGUAGE plpgsql
AS $function$
	begin
		
INSERT INTO public.audicija
(id_audicija,id_bend, id_instrument, poceten_datum, kraen_datum, id_tip_artist)
VALUES(_id_audicija,_id_bend,_id_instrument,_poceten_datum,_kraen_datum,_id_tip_artist);

   return query (select * from audicija) ;
	END;
$function$
;

select insertaudicija(30000,116600,1,date '2008-12-26',date '2008-12-30',2)
--nastan 8
CREATE OR REPLACE FUNCTION public.insertnastan(_id_nastan int,_id_lokacija int , _cena int,_ime varchar)
 RETURNS TABLE(id_nastan int,id_lokacija int , cena int,ime varchar)
 LANGUAGE plpgsql
AS $function$
    begin

    INSERT INTO public.nastan  (id_nastan , id_lokacija, cena , ime) VALUES(_id_nastan, _id_lokacija, _cena, _ime);


   return query (select * from nastan) ;
    END;
$function$
--lokacija 9 
CREATE OR REPLACE FUNCTION public.insertlokacija(_id_lokacija int,_ime varchar, _latitude int, _longitude int, _kapacitet int, _id_korisnik int)
 RETURNS TABLE(id_lokacija int,ime varchar , latitude int, longitude int, kapacitet int, id_korisnik int)
 LANGUAGE plpgsql
AS $function$
    begin

    INSERT INTO public.lokacija  (id_lokacija , ime , latitude, longitude, id_korisnik) VALUES(_id_lokacija,_ime, _latitude, _longitude, _kapacitet, _id_korisnik);


   return query (select * from lokacija) ;
    END;
$function$
;

--komentar 10
CREATE OR REPLACE FUNCTION public.insertkomentar(_id_komentar int,_id_korisnik int, _id_objava_korisnik int, _komentar varchar)
 RETURNS TABLE(id_komentar int,id_korisnik int, id_objava_korisnik int, komentar varchar)
 LANGUAGE plpgsql
AS $function$
    begin
INSERT INTO public.komentar(id_komentar,id_korisnik, id_objava_korisnik, komentar)
values(_id_komentar,_id_korisnik, _id_objava_korisnik, _komentar);


   return query (select * from komentar) ;
    END;
$function$
;


select insertkomentar(100001,100,1,varchar 'cena?')