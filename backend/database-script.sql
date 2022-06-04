-- This script was generated by a beta version of the ERD tool in pgAdmin 4.
-- Please log an issue at https://redmine.postgresql.org/projects/pgadmin4/issues/new if you find any bugs, including reproduction steps.

BEGIN;


CREATE TABLE IF NOT EXISTS public.administrador
(
    login_persona character varying COLLATE pg_catalog."default" NOT NULL,
    CONSTRAINT administrador_pkey PRIMARY KEY (login_persona)
);

CREATE TABLE IF NOT EXISTS public.categoria_examen
(
    codigo_categoria integer NOT NULL GENERATED ALWAYS AS IDENTITY ( INCREMENT 1 START 1 MINVALUE 1 MAXVALUE 2147483647 CACHE 1 ),
    descripcion character varying COLLATE pg_catalog."default" NOT NULL,
    CONSTRAINT categoria_examen_pkey PRIMARY KEY (codigo_categoria)
);

CREATE TABLE IF NOT EXISTS public.curso
(
    codigo_curso integer NOT NULL GENERATED ALWAYS AS IDENTITY ( INCREMENT 1 START 1 MINVALUE 1 MAXVALUE 2147483647 CACHE 1 ),
    descripcion character varying COLLATE pg_catalog."default" NOT NULL,
    codigo_espacio integer NOT NULL,
    codigo_docente character varying COLLATE pg_catalog."default" NOT NULL,
    CONSTRAINT curso_pkey PRIMARY KEY (codigo_curso)
);

CREATE TABLE IF NOT EXISTS public.curso_estudiante
(
    codigo_estudiante character varying COLLATE pg_catalog."default" NOT NULL,
    codigo_curso integer NOT NULL,
    codigo_matricula integer NOT NULL GENERATED ALWAYS AS IDENTITY ( INCREMENT 1 START 1 MINVALUE 1 MAXVALUE 2147483647 CACHE 1 ),
    CONSTRAINT curso_estudiante_pkey PRIMARY KEY (codigo_matricula)
);

COMMENT ON TABLE public.curso_estudiante
    IS 'Utilizado para representar la matrícula de un estudiante a un curso';

CREATE TABLE IF NOT EXISTS public.docente
(
    login_persona character varying COLLATE pg_catalog."default" NOT NULL,
    CONSTRAINT docente_pkey PRIMARY KEY (login_persona)
);

COMMENT ON TABLE public.docente
    IS 'Utilizado para guardar los docentes en la base de datos';

CREATE TABLE IF NOT EXISTS public.espacio_academico
(
    codigo_espacio integer NOT NULL GENERATED ALWAYS AS IDENTITY ( INCREMENT 1 START 1 MINVALUE 1 MAXVALUE 2147483647 CACHE 1 ),
    descripcion character varying(200) COLLATE pg_catalog."default" NOT NULL,
    codigo_plan integer NOT NULL,
    CONSTRAINT espacio_academico_pkey PRIMARY KEY (codigo_espacio),
    CONSTRAINT plan_estudio_unique UNIQUE (codigo_plan)
);

CREATE TABLE IF NOT EXISTS public.estudiante
(
    login_persona character varying COLLATE pg_catalog."default" NOT NULL,
    CONSTRAINT estudiante_pkey PRIMARY KEY (login_persona)
);

COMMENT ON TABLE public.estudiante
    IS 'Utilizado para modelar el rol de un estudiante en la base de datos';

CREATE TABLE IF NOT EXISTS public.examen
(
    codigo_examen integer NOT NULL GENERATED ALWAYS AS IDENTITY (INCREMENT 1 START 1 MINVALUE 1  MAXVALUE 2147483647 CACHE 1 ),
    nota_maxima numeric NOT NULL,
    nota_minima numeric NOT NULL,
    peso_examen integer NOT NULL,
    cantidad_preguntas integer,
    nombre character varying COLLATE pg_catalog."default" NOT NULL,
    descripcion character varying COLLATE pg_catalog."default" NOT NULL,
    tiempo_limite time without time zone NOT NULL,
    codigo_categoria integer,
    codigo_docente character varying COLLATE pg_catalog."default" NOT NULL,
    CONSTRAINT examen_pkey PRIMARY KEY (codigo_examen)
);

CREATE TABLE IF NOT EXISTS public.examen_tema
(
    codigo_examen integer NOT NULL,
    codigo_tema integer NOT NULL,
    CONSTRAINT examen_tema_pkey PRIMARY KEY (codigo_examen, codigo_tema)
);

CREATE TABLE IF NOT EXISTS public.horario
(
    aula character varying COLLATE pg_catalog."default" NOT NULL,
    dia character varying COLLATE pg_catalog."default" NOT NULL,
    hora_inicio character varying COLLATE pg_catalog."default" NOT NULL,
    hora_fin character varying COLLATE pg_catalog."default" NOT NULL,
    codigo_curso integer NOT NULL,
    CONSTRAINT horario_pkey PRIMARY KEY (aula, dia, hora_inicio, hora_fin, codigo_curso)
);

CREATE TABLE IF NOT EXISTS public.opcion
(
    codigo_opcion integer NOT NULL,
    descripcion character varying COLLATE pg_catalog."default" NOT NULL,
    respuesta_correcta character varying COLLATE pg_catalog."default" NOT NULL,
    palabra_faltante character varying COLLATE pg_catalog."default",
    orden integer,
    pareja character varying COLLATE pg_catalog."default",
    CONSTRAINT opcion_pkey PRIMARY KEY (codigo_opcion, descripcion)
);

CREATE TABLE IF NOT EXISTS public.persona
(
    login character varying COLLATE pg_catalog."default" NOT NULL,
    password character varying COLLATE pg_catalog."default" NOT NULL,
    nombre character varying COLLATE pg_catalog."default" NOT NULL,
    CONSTRAINT persona_pkey PRIMARY KEY (login)
);

COMMENT ON TABLE public.persona
    IS 'Utilizado para almacenar el login y contraseña de una persona';

CREATE TABLE IF NOT EXISTS public.plan_estudio
(
    codigo_plan integer NOT NULL GENERATED ALWAYS AS IDENTITY ( INCREMENT 1 START 1 MINVALUE 1 MAXVALUE 2147483647 CACHE 1 ),
    descripcion character varying COLLATE pg_catalog."default" NOT NULL,
    CONSTRAINT plan_estudio_pkey PRIMARY KEY (codigo_plan)
);

CREATE TABLE IF NOT EXISTS public.pregunta
(
    codigo_pregunta integer NOT NULL GENERATED ALWAYS AS IDENTITY ( INCREMENT 1 START 1 MINVALUE 1 MAXVALUE 2147483647 CACHE 1 ),
    "isPublic" boolean NOT NULL,
    tipo character varying COLLATE pg_catalog."default" NOT NULL,
    "isFather" boolean NOT NULL,
    peso numeric NOT NULL,
    enunciado character varying COLLATE pg_catalog."default" NOT NULL,
    codigo_subpregunta integer,
    codigo_docente character varying COLLATE pg_catalog."default" NOT NULL,
    codigo_tema integer,
    CONSTRAINT pregunta_pkey PRIMARY KEY (codigo_pregunta)
);

CREATE TABLE IF NOT EXISTS public.pregunta_examen
(
    codigo_pregunta integer NOT NULL,
    codigo_examen integer NOT NULL,
    codigo_pregunta_examen integer NOT NULL GENERATED ALWAYS AS IDENTITY ( INCREMENT 1 START 1 MINVALUE 1 MAXVALUE 2147483647 CACHE 1 ),
    CONSTRAINT pregunta_examen_pkey PRIMARY KEY (codigo_pregunta_examen)
);

CREATE TABLE IF NOT EXISTS public.pregunta_presentacion
(
    codigo_presentacion integer NOT NULL,
    codigo_pregunta_examen integer NOT NULL,
    codigo_pregunta_presentacion integer NOT NULL GENERATED ALWAYS AS IDENTITY ( INCREMENT 1 START 1 MINVALUE 1 MAXVALUE 2147483647 CACHE 1 ),
    codigo_opcion integer,
    respuesta character varying COLLATE pg_catalog."default",
    descripcion_opcion character varying,
    CONSTRAINT pregunta_presentacion_pkey PRIMARY KEY (codigo_pregunta_presentacion)
);

CREATE TABLE IF NOT EXISTS public.presentacion_examen
(
    codigo_matricula integer NOT NULL,
    codigo_examen integer NOT NULL,
    nota_examen numeric,
    codigo_presentacion integer NOT NULL GENERATED ALWAYS AS IDENTITY ( INCREMENT 1 START 1 MINVALUE 1 MAXVALUE 2147483647 CACHE 1 ),
    CONSTRAINT presentacion_examen_pkey PRIMARY KEY (codigo_presentacion)
);

CREATE TABLE IF NOT EXISTS public.curso_examen
(
    codigo_curso_examen integer NOT NULL GENERATED ALWAYS AS IDENTITY ( INCREMENT 1 START 1 MINVALUE 1 MAXVALUE 2147483647 CACHE 1 ),
    codigo_examen integer NOT NULL,
    codigo_curso integer NOT NULL,
    fecha_presentacion timestamp without time zone NOT NULL,
    CONSTRAINT curso_examen_pkey PRIMARY KEY (codigo_curso_examen)
);

CREATE TABLE IF NOT EXISTS public.tema
(
    codigo_tema integer NOT NULL GENERATED ALWAYS AS IDENTITY ( INCREMENT 1 START 1 MINVALUE 1 MAXVALUE 2147483647 CACHE 1 ),
    descripcion character varying COLLATE pg_catalog."default" NOT NULL,
    codigo_unidad integer NOT NULL,
    CONSTRAINT tema_pkey PRIMARY KEY (codigo_tema)
);

CREATE TABLE IF NOT EXISTS public.unidad
(
    codigo_unidad integer NOT NULL GENERATED ALWAYS AS IDENTITY ( INCREMENT 1 START 1 MINVALUE 1 MAXVALUE 2147483647 CACHE 1 ),
    descripcion character varying COLLATE pg_catalog."default" NOT NULL,
    codigo_plan integer NOT NULL,
    CONSTRAINT unidad_pkey PRIMARY KEY (codigo_unidad)
);

ALTER TABLE IF EXISTS public.administrador
    ADD CONSTRAINT login_persona_fk FOREIGN KEY (login_persona)
    REFERENCES public.persona (login) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION
    NOT VALID;
CREATE INDEX IF NOT EXISTS administrador_pkey
    ON public.administrador(login_persona);


ALTER TABLE IF EXISTS public.curso
    ADD CONSTRAINT docente_fk FOREIGN KEY (codigo_docente)
    REFERENCES public.docente (login_persona) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION
    NOT VALID;


ALTER TABLE IF EXISTS public.curso
    ADD CONSTRAINT espacio_academico_fk FOREIGN KEY (codigo_espacio)
    REFERENCES public.espacio_academico (codigo_espacio) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION
    NOT VALID;


ALTER TABLE IF EXISTS public.curso_estudiante
    ADD CONSTRAINT codigo_curso_fk FOREIGN KEY (codigo_curso)
    REFERENCES public.curso (codigo_curso) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION
    NOT VALID;


ALTER TABLE IF EXISTS public.curso_estudiante
    ADD CONSTRAINT codigo_estudiante_fk FOREIGN KEY (codigo_estudiante)
    REFERENCES public.estudiante (login_persona) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION
    NOT VALID;


ALTER TABLE IF EXISTS public.docente
    ADD CONSTRAINT login_persona_fk FOREIGN KEY (login_persona)
    REFERENCES public.persona (login) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION
    NOT VALID;

COMMENT ON CONSTRAINT login_persona_fk ON public.docente
    IS 'Utilizado para relacionar a este docente con su login';

CREATE INDEX IF NOT EXISTS docente_pkey
    ON public.docente(login_persona);


ALTER TABLE IF EXISTS public.espacio_academico
    ADD CONSTRAINT codigo_plan_fk FOREIGN KEY (codigo_plan)
    REFERENCES public.plan_estudio (codigo_plan) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION
    NOT VALID;
CREATE INDEX IF NOT EXISTS plan_estudio_unique
    ON public.espacio_academico(codigo_plan);


ALTER TABLE IF EXISTS public.estudiante
    ADD CONSTRAINT login_persona_fk FOREIGN KEY (login_persona)
    REFERENCES public.persona (login) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION
    NOT VALID;

COMMENT ON CONSTRAINT login_persona_fk ON public.estudiante
    IS 'Utilizado para almacenar el login del estudiante';

CREATE INDEX IF NOT EXISTS estudiante_pkey
    ON public.estudiante(login_persona);


ALTER TABLE IF EXISTS public.examen
    ADD CONSTRAINT categoria_fk FOREIGN KEY (codigo_categoria)
    REFERENCES public.categoria_examen (codigo_categoria) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION
    NOT VALID;


ALTER TABLE IF EXISTS public.examen
    ADD CONSTRAINT docente_fk FOREIGN KEY (codigo_docente)
    REFERENCES public.docente (login_persona) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION
    NOT VALID;


ALTER TABLE IF EXISTS public.examen_tema
    ADD CONSTRAINT "examen_FK" FOREIGN KEY (codigo_examen)
    REFERENCES public.examen (codigo_examen) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION
    NOT VALID;


ALTER TABLE IF EXISTS public.examen_tema
    ADD CONSTRAINT "tema_FK" FOREIGN KEY (codigo_tema)
    REFERENCES public.tema (codigo_tema) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION
    NOT VALID;


ALTER TABLE IF EXISTS public.horario
    ADD CONSTRAINT curso_fk FOREIGN KEY (codigo_curso)
    REFERENCES public.curso (codigo_curso) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION
    NOT VALID;


ALTER TABLE IF EXISTS public.opcion
    ADD CONSTRAINT pregunta_fk FOREIGN KEY (codigo_opcion)
    REFERENCES public.pregunta (codigo_pregunta) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION
    NOT VALID;
CREATE INDEX IF NOT EXISTS opcion_pkey
    ON public.opcion(codigo_opcion);


ALTER TABLE IF EXISTS public.pregunta
    ADD CONSTRAINT docente_fk FOREIGN KEY (codigo_docente)
    REFERENCES public.docente (login_persona) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION
    NOT VALID;


ALTER TABLE IF EXISTS public.pregunta
    ADD CONSTRAINT subpregunta_fk FOREIGN KEY (codigo_subpregunta)
    REFERENCES public.pregunta (codigo_pregunta) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION
    NOT VALID;


ALTER TABLE IF EXISTS public.pregunta
    ADD CONSTRAINT tema_fk FOREIGN KEY (codigo_tema)
    REFERENCES public.tema (codigo_tema) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION
    NOT VALID;


ALTER TABLE IF EXISTS public.pregunta_examen
    ADD CONSTRAINT examen_fk FOREIGN KEY (codigo_examen)
    REFERENCES public.examen (codigo_examen) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION
    NOT VALID;


ALTER TABLE IF EXISTS public.pregunta_examen
    ADD CONSTRAINT pregunta_fk FOREIGN KEY (codigo_pregunta)
    REFERENCES public.pregunta (codigo_pregunta) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION
    NOT VALID;


ALTER TABLE IF EXISTS public.pregunta_presentacion
    ADD CONSTRAINT opcion_fk FOREIGN KEY (codigo_opcion, descripcion_opcion)
    REFERENCES public.opcion (codigo_opcion, descripcion) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION
    NOT VALID;


ALTER TABLE IF EXISTS public.pregunta_presentacion
    ADD CONSTRAINT pregunta_examen_fk FOREIGN KEY (codigo_pregunta_examen)
    REFERENCES public.pregunta_examen (codigo_pregunta_examen) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION
    NOT VALID;


ALTER TABLE IF EXISTS public.pregunta_presentacion
    ADD CONSTRAINT presentacion_fk FOREIGN KEY (codigo_presentacion)
    REFERENCES public.presentacion_examen (codigo_presentacion) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION
    NOT VALID;


ALTER TABLE IF EXISTS public.presentacion_examen
    ADD CONSTRAINT estudiante_fk FOREIGN KEY (codigo_matricula)
    REFERENCES public.curso_estudiante (codigo_matricula) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION
    NOT VALID;


ALTER TABLE IF EXISTS public.curso_examen
    ADD CONSTRAINT curso_fk FOREIGN KEY (codigo_curso)
    REFERENCES public.curso (codigo_curso) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION
    NOT VALID;



ALTER TABLE IF EXISTS public.curso_examen
    ADD CONSTRAINT examen_fk FOREIGN KEY (codigo_examen)
    REFERENCES public.examen (codigo_examen) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION
    NOT VALID;

ALTER TABLE IF EXISTS public.presentacion_examen
    ADD CONSTRAINT examen_fk FOREIGN KEY (codigo_examen)
    REFERENCES public.examen (codigo_examen) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION
    NOT VALID;


ALTER TABLE IF EXISTS public.tema
    ADD CONSTRAINT unidad_fk FOREIGN KEY (codigo_unidad)
    REFERENCES public.unidad (codigo_unidad) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION
    NOT VALID;


ALTER TABLE IF EXISTS public.unidad
    ADD CONSTRAINT plan_estudio_fk FOREIGN KEY (codigo_plan)
    REFERENCES public.plan_estudio (codigo_plan) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION
    NOT VALID;


--corrections

ALTER TABLE IF EXISTS public.presentacion_examen ADD fecha_presentacion date NULL;
ALTER TABLE IF EXISTS public.presentacion_examen ADD tiempo_presentacion time NULL;
ALTER TABLE IF EXISTS public.presentacion_examen ADD ip varchar NULL;
ALTER TABLE IF EXISTS public.presentacion_examen ALTER COLUMN nota_examen TYPE decimal USING nota_examen::decimal;
ALTER TABLE IF EXISTS public.examen ALTER COLUMN peso_examen TYPE decimal USING peso_examen::decimal;
ALTER TABLE IF EXISTS public.opcion ALTER COLUMN orden TYPE char varying USING orden::char varying;



--reports

CREATE OR REPLACE VIEW examen_por_estudiante as (select pe.fecha_presentacion, pe.nota_examen, pe.tiempo_presentacion,pe.ip, p.nombre from presentacion_examen pe 
join curso_estudiante ce on ce.codigo_matricula = pe.codigo_matricula 
join estudiante e on e.login_persona = ce.codigo_estudiante 
join persona p on p.login = e.login_persona);

	
create or replace view respuestas_incorrectas_pregunta as (SELECT p.enunciado enunciado ,
            count(pp.respuesta) AS respuestas_incorrectas,
            p.codigo_pregunta codigo_pregunta
           FROM pregunta p
           	 JOIN pregunta_presentacion pp ON pp.codigo_opcion  = p.codigo_pregunta
           	 JOIN pregunta_examen pe ON pe.codigo_pregunta = p.codigo_pregunta
             JOIN opcion o ON o.codigo_opcion = pp.codigo_opcion and o.descripcion = pp.descripcion_opcion
          WHERE pp.respuesta::text <> o.respuesta_correcta::text 
          		or pp.respuesta <> o.palabra_faltante
          		or pp.respuesta <> o.orden 
          		or pp.respuesta <> o.pareja
          GROUP BY p.enunciado, p.codigo_pregunta);
          
          
          
create or replace view respuestas_correctas_pregunta as (SELECT p.enunciado enunciado ,
            count(pp.respuesta) AS respuestas_correctas,
            p.codigo_pregunta codigo_pregunta
           FROM pregunta p
           	 JOIN pregunta_presentacion pp ON pp.codigo_opcion  = p.codigo_pregunta
           	 JOIN pregunta_examen pe ON pe.codigo_pregunta = p.codigo_pregunta
             JOIN opcion o ON o.codigo_opcion = pp.codigo_opcion and o.descripcion = pp.descripcion_opcion
          WHERE pp.respuesta::text = o.respuesta_correcta::text 
          		or pp.respuesta = o.palabra_faltante
          		or pp.respuesta = o.orden 
          		or pp.respuesta = o.pareja
          GROUP BY p.enunciado, p.codigo_pregunta);



create or replace view respuestas_pregunta as (SELECT p.enunciado enunciado ,
            count(pp.respuesta) AS respuestas,
            p.codigo_pregunta codigo_pregunta
           FROM pregunta p
           	 JOIN pregunta_presentacion pp ON pp.codigo_opcion  = p.codigo_pregunta
           	 JOIN pregunta_examen pe ON pe.codigo_pregunta = p.codigo_pregunta
             JOIN opcion o ON o.codigo_opcion = pp.codigo_opcion and o.descripcion = pp.descripcion_opcion
          GROUP BY p.enunciado, p.codigo_pregunta);




create or replace view reporte_por_pregunta as (select  p.codigo_pregunta codigo_pregunta, p.enunciado enunciado,
	coalesce(rip.respuestas_incorrectas, 0) respuestas_incorrectas,
	coalesce (rcp.respuestas_correctas,0) respuestas_correctas,
	coalesce (rp.respuestas, 0) cantidad_respuestas,
	(coalesce (rcp.respuestas_correctas,0)*100)/(coalesce (rp.respuestas, 1)) || '%'porcentaje_correctas
		from pregunta p
			left join respuestas_incorrectas_pregunta rip on rip.codigo_pregunta = p.codigo_pregunta 
			left join respuestas_correctas_pregunta rcp on rcp.codigo_pregunta = p.codigo_pregunta 
			left join respuestas_pregunta rp on rp.codigo_pregunta = p.codigo_pregunta
			group by p.codigo_pregunta, p.enunciado ,rip.respuestas_incorrectas, rcp.respuestas_correctas, rp.respuestas);



create or replace view reporte_pregunta as (SELECT p.enunciado enunciado ,
            count(pp.respuesta) AS respuestas,
            p.codigo_pregunta codigo_pregunta
           FROM pregunta p
           	 JOIN pregunta_presentacion pp ON pp.codigo_opcion  = p.codigo_pregunta
           	 JOIN pregunta_examen pe ON pe.codigo_pregunta = p.codigo_pregunta
             JOIN opcion o ON o.codigo_opcion = pp.codigo_opcion and o.descripcion = pp.descripcion_opcion
          GROUP BY p.enunciado, p.codigo_pregunta);
          












 CREATE OR REPLACE VIEW reporte_por_estudiante AS (
    select sq.nombre_curso, sq.nombre_estudiante, sq.nota_definitiva, case when nota_definitiva < 2.98 then 'Reprobado' else 'Aprobado' end as estado 
    from
        (select c.descripcion nombre_curso ,p.nombre nombre_estudiante, sum(pe.nota_examen * (ex.peso_examen/100)) nota_definitiva
            from presentacion_examen pe 
            join curso_estudiante ce on ce.codigo_matricula = pe.codigo_matricula 
            join curso c on c.codigo_curso = ce.codigo_curso 
            join estudiante e on e.login_persona = ce.codigo_estudiante 
            join persona p on p.login = e.login_persona 
            join examen ex on ex.codigo_examen = pe.codigo_examen 
    group by c.codigo_curso, p.nombre) sq);



    create or replace view reporte_reprobados as 
    (select sq.nombre_curso, count(*) cantidad_estudiantes_reprobados
    from(
        select c.descripcion nombre_curso ,p.nombre nombre_estudiante, sum(pe.nota_examen * (ex.peso_examen/100)) nota_definitiva
            from presentacion_examen pe 
            join curso_estudiante ce on ce.codigo_matricula = pe.codigo_matricula 
            join curso c on c.codigo_curso = ce.codigo_curso 
            join estudiante e on e.login_persona = ce.codigo_estudiante 
            join persona p on p.login = e.login_persona 
            join examen ex on ex.codigo_examen = pe.codigo_examen 
    group by c.codigo_curso, p.nombre) sq where sq.nota_definitiva < 2.98 group by sq.nombre_curso);


    create or replace view reporte_aprobados as (
        select sq.nombre_curso, count(*) cantidad_estudiantes_aprobados
    from(
        select c.descripcion nombre_curso ,p.nombre nombre_estudiante, sum(pe.nota_examen * (ex.peso_examen/100)) nota_definitiva
            from presentacion_examen pe 
            join curso_estudiante ce on ce.codigo_matricula = pe.codigo_matricula 
            join curso c on c.codigo_curso = ce.codigo_curso 
            join estudiante e on e.login_persona = ce.codigo_estudiante 
            join persona p on p.login = e.login_persona 
            join examen ex on ex.codigo_examen = pe.codigo_examen 
    group by c.codigo_curso, p.nombre) sq where sq.nota_definitiva > 2.98 group by sq.nombre_curso);


        CREATE OR REPLACE VIEW reporte_por_curso AS (
        select coalesce (ra.nombre_curso,rr.nombre_curso) nombre_curso, coalesce(ra.cantidad_estudiantes_aprobados,0) 
                        estudiantes_aprobados, coalesce(rr.cantidad_estudiantes_reprobados,0) estudiantes_reprobados 
                            from reporte_aprobados ra full join reporte_reprobados rr on ra.nombre_curso = rr.nombre_curso);


 CREATE OR REPLACE VIEW public.respuestas_incorrectas_examen
AS SELECT COALESCE(sum(sq.respuestas_incorrectas), 0::numeric) AS cantidad_respuestas_incorrectas,
    sq.codigo_examen
   FROM ( SELECT count(pp.respuesta) AS respuestas_incorrectas,
            ce.codigo_curso_examen AS codigo_examen
           FROM curso_examen ce
             JOIN examen e ON e.codigo_examen = ce.codigo_examen
             JOIN presentacion_examen pe ON pe.codigo_examen = e.codigo_examen
             JOIN pregunta_presentacion pp ON pp.codigo_presentacion = pe.codigo_presentacion
             JOIN pregunta_examen pex ON pex.codigo_pregunta_examen = pp.codigo_pregunta_examen
             JOIN pregunta p ON p.codigo_pregunta = pex.codigo_pregunta
             JOIN opcion o ON o.codigo_opcion = p.codigo_pregunta
          WHERE pp.respuesta::text <> o.respuesta_correcta::text
                or pp.respuesta <> o.palabra_faltante
          		or pp.respuesta <> o.orden 
          		or pp.respuesta <> o.pareja
          GROUP BY pp.respuesta, ce.codigo_curso_examen) sq
  GROUP BY sq.codigo_examen;


create or replace view promedio_max_min_examen as(select avg(pe.nota_examen) promedio_notas_examen, max(pe.nota_examen) nota_maxima, min(pe.nota_examen) nota_minima, ce.codigo_curso_examen codigo_examen from curso_examen ce 
join examen e on e.codigo_examen = ce.codigo_examen 
join presentacion_examen pe on pe.codigo_examen = e.codigo_examen group by ce.codigo_curso_examen);


create or replace view preguntas_respondidas_examen as (select sq.codigo_curso_examen codigo_examen, sq.nombre_examen, count(sq.codigo_pregunta) cantidad_preguntas_respondidas from (select ce.codigo_curso_examen codigo_curso_examen, p.codigo_pregunta codigo_pregunta, e.nombre nombre_examen 
from curso_examen ce 
join examen e on e.codigo_examen = ce.codigo_examen 
join presentacion_examen pe on pe.codigo_examen = e.codigo_examen 
join pregunta_presentacion pp on pp.codigo_presentacion = pe.codigo_presentacion 
join pregunta_examen pex on pex.codigo_pregunta_examen = pp.codigo_pregunta_examen 
join pregunta p on p.codigo_pregunta = pex.codigo_pregunta 
where pp.respuesta != ''
group by ce.codigo_curso_examen, p.codigo_pregunta, e.nombre) sq group by sq.codigo_curso_examen, sq.nombre_examen);



CREATE OR REPLACE VIEW public.respuestas_correctas_examen
AS SELECT COALESCE(sum(sq.respuestas_correctas), 0::numeric) AS cantidad_respuestas_correctas,
    sq.codigo_examen
   FROM ( SELECT count(pp.respuesta) AS respuestas_correctas,
            ce.codigo_curso_examen AS codigo_examen
           FROM curso_examen ce
             JOIN examen e ON e.codigo_examen = ce.codigo_examen
             JOIN presentacion_examen pe ON pe.codigo_examen = e.codigo_examen
             JOIN pregunta_presentacion pp ON pp.codigo_presentacion = pe.codigo_presentacion
             JOIN pregunta_examen pex ON pex.codigo_pregunta_examen = pp.codigo_pregunta_examen
             JOIN pregunta p ON p.codigo_pregunta = pex.codigo_pregunta
             JOIN opcion o ON o.codigo_opcion = p.codigo_pregunta
          WHERE pp.respuesta::text = o.respuesta_correcta::text
                or pp.respuesta <> o.palabra_faltante
          		or pp.respuesta <> o.orden 
          		or pp.respuesta <> o.pareja
          GROUP BY pp.respuesta, ce.codigo_curso_examen) sq
  GROUP BY sq.codigo_examen;


CREATE OR REPLACE VIEW reporte_examenes AS ( select ce.codigo_curso_examen, pre.nombre_examen, pre.cantidad_preguntas_respondidas, coalesce(rce.cantidad_respuestas_correctas,0) cantidad_respuestas_correctas, coalesce (rie.cantidad_respuestas_incorrectas,0) cantidad_respuestas_incorrectas, pmme.promedio_notas_examen promedio_notas_examen, pmme.nota_maxima nota_maxima, pmme.nota_minima nota_minima 
from curso_examen ce 
full join preguntas_respondidas_examen pre on pre.codigo_examen = ce.codigo_curso_examen 
full join respuestas_correctas_examen rce on ce.codigo_curso_examen = rce.codigo_examen 
full join respuestas_incorrectas_examen rie on ce.codigo_curso_examen = rie.codigo_examen
left join promedio_max_min_examen pmme on pmme.codigo_examen = ce.codigo_curso_examen);



create or replace view cantidad_respuestas_correctas_por_tema as(
select  count(pp.codigo_pregunta_presentacion) cantidad_respuestas_correctas , t.codigo_tema codigo_tema
   from tema t
   join examen_tema et on t.codigo_tema = et.codigo_tema 
   join examen e on e.codigo_examen = et.codigo_examen 
   join presentacion_examen pe on e.codigo_examen = pe.codigo_examen 
   join pregunta_presentacion pp on pe.codigo_presentacion = pp.codigo_presentacion 
   join opcion o ON o.codigo_opcion = pp.codigo_opcion and o.descripcion = pp.descripcion_opcion
   join pregunta p on p.codigo_pregunta = o.codigo_opcion and p.codigo_tema = t.codigo_tema 
   WHERE pp.respuesta = o.respuesta_correcta OR pp.respuesta = o.palabra_faltante OR pp.respuesta = o.orden OR pp.respuesta = o.pareja
   group by t.codigo_tema);
  
create or replace view cantidad_respuestas_incorrectas_por_tema as(
select  count(pp.codigo_pregunta_presentacion) cantidad_respuestas_incorrectas , t.codigo_tema codigo_tema
   from tema t
   join examen_tema et on t.codigo_tema = et.codigo_tema 
   join examen e on e.codigo_examen = et.codigo_examen 
   join presentacion_examen pe on e.codigo_examen = pe.codigo_examen 
   join pregunta_presentacion pp on pe.codigo_presentacion = pp.codigo_presentacion 
   join opcion o ON o.codigo_opcion = pp.codigo_opcion and o.descripcion = pp.descripcion_opcion
   join pregunta p on p.codigo_pregunta = o.codigo_opcion 
   WHERE pp.respuesta != o.respuesta_correcta OR pp.respuesta != o.palabra_faltante OR pp.respuesta != o.orden OR pp.respuesta != o.pareja 
   group by t.codigo_tema);
   
create or replace view cantidad_preguntas_respondidas_por_tema as(
select count(pp.codigo_pregunta_presentacion) cantidad_preguntas_respondidas , t.codigo_tema codigo_tema
   from tema t
   join examen_tema et on t.codigo_tema = et.codigo_tema 
   join examen e on e.codigo_examen = et.codigo_examen 
   join presentacion_examen pe on e.codigo_examen = pe.codigo_examen 
   join pregunta_presentacion pp on pe.codigo_presentacion = pp.codigo_presentacion 
   where pp.respuesta != '' group by t.codigo_tema);
   
CREATE OR REPLACE VIEW public.reporte_por_tema
AS SELECT t.codigo_tema,
    t.descripcion ,
    COALESCE(rct.cantidad_respuestas_correctas, 0) AS respuestas_correctas,
    COALESCE(rit.cantidad_respuestas_incorrectas, 0) AS respuestas_incorrectas,
    COALESCE(prt.cantidad_preguntas_respondidas, 0) AS cantidad_respuestas,
    (COALESCE(rct.cantidad_respuestas_correctas, 0) * 100 / COALESCE(prt.cantidad_preguntas_respondidas, 1)) || '%' AS porcentaje_correctas,
    (COALESCE(rit.cantidad_respuestas_incorrectas, 0) * 100 / COALESCE(prt.cantidad_preguntas_respondidas, 1)) || '%' AS porcentaje_incorrectas
   FROM tema t
     left join cantidad_respuestas_correctas_por_tema rct on rct.codigo_tema = t.codigo_tema 
     left join cantidad_respuestas_incorrectas_por_tema rit on rit.codigo_tema = t.codigo_tema 
     left join cantidad_preguntas_respondidas_por_tema prt on prt.codigo_tema = t.codigo_tema 
  GROUP BY t.codigo_tema , t.descripcion , rct.cantidad_respuestas_correctas,rit.cantidad_respuestas_incorrectas, prt.cantidad_preguntas_respondidas;


--Populating database


-- Users
INSERT INTO public.persona (login,"password",nombre)
	VALUES ('jitrivino@uniquindio.edu.co','bases','Jorge Iván Triviño');
INSERT INTO public.persona (login,"password",nombre)
	VALUES ('mateo.estradar@uqvirtual.edu.co','michi','Mateo Estrada Ramirez');
INSERT INTO public.persona (login,"password",nombre)
	VALUES ('lauraa.suarezg@uqvirtual.edu.co','laura','Laura Alejandra Suárez Gutiérrez');
INSERT INTO public.persona (login,"password",nombre)
	VALUES ('leidyj.ceballosh@uqvirtual.edu.co','leidy','Leidy Jhoana Ceballos Hernandez');


-- Teachers

-- Auto-generated SQL script #202205312028
INSERT INTO public.docente (login_persona)
	VALUES ('jitrivino@uniquindio.edu.co');

-- Students

INSERT INTO public.estudiante (login_persona)
	VALUES ('lauraa.suarezg@uqvirtual.edu.co');
INSERT INTO public.estudiante (login_persona)
	VALUES ('mateo.estradar@uqvirtual.edu.co');
INSERT INTO public.estudiante (login_persona)
	VALUES ('leidyj.ceballosh@uqvirtual.edu.co');


-- Extras

INSERT INTO public.plan_estudio (descripcion)
	VALUES ('Plan de Estudios Bases de Datos');

-- Auto-generated SQL script #202205312031
INSERT INTO public.unidad (descripcion,codigo_plan)
	VALUES ('Unidad 1 - Fundamentos de Bases de Datos',1);
INSERT INTO public.unidad (descripcion,codigo_plan)
	VALUES ('Unidad 2 - Modelo Entidad Relación',1);
INSERT INTO public.unidad (descripcion,codigo_plan)
	VALUES ('Unidad 3 - Modelo Relacional',1);
INSERT INTO public.unidad (descripcion,codigo_plan)
	VALUES ('Unidad 4 - Consultas SQL',1);

INSERT INTO public.tema (descripcion,codigo_unidad)
	VALUES ('Historia de las Bases de Datos',1);
INSERT INTO public.tema (descripcion,codigo_unidad)
	VALUES ('Estructura del Sistema de Bases de Datos',1);
INSERT INTO public.tema (descripcion,codigo_unidad)
	VALUES ('Atributos en el Modelo Entidad Relación',2);
INSERT INTO public.tema (descripcion,codigo_unidad)
	VALUES ('Entidad Asociativa Modelo Entidad Relación',2);
INSERT INTO public.tema (descripcion,codigo_unidad)
	VALUES ('Modelo Entidad Relación a Relacional',3);
INSERT INTO public.tema (descripcion,codigo_unidad)
	VALUES ('Nomalización del Modelo Relacional',3);
INSERT INTO public.tema (descripcion,codigo_unidad)
	VALUES ('Álgebra Relacional',4);
INSERT INTO public.tema (descripcion,codigo_unidad)
	VALUES ('Subconsultas',4);


INSERT INTO public.espacio_academico (descripcion,codigo_plan)
	VALUES ('Espacio Académico de Bases de Datos I',1);

-- Course

INSERT INTO public.curso (descripcion,codigo_espacio,codigo_docente)
	VALUES ('Bases de Datos I 01D 2022-1',1,'jitrivino@uniquindio.edu.co');

-- Course and students

INSERT INTO public.curso_estudiante (codigo_estudiante,codigo_curso)
	VALUES ('lauraa.suarezg@uqvirtual.edu.co',1);
INSERT INTO public.curso_estudiante (codigo_estudiante,codigo_curso)
	VALUES ('mateo.estradar@uqvirtual.edu.co',1);
INSERT INTO public.curso_estudiante (codigo_estudiante,codigo_curso)
	VALUES ('leidyj.ceballosh@uqvirtual.edu.co',1);


-- Exam categories
INSERT INTO public.categoria_examen (descripcion)
	VALUES ('Examen Cuchilla');
INSERT INTO public.categoria_examen (descripcion)
	VALUES ('Examen Más o Menitos');
INSERT INTO public.categoria_examen (descripcion)
	VALUES ('Examen Regalo');


-- Timetables
INSERT INTO public.horario (aula,dia,hora_inicio,hora_fin,codigo_curso)
	VALUES ('D4-404','Lunes','16:00','18:00',1);
INSERT INTO public.horario (aula,dia,hora_inicio,hora_fin,codigo_curso)
	VALUES ('Robótica I','Miércoles','07:00','09:00',1);
INSERT INTO public.horario (aula,dia,hora_inicio,hora_fin,codigo_curso)
	VALUES ('Auditorio Ingeniería','Viernes','11:00','13:00',1);


--Exams 
INSERT INTO public.examen (nota_maxima,nota_minima,peso_examen,cantidad_preguntas,nombre,descripcion,tiempo_limite,codigo_categoria,codigo_docente)
	VALUES (5,0,20,2,'Parcial 1 - Bases de Datos 1','Primer Parcial del Curso','02:00:00',3,'jitrivino@uniquindio.edu.co');
INSERT INTO public.examen (nota_maxima,nota_minima,peso_examen,cantidad_preguntas,nombre,descripcion,tiempo_limite,codigo_categoria,codigo_docente)
	VALUES (5,0,20,2,'Parcial 2 - Bases de Datos 1','Segundo Parcial del Curso','02:00:00',2,'jitrivino@uniquindio.edu.co');
INSERT INTO public.examen (nota_maxima,nota_minima,peso_examen,cantidad_preguntas,nombre,descripcion,tiempo_limite,codigo_categoria,codigo_docente)
	VALUES (5,0,20,2,'Parcial 3 - Bases de Datos 1','Tercer Parcial del Curso','02:00:00',2,'jitrivino@uniquindio.edu.co');
INSERT INTO public.examen (nota_maxima,nota_minima,peso_examen,cantidad_preguntas,nombre,descripcion,tiempo_limite,codigo_categoria,codigo_docente)
	VALUES (5,0,20,2,'Parcial 4 - Bases de Datos 1','Último Parcial del Curso','02:00:00',1,'jitrivino@uniquindio.edu.co');


-- Questions
INSERT INTO public.pregunta
("isPublic", tipo, "isFather", peso, enunciado, codigo_subpregunta, codigo_docente, codigo_tema)
VALUES(true, 'unica-respuesta', false, 20, '¿Qué es una base de datos?', NULL, 'jitrivino@uniquindio.edu.co', 1);
INSERT INTO public.pregunta
("isPublic", tipo, "isFather", peso, enunciado, codigo_subpregunta, codigo_docente, codigo_tema)
VALUES(true, 'multiple-respuesta', false, 20, 'Seleccione de los siguentes literales, aquellos que sean un tipo de base de datos', NULL, 'jitrivino@uniquindio.edu.co', 1);
INSERT INTO public.pregunta
("isPublic", tipo, "isFather", peso, enunciado, codigo_subpregunta, codigo_docente, codigo_tema)
VALUES(true, 'completar', false, 20, 'Un dato es un hecho conocido que puede registrarse y tiene un significado...', NULL, 'jitrivino@uniquindio.edu.co', 1);
INSERT INTO public.pregunta
("isPublic", tipo, "isFather", peso, enunciado, codigo_subpregunta, codigo_docente, codigo_tema)
VALUES(true, 'emparejar', false, 20, 'Empareja las opciones de acuerdo a los conceptos', NULL, 'jitrivino@uniquindio.edu.co', 1);



--Choice
INSERT INTO public.opcion (codigo_opcion,descripcion,respuesta_correcta,palabra_faltante,orden,pareja) VALUES
	 (1,'Una comida','Algo donde puedo almacenar datos',NULL,NULL,NULL),
	 (1,'Un animal','Algo donde puedo almacenar datos',NULL,NULL,NULL),
	 (2,'Base de datos Orientada a Objetos','Base de datos Orientada a Objetos',NULL,NULL,NULL),
	 (2,'Base de datos Relacional','Base de datos Relacional',NULL,NULL,NULL),
	 (2,'Base de datos no Relacional','Base de datos no Relacional',NULL,NULL,NULL),
	 (2,'Una cubeta de huevos','no aplica',NULL,NULL,NULL),
	 (1,'Un conjunto de datos relacionados entre sí','Un conjunto de datos relacionados entre sí',NULL,NULL,NULL),
	 (3,'Completa de acuerdo a la definición de dato','implícito','implícito',NULL,NULL),
	 (4,'Recurso valioso en la era moderna','información',NULL,NULL,'informacion'),
	 (4,'Posee un propósito específico, se dirige a un grupo de usuarios y tiene aplicaciones que interesan a dichos usuarios','base de datos',NULL,NULL,'base de datos');


-- exam and questions

INSERT INTO public.pregunta_examen
(codigo_pregunta, codigo_examen)
VALUES(1, 1);
INSERT INTO public.pregunta_examen
(codigo_pregunta, codigo_examen)
VALUES(2, 1);
INSERT INTO public.pregunta_examen
(codigo_pregunta, codigo_examen)
VALUES(3, 1);
INSERT INTO public.pregunta_examen
(codigo_pregunta, codigo_examen)
VALUES(4, 1);



END;