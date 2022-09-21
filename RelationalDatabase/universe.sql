--
-- PostgreSQL database dump
--

-- Dumped from database version 12.9 (Ubuntu 12.9-2.pgdg20.04+1)
-- Dumped by pg_dump version 12.9 (Ubuntu 12.9-2.pgdg20.04+1)

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

DROP DATABASE universe;
--
-- Name: universe; Type: DATABASE; Schema: -; Owner: freecodecamp
--

CREATE DATABASE universe WITH TEMPLATE = template0 ENCODING = 'UTF8' LC_COLLATE = 'C.UTF-8' LC_CTYPE = 'C.UTF-8';


ALTER DATABASE universe OWNER TO freecodecamp;

\connect universe

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

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: galaxy; Type: TABLE; Schema: public; Owner: freecodecamp
--

CREATE TABLE public.galaxy (
    galaxy_id integer NOT NULL,
    name character varying(20) NOT NULL,
    diameter_in_ly numeric(9,0) NOT NULL,
    type integer NOT NULL,
    is_dwarf boolean DEFAULT false NOT NULL
);


ALTER TABLE public.galaxy OWNER TO freecodecamp;

--
-- Name: galaxy_galaxy_id_seq; Type: SEQUENCE; Schema: public; Owner: freecodecamp
--

CREATE SEQUENCE public.galaxy_galaxy_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.galaxy_galaxy_id_seq OWNER TO freecodecamp;

--
-- Name: galaxy_galaxy_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: freecodecamp
--

ALTER SEQUENCE public.galaxy_galaxy_id_seq OWNED BY public.galaxy.galaxy_id;


--
-- Name: galaxy_type; Type: TABLE; Schema: public; Owner: freecodecamp
--

CREATE TABLE public.galaxy_type (
    galaxy_type_id integer NOT NULL,
    name character varying(20) NOT NULL,
    description text
);


ALTER TABLE public.galaxy_type OWNER TO freecodecamp;

--
-- Name: galaxy_type_galaxy_type_id_seq; Type: SEQUENCE; Schema: public; Owner: freecodecamp
--

CREATE SEQUENCE public.galaxy_type_galaxy_type_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.galaxy_type_galaxy_type_id_seq OWNER TO freecodecamp;

--
-- Name: galaxy_type_galaxy_type_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: freecodecamp
--

ALTER SEQUENCE public.galaxy_type_galaxy_type_id_seq OWNED BY public.galaxy_type.galaxy_type_id;


--
-- Name: moon; Type: TABLE; Schema: public; Owner: freecodecamp
--

CREATE TABLE public.moon (
    moon_id integer NOT NULL,
    name character varying(20) NOT NULL,
    orbit_period text NOT NULL,
    diameter_in_km numeric(9,1) NOT NULL,
    planet_id integer NOT NULL
);


ALTER TABLE public.moon OWNER TO freecodecamp;

--
-- Name: moon_moon_id_seq; Type: SEQUENCE; Schema: public; Owner: freecodecamp
--

CREATE SEQUENCE public.moon_moon_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.moon_moon_id_seq OWNER TO freecodecamp;

--
-- Name: moon_moon_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: freecodecamp
--

ALTER SEQUENCE public.moon_moon_id_seq OWNED BY public.moon.moon_id;


--
-- Name: planet; Type: TABLE; Schema: public; Owner: freecodecamp
--

CREATE TABLE public.planet (
    planet_id integer NOT NULL,
    name character varying(20) NOT NULL,
    diameter_in_km numeric(9,0) NOT NULL,
    orbit_period text NOT NULL,
    rings integer NOT NULL,
    star_id integer NOT NULL,
    is_dwarf boolean NOT NULL
);


ALTER TABLE public.planet OWNER TO freecodecamp;

--
-- Name: planet_planet_id_seq; Type: SEQUENCE; Schema: public; Owner: freecodecamp
--

CREATE SEQUENCE public.planet_planet_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.planet_planet_id_seq OWNER TO freecodecamp;

--
-- Name: planet_planet_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: freecodecamp
--

ALTER SEQUENCE public.planet_planet_id_seq OWNED BY public.planet.planet_id;


--
-- Name: star; Type: TABLE; Schema: public; Owner: freecodecamp
--

CREATE TABLE public.star (
    star_id integer NOT NULL,
    name character varying(20) NOT NULL,
    age_in_million_years numeric(10,3),
    other_names text,
    galaxy_id integer NOT NULL,
    color character varying(15) NOT NULL
);


ALTER TABLE public.star OWNER TO freecodecamp;

--
-- Name: star_star_id_seq; Type: SEQUENCE; Schema: public; Owner: freecodecamp
--

CREATE SEQUENCE public.star_star_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.star_star_id_seq OWNER TO freecodecamp;

--
-- Name: star_star_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: freecodecamp
--

ALTER SEQUENCE public.star_star_id_seq OWNED BY public.star.star_id;


--
-- Name: galaxy galaxy_id; Type: DEFAULT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.galaxy ALTER COLUMN galaxy_id SET DEFAULT nextval('public.galaxy_galaxy_id_seq'::regclass);


--
-- Name: galaxy_type galaxy_type_id; Type: DEFAULT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.galaxy_type ALTER COLUMN galaxy_type_id SET DEFAULT nextval('public.galaxy_type_galaxy_type_id_seq'::regclass);


--
-- Name: moon moon_id; Type: DEFAULT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.moon ALTER COLUMN moon_id SET DEFAULT nextval('public.moon_moon_id_seq'::regclass);


--
-- Name: planet planet_id; Type: DEFAULT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.planet ALTER COLUMN planet_id SET DEFAULT nextval('public.planet_planet_id_seq'::regclass);


--
-- Name: star star_id; Type: DEFAULT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.star ALTER COLUMN star_id SET DEFAULT nextval('public.star_star_id_seq'::regclass);


--
-- Data for Name: galaxy; Type: TABLE DATA; Schema: public; Owner: freecodecamp
--

INSERT INTO public.galaxy VALUES (1, 'Milky Way', 140000, 2, false);
INSERT INTO public.galaxy VALUES (3, 'Messier 87', 120000, 3, false);
INSERT INTO public.galaxy VALUES (2, 'Andromeda', 120000, 3, false);
INSERT INTO public.galaxy VALUES (4, 'Magellanic Clouds', 14000, 2, true);
INSERT INTO public.galaxy VALUES (5, 'Pinwheel', 170000, 1, false);
INSERT INTO public.galaxy VALUES (6, 'Sombrero', 50000, 1, false);
INSERT INTO public.galaxy VALUES (7, 'Triangulum', 60000, 1, false);
INSERT INTO public.galaxy VALUES (8, 'Whirpool', 60000, 1, false);


--
-- Data for Name: galaxy_type; Type: TABLE DATA; Schema: public; Owner: freecodecamp
--

INSERT INTO public.galaxy_type VALUES (1, 'Spiral', 'Most common, comprises 77% of them. Main components: disk, bulge and halo.');
INSERT INTO public.galaxy_type VALUES (2, 'Barred Spiral', 'Spiraled from the nucleus with a bar of matter running through them, which forms arms.');
INSERT INTO public.galaxy_type VALUES (4, 'Irregular', 'Has unique shape or size, often asymmetrical. Dont have a bulge, disk or arms.');
INSERT INTO public.galaxy_type VALUES (5, 'Lenticular', 'Intermediate between spiral and elliptical galaxies. Has bulge and disk, dont have spiral shape.');
INSERT INTO public.galaxy_type VALUES (3, 'Elliptical', 'Has ovular shape and lack a central bulge, its replaced by a black hole.');


--
-- Data for Name: moon; Type: TABLE DATA; Schema: public; Owner: freecodecamp
--

INSERT INTO public.moon VALUES (1, 'The Moon', '27.3 days', 3475.0, 3);
INSERT INTO public.moon VALUES (2, 'Phobos', '7.7 hours', 22.2, 4);
INSERT INTO public.moon VALUES (3, 'Deimos', '1.3 days', 12.4, 4);
INSERT INTO public.moon VALUES (4, 'Io', '1.77 days', 3643.2, 5);
INSERT INTO public.moon VALUES (5, 'Europa', '3.55 days', 3121.6, 5);
INSERT INTO public.moon VALUES (6, 'Ganymede', '7.16 days', 5262.4, 5);
INSERT INTO public.moon VALUES (7, 'Callisto', '16.69 days', 4820.6, 5);
INSERT INTO public.moon VALUES (8, 'Enceladus', '1.4 days', 504.2, 6);
INSERT INTO public.moon VALUES (9, 'Rhea', '4.5 days', 1528.6, 6);
INSERT INTO public.moon VALUES (10, 'Titan', '15.9 days', 5149.4, 6);
INSERT INTO public.moon VALUES (11, 'Iapetus', '79.3 days', 1471.2, 6);
INSERT INTO public.moon VALUES (12, 'Miranda', '1.4 days', 471.6, 7);
INSERT INTO public.moon VALUES (13, 'Titania', '8.7 days', 1577.8, 7);
INSERT INTO public.moon VALUES (14, 'Triton', '5.9 days', 2706.8, 8);
INSERT INTO public.moon VALUES (16, 'Charon', '6.4 days', 1207.2, 9);
INSERT INTO public.moon VALUES (17, 'Hi’iaka', '49.12 days', 310.0, 20);
INSERT INTO public.moon VALUES (18, 'Namaka', '1.79 days', 170.0, 20);
INSERT INTO public.moon VALUES (19, 'MK2', '12.4 days', 175.0, 21);
INSERT INTO public.moon VALUES (20, 'Dysnomia', '15.8 days', 700.0, 22);
INSERT INTO public.moon VALUES (15, 'Thalassa', '7.44 hours', 90.0, 8);


--
-- Data for Name: planet; Type: TABLE DATA; Schema: public; Owner: freecodecamp
--

INSERT INTO public.planet VALUES (2, 'Venus', 12104, '225 days', 0, 1, false);
INSERT INTO public.planet VALUES (1, 'Mercury', 4879, '88 days', 0, 1, false);
INSERT INTO public.planet VALUES (3, 'Earth', 12756, '365.24 days', 0, 1, false);
INSERT INTO public.planet VALUES (6, 'Saturn', 120536, '29.5 years', 7, 1, false);
INSERT INTO public.planet VALUES (5, 'Jupiter', 142982, '11.9 years', 4, 1, false);
INSERT INTO public.planet VALUES (4, 'Mars', 6792, '1.9 years', 0, 1, false);
INSERT INTO public.planet VALUES (7, 'Uranus', 51118, '84 years', 13, 1, false);
INSERT INTO public.planet VALUES (8, 'Neptune', 49528, '164.8 years', 5, 1, false);
INSERT INTO public.planet VALUES (9, 'Pluto', 2372, '248 years', 0, 1, true);
INSERT INTO public.planet VALUES (26, 'Dimidio', 7500, '4.23 days', 0, 9, false);
INSERT INTO public.planet VALUES (27, 'Gamma Cephei Ab', 3250, '2.7 years', 0, 10, false);
INSERT INTO public.planet VALUES (23, 'Kepler-11e', 8000, '32 days', 0, 8, false);
INSERT INTO public.planet VALUES (20, 'Kepler-11b', 25194, '10.3 days', 0, 8, false);
INSERT INTO public.planet VALUES (24, 'Kepler-11f', 8000, '46.7 days', 0, 8, false);
INSERT INTO public.planet VALUES (21, 'Kepler-11c', 8000, '13 days', 0, 8, false);
INSERT INTO public.planet VALUES (25, 'Kepler-11g', 8000, '118.4 days', 0, 8, false);
INSERT INTO public.planet VALUES (22, 'Kepler-11d', 8000, '22.7 days', 0, 8, false);
INSERT INTO public.planet VALUES (11, 'Ceres', 950, '4.6 years', 0, 1, true);
INSERT INTO public.planet VALUES (12, 'Haumea', 1740, '283.3 years', 0, 1, true);
INSERT INTO public.planet VALUES (13, 'Makemake', 1434, '309.9 years', 0, 1, true);
INSERT INTO public.planet VALUES (14, 'Eris', 2326, '560.9 years', 0, 1, true);


--
-- Data for Name: star; Type: TABLE DATA; Schema: public; Owner: freecodecamp
--

INSERT INTO public.star VALUES (2, 'UY Scuti', 6.500, NULL, 1, 'Red');
INSERT INTO public.star VALUES (3, 'Sirius A', 240.000, 'Alpha Canis Majoris', 1, 'White');
INSERT INTO public.star VALUES (4, 'Sirius B', 120.000, 'Alpha Canis Majoris B', 1, 'White');
INSERT INTO public.star VALUES (1, 'The Sun', 4600.000, 'Luna', 1, 'Yellow');
INSERT INTO public.star VALUES (5, 'Alpha Andromedae', 60.000, 'Alpheratz, 21 Andromedae', 2, 'Blue');
INSERT INTO public.star VALUES (6, 'Beta Andromedae', NULL, 'Mirach, 43 Andromedae', 2, 'Red');
INSERT INTO public.star VALUES (7, 'Gamma Andromedae', 6.500, 'Almach, Alamak, 57 Andromedae', 2, 'Blue');
INSERT INTO public.star VALUES (10, 'Gamma Cephei A', 3250.000, 'Errai', 1, 'Orange');
INSERT INTO public.star VALUES (11, 'Gamma Cephei B', 3250.000, 'Tadmor', 1, 'Red');
INSERT INTO public.star VALUES (8, 'Kepler-11', 8000.000, NULL, 1, 'Yellow');
INSERT INTO public.star VALUES (9, '51 Pegasi', 7500.000, 'Helvetios', 1, 'Red');


--
-- Name: galaxy_galaxy_id_seq; Type: SEQUENCE SET; Schema: public; Owner: freecodecamp
--

SELECT pg_catalog.setval('public.galaxy_galaxy_id_seq', 8, true);


--
-- Name: galaxy_type_galaxy_type_id_seq; Type: SEQUENCE SET; Schema: public; Owner: freecodecamp
--

SELECT pg_catalog.setval('public.galaxy_type_galaxy_type_id_seq', 6, true);


--
-- Name: moon_moon_id_seq; Type: SEQUENCE SET; Schema: public; Owner: freecodecamp
--

SELECT pg_catalog.setval('public.moon_moon_id_seq', 22, true);


--
-- Name: planet_planet_id_seq; Type: SEQUENCE SET; Schema: public; Owner: freecodecamp
--

SELECT pg_catalog.setval('public.planet_planet_id_seq', 22, true);


--
-- Name: star_star_id_seq; Type: SEQUENCE SET; Schema: public; Owner: freecodecamp
--

SELECT pg_catalog.setval('public.star_star_id_seq', 11, true);


--
-- Name: galaxy galaxy_name_unq; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.galaxy
    ADD CONSTRAINT galaxy_name_unq UNIQUE (name);


--
-- Name: galaxy galaxy_pkey; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.galaxy
    ADD CONSTRAINT galaxy_pkey PRIMARY KEY (galaxy_id);


--
-- Name: galaxy_type galaxy_type_pkey; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.galaxy_type
    ADD CONSTRAINT galaxy_type_pkey PRIMARY KEY (galaxy_type_id);


--
-- Name: galaxy_type galaxy_type_type_name_key; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.galaxy_type
    ADD CONSTRAINT galaxy_type_type_name_key UNIQUE (name);


--
-- Name: moon moon_name_unq; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.moon
    ADD CONSTRAINT moon_name_unq UNIQUE (name);


--
-- Name: moon moon_pkey; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.moon
    ADD CONSTRAINT moon_pkey PRIMARY KEY (moon_id);


--
-- Name: planet planet_name_unq; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.planet
    ADD CONSTRAINT planet_name_unq UNIQUE (name);


--
-- Name: planet planet_pkey; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.planet
    ADD CONSTRAINT planet_pkey PRIMARY KEY (planet_id);


--
-- Name: star star_name_unq; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.star
    ADD CONSTRAINT star_name_unq UNIQUE (name);


--
-- Name: star star_pkey; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.star
    ADD CONSTRAINT star_pkey PRIMARY KEY (star_id);


--
-- Name: moon moon_planet_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.moon
    ADD CONSTRAINT moon_planet_id_fkey FOREIGN KEY (planet_id) REFERENCES public.planet(planet_id);


--
-- Name: planet planet_star_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.planet
    ADD CONSTRAINT planet_star_id_fkey FOREIGN KEY (star_id) REFERENCES public.star(star_id);


--
-- Name: star star_galaxy_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.star
    ADD CONSTRAINT star_galaxy_id_fkey FOREIGN KEY (galaxy_id) REFERENCES public.galaxy(galaxy_id);


--
-- PostgreSQL database dump complete
--

