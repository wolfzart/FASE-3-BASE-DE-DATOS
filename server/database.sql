--
-- PostgreSQL database dump
--

-- Dumped from database version 10.14
-- Dumped by pg_dump version 10.14

-- Started on 2020-11-29 18:41:40

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- TOC entry 1 (class 3079 OID 12924)
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- TOC entry 2830 (class 0 OID 0)
-- Dependencies: 1
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


SET default_tablespace = '';

SET default_with_oids = false;

--
-- TOC entry 196 (class 1259 OID 16394)
-- Name: alumno; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.alumno (
    nombre character varying(50),
    rut character varying(12) NOT NULL,
    edad integer,
    sexo character varying(9)
);


ALTER TABLE public.alumno OWNER TO postgres;

--
-- TOC entry 197 (class 1259 OID 16399)
-- Name: apoderado; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.apoderado (
    id_apoderado integer NOT NULL,
    nombre character varying(50),
    edad integer,
    sexo character varying(9)
);


ALTER TABLE public.apoderado OWNER TO postgres;

--
-- TOC entry 199 (class 1259 OID 16409)
-- Name: asignatura; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.asignatura (
    id_asignatura integer NOT NULL,
    nombre_asignatura character varying(20),
    horario character varying(5),
    dia character varying(10),
    grado_curso integer,
    letra_curso character varying(3)
);


ALTER TABLE public.asignatura OWNER TO postgres;

--
-- TOC entry 198 (class 1259 OID 16404)
-- Name: curso; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.curso (
    grado integer NOT NULL,
    letra character varying(3) NOT NULL
);


ALTER TABLE public.curso OWNER TO postgres;

--
-- TOC entry 201 (class 1259 OID 16417)
-- Name: libro_de_vida; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.libro_de_vida (
    promedio_general integer,
    anotaciones integer,
    asistencias integer,
    grado_curso integer,
    letra_curso character varying(3),
    rut_alumno character varying(12)
);


ALTER TABLE public.libro_de_vida OWNER TO postgres;

--
-- TOC entry 200 (class 1259 OID 16414)
-- Name: tesoreria; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.tesoreria (
    fecha_de_vencimiento date,
    fecha_de_pago_realizado date,
    deuda integer,
    rut_alumno character varying(12),
    id_apoderado integer,
    interes integer
);


ALTER TABLE public.tesoreria OWNER TO postgres;

--
-- TOC entry 2689 (class 2606 OID 16398)
-- Name: alumno alumno_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.alumno
    ADD CONSTRAINT alumno_pkey PRIMARY KEY (rut);


--
-- TOC entry 2691 (class 2606 OID 16403)
-- Name: apoderado apoderado_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.apoderado
    ADD CONSTRAINT apoderado_pkey PRIMARY KEY (id_apoderado);


--
-- TOC entry 2695 (class 2606 OID 16413)
-- Name: asignatura asignatura_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.asignatura
    ADD CONSTRAINT asignatura_pkey PRIMARY KEY (id_asignatura);


--
-- TOC entry 2693 (class 2606 OID 16408)
-- Name: curso curso_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.curso
    ADD CONSTRAINT curso_pkey PRIMARY KEY (grado, letra);


--
-- TOC entry 2696 (class 2606 OID 16440)
-- Name: asignatura asignatura_grado_curso_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.asignatura
    ADD CONSTRAINT asignatura_grado_curso_fkey FOREIGN KEY (grado_curso, letra_curso) REFERENCES public.curso(grado, letra);


--
-- TOC entry 2700 (class 2606 OID 16430)
-- Name: libro_de_vida libro_de_vida_grado_curso_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.libro_de_vida
    ADD CONSTRAINT libro_de_vida_grado_curso_fkey FOREIGN KEY (grado_curso, letra_curso) REFERENCES public.curso(grado, letra);


--
-- TOC entry 2701 (class 2606 OID 16435)
-- Name: libro_de_vida libro_de_vida_grado_curso_fkey1; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.libro_de_vida
    ADD CONSTRAINT libro_de_vida_grado_curso_fkey1 FOREIGN KEY (grado_curso, letra_curso) REFERENCES public.curso(grado, letra);


--
-- TOC entry 2699 (class 2606 OID 16425)
-- Name: libro_de_vida libro_de_vida_rut_alumno_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.libro_de_vida
    ADD CONSTRAINT libro_de_vida_rut_alumno_fkey FOREIGN KEY (rut_alumno) REFERENCES public.alumno(rut);


--
-- TOC entry 2698 (class 2606 OID 16445)
-- Name: tesoreria tesoreria_id_apoderado_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tesoreria
    ADD CONSTRAINT tesoreria_id_apoderado_fkey FOREIGN KEY (id_apoderado) REFERENCES public.apoderado(id_apoderado);


--
-- TOC entry 2697 (class 2606 OID 16420)
-- Name: tesoreria tesoreria_rut_alumno_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tesoreria
    ADD CONSTRAINT tesoreria_rut_alumno_fkey FOREIGN KEY (rut_alumno) REFERENCES public.alumno(rut);


-- Completed on 2020-11-29 18:41:41

--
-- PostgreSQL database dump complete
--
