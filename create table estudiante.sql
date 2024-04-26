create table estudiante
(
	ci_id serial primary key,
	snombre varchar(30) not null, 
	sappaterno varchar(30), 
	sapmaterno varchar(30), 
	dtNacimiento date not null, 
	scarrera varchar(30) not null 
); 

create table materia 
(
	cod_id serial primary key , 
	snombre varchar(30) not null, 
	creditos int not null
); 

create table registro
(
	registro_id serial primary key, 
	estudiante_id int , 
	materia_id int 
); 
alter table registro
  add constraint fk_estudiante
  foreign key (estudiante_id)
  references estudiante (ci_id);
 alter table registro
  add constraint fk_materia
  foreign key (materia_id)
  references materia (cod_id);

create table evaluacion (	
	evaluacion_id int primary key, 
	snombre varchar(30) not null
); 

create table notas (	
	notas_id serial, 
	registro_id int, 
	evaluacion_id int,
	nota numeric ,
	primary key (notas_id, registro_id)
	
); 
 alter table notas
  add constraint fk_registro
  foreign key (registro_id)
  references registro (registro_id);
 alter table notas
  add constraint fk_evalucion
  foreign key (evaluacion_id)
  references evaluacion (evaluacion_id);
 

 
 
 
 
 ------CONSULTAS------

--insertar estudiante v
insert into estudiante(snombre, sappaterno, sapmaterno, dtnacimiento, scarrera) 
 			values('jose', 'valencia' , 'calcina', '2003/11/28', 'sistemas')

--insertar materias
insert into materia (snombre, creditos)
			values ('Programacion I', 4)
insert into materia (snombre, creditos)
			values ('Base de datos I', 4)
insert into materia (snombre, creditos)
			values ('Calculo ', 4)
insert into materia (snombre, creditos)
			values ('Sistemas Operativos', 4)
insert into materia (snombre, creditos)
			values ('', 4)
			
--insertar estudiant a una materia 
insert into registro(estudiante_id, materia_id)
			values (4, 1)
insert into registro(estudiante_id, materia_id)
			values (5, 1)

--sacar la lista de estudiantes de una materia
select estudiante_id , e.snombre , e.sappaterno , m.snombre 
from registro g
join materia m on g.materia_id = m.cod_id 
join estudiante e on g.estudiante_id = e.ci_id 
where m.cod_id =1

--materiaas en las que esta registrado un alumno
select r.estudiante_id , e.snombre , e.sappaterno , m.snombre 
from registro r 
join estudiante e 
on r.estudiante_id = e.ci_id 
left join materia m 
on r.materia_id = m.cod_id 
where  r.estudiante_id = 4

--añadimos una evaluacion
insert into evaluacion (evaluacion_id , snombre) 
			values (1, 'Examen parcial'); 
insert into evaluacion (evaluacion_id, snombre) 
			values (2, 'Examen final'); 
insert into evaluacion (evaluacion_id, snombre) 
			values (3, 'Tarea'); 
insert into evaluacion (evaluacion_id, snombre) 
			values (4, 'Practico'); 
insert into evaluacion (evaluacion_id, snombre) 
			values (5, 'Control de lectura'); 

--añadir una nota a un estudiante
insert into notas(registro_id, evaluacion_id, nota)values(1,1,30)
insert into notas(registro_id, evaluacion_id, nota)values(1,3,30)
insert into notas(registro_id, evaluacion_id, nota)values(1,2,30)



--ver promedio de una materia 
select e.ci_id , e.snombre , e.sappaterno, m.snombre, v.snombre  , n.nota 
from registro r 
join estudiante e 
on r.estudiante_id = e.ci_id 
join notas n 
on n.registro_id =r.registro_id
join materia m 
on r.materia_id = m.cod_id 
join evaluacion v
on n.evaluacion_id = v.evaluacion_id 
where e.ci_id = 4 and  m.snombre  = 'Programacion I'