
-- 2. Muestra los nombres de todas las películas con una clasificación por edades de ‘Rʼ.

select 
	"film_id",
	"title",
	"rating"
from 
	"film"
where
	"rating" = 'R';


-- 3. Encuentra los nombres de los actores que tengan un “actor_idˮ entre 30 y 40.

select 
	"actor_id",
	concat("first_name", ' ',"last_name") as nombre_actor
from 
	"actor"
where
	"actor_id" between '30'and'40'; -- selecciona los "actor_id" con valor >= 30 y =< 40


select 
	"actor_id",
	concat("first_name", ' ',"last_name") as nombre_actor
from
	"actor"
where
	"actor_id" > 30 and "actor_id" < 40; -- selecciona los "actor_id" con valor > 30 y < 40


-- 4. Obtén las películas cuyo idioma coincide con el idioma original
	
select 
	"film_id",
	"title"
from 
	"film"
where 
	"original_language_id" is not null 
	and "language_id"="original_language_id";
-- El ejercicio no muestra resultados porque toda la columna "original_language_id" tiene valor "null"


-- 5. Ordena las películas por duración de forma ascendente.

select 
	"film_id", 
	"title", 
	"length" as duracion_pelicula
from 
	"film"
order by 
	length asc;


-- 6. Encuentra el nombre y apellido de los actores que tengan ‘Allenʼ en su apellido.

select 
	"actor_id",
	"first_name",
	"last_name"
from 
	"actor"
where
	"last_name" like '%Allen%';
-- No hay ningun actor que contenga "Allen" en su apellido.


-- 7. Encuentra la cantidad total de películas en cada clasificación de la tabla “filmˮ y muestra la clasificación junto con el recuento

select 
	"rating",
	count (*) as total_peliculas
from
	"film"
group by 
	rating;


-- 8. Encuentra el título de todas las películas que son ‘PG-13’ o tienen una duración mayor a 3 horas en la tabla film. 

select 
	"title",
	"rating",
	"length"
from 
	"film"
where
	"rating"= 'PG-13' or "length"> 180
order by "rating";


-- 9. Encuentra la variabilidad de lo que costaría reemplazar las películas.

select 
	round(variance("replacement_cost"),2) as variabilidad_reemplazo
from "film";


-- 10. Encuentra la mayor y menor duración de una película de nuestra BBDD.

select
	max ("length") as duración_máxima,
	min ("length") as duración_mínima
from "film";

-- 10.1 Encuentra la mayor y menor duración de una película de nuestra BBDD y muestra el nombre

select 
	"title",
	"length" as duración_máxima
from 
	"film"
order by 
	"length" desc
limit 1;

select 
	"title",
	"length" as duración_mínima
from 
	"film"
order by 
	"length" asc
limit 1;


-- 11. Encuentra lo que costó el antepenúltimo alquiler ordenado por día.

SELECT 
    date(r.rental_date) as fecha,
    p.amount as coste
from (
    select
        r.*,
        row_number() over (partition by date(r.rental_date) 
        order by r.rental_date desc) as orden
    from 
        rental r
) as r
join 
	payment p ON r.rental_id = p.rental_id
where
    r.orden = 3
order by
    fecha;


-- 12. Encuentra el título de las películas en la tabla “film” que no sean ni ‘NC-17’ ni ‘G’ en cuanto a su clasificación.

select
	"title",
	"rating"
from 
	"film"
where
	"rating" not in ('NC-17', 'G')
order by 
	"rating";


-- 13. Encuentra el promedio de duración de las películas para cada clasificación de la tabla film y muestra la clasificación junto con el promedio de duración.

select
	"rating",
	round (AVG ("length"),2) as duración_promedio
from 
	"film"
group by
	"rating";


-- 14. Encuentra el título de todas las películas que tengan una duración mayor a 180 minutos.

select 
	"title",
	"length" as duracion
from 
	"film"
where 
	"length" > 180
order by 
	"length";


-- 15. ¿Cuánto dinero ha generado en total la empresa?

select 
	Sum ("amount") as total_ingresos
from 
	"payment";


-- 16. Muestra los 10 clientes con mayor valor de id.

select 
	"customer_id",
	concat ("first_name", ' ', "last_name") as nombre_completo
from 
	"customer"
order by
	"customer_id" desc
limit 10;


-- 17. Encuentra el nombre y apellido de los actores que aparecen en la película con título ‘Egg Igby’.

select 
	actor."actor_id",
	concat ("first_name", ' ', "last_name") as nombre_completo
from 
	"actor"
inner join 
	film_actor fa on actor.actor_id = fa.actor_id
inner join 
	film on fa.film_id = film.film_id
where 
	film.title = 'EGG IGBY'; -- si ponemos el título en minúscula como el enunciado, no devuelve nada porque no reconoce Egg Igby.

-- Comprobación film_id y actores que participan en la película "EGG IGBY"
select 
	"film_id",
	"title"
from 
	"film"
where 
	"title" = 'EGG IGBY';

select *
from "film_actor"
where "film_id" = 274;


-- 18. Selecciona todos los nombres de las películas únicos.

select distinct "title"
from "film";


-- 19.Encuentra el título de las películas que son comedias y tienen una duración mayor a 180 minutos en la tabla “film”.

select
    f."title",
    f."length"
from
    "film" f
join 
    film_category fc om f.film_id = fc.film_id
join 
    category c on fc.category_id = c.category_id
where
    c.name = 'Comedy'
    and f.length > 180;
 

-- 20. Encuentra las categorías de películas que tienen un promedio de duración superior a 110 minutos y muestra el nombre de la categoría junto con el promedio de duración.

select 
	c.name as categoria, 
	round(AVG (f.length),2) as promedio_duración
from
	"film" f
join
	film_category fc on f.film_id = fc.film_id 
join
	category c on fc.category_id = c.category_id 
group by 
	c."name" 
having AVG (f.length)>110;


-- 21. ¿Cuál es la media de duración del alquiler de las películas?

select 
	round (AVG (rental_duration),0) as media_alquiler_dias
from "film";


-- 22. Crea una columna con el nombre y apellidos de todos los actores y actrices.

select 
	concat ("first_name", ' ', "last_name") as nombre_completo
from "actor";


-- 23. Números de alquiler por día, ordenados por cantidad de alquiler de forma descendente.

select 
	date(r.rental_date) as fecha,
	count (*) as cantidad_alquiler
from
	"rental" r
group by 
	date(r.rental_date)
order by
	"cantidad_alquiler" desc;


-- 24. Encuentra las películas con una duración superior al promedio

select AVG ("length")  -- Comprobación promedio películas
from "film";

select 
	"title",
	"length"
from 
	"film"
where
	"length" > (select AVG (length) from "film")
order by
	length asc;


-- 25. Averigua el número de alquileres registrados por mes.

select
  date_trunc('month', rental_date)::date as mes,
  extract (year from rental_date)::int as año,
  extract (month from rental_date)::int as num_mes,
  count (*) as total_alquileres
from
	"rental"
group by
  date_trunc('month', rental_date)::date,
  extract (year from rental_date),
  extract (month from rental_date)
ORDER BY
  año, num_mes;


-- 26. Encuentra el promedio, la desviación estándar y varianza del total pagado.

select 	
	round (avg (amount), 2) as promedio,
	round (stddev(amount), 2) as desviacion_estandar,
	round (variance (amount),2) as varianza
from 
	"payment";


-- 27. ¿Qué películas se alquilan por encima del precio medio?

select -- ver cual es el promedio de alquiler
	avg(rental_rate)
from 
	"film";

select 
    f.film_id,
    f.title,
    f.rental_rate
from 
    film f
where  
    f.rental_rate > (
        select AVG(rental_rate)
        from film
    )
order by 
	rental_rate asc;


-- 28. Muestra el id de los actores que hayan participado en más de 40 películas.

select 
    a."actor_id",
    concat ("first_name", ' ',"last_name"),
    count (fa.film_id) as num_peliculas
from
    "actor" a
join
	film_actor fa on a.actor_id = fa.actor_id
group by  
    a.actor_id, a.first_name, a.last_name
having  
    count(fa.film_id) > 40
order by 
    num_peliculas desc;


-- 29. Obtener todas las películas y, si están disponibles en el inventario, mostrar la cantidad disponible.

select 
    f."film_id",
    f."title",
    count (i.inventory_id) as cantidad_disponible
from
    "film" f
left join
    inventory i on f.film_id = i.film_id
group by 
    f.film_id, f.title
order by 
    f.title;


-- 30. Obtener los actores y el número de películas en las que ha actuado.

select 
    a.actor_id,
    concat ("first_name", ' ',"last_name") as nombre_actor,
    count(fa.film_id) as num_peliculas
from
    "actor" a
join 
    film_actor fa on a.actor_id = fa.actor_id
group by 
    a.actor_id, a.first_name, a.last_name
order by 
    num_peliculas desc;


-- 31. Obtener todas las películas y mostrar los actores que han actuado en ellas, incluso si algunas películas no tienen actores asociados.

select 	
	f.film_id,
	f.title,
	concat ("first_name", ' ', "last_name") as nombre
from
	"film" f
left join 
	film_actor fa on f.film_id = fa.film_id 
left join 
	actor a on fa.actor_id = a.actor_id
order by
	f.film_id ;


-- 32. Obtener todos los actores y mostrar las películas en las que han actuado, incluso si algunos actores no han actuado en ninguna película.

select 	
	concat ("first_name", ' ', "last_name") as nombre,	
	f.film_id,
	f.title	
from 
	"actor" a
left join 
	film_actor fa on a.actor_id = fa.actor_id
left join 
	film f on fa.film_id = f.film_id 
order by
	nombre;


-- 33. Obtener todas las películas que tenemos y todos los registros de alquiler.

select 
	f.film_id,
	f.title, 
	r.rental_id,
	r.rental_date
from film f 
left join 	
	inventory i on f.film_id = i.film_id
left join 
	rental r on i.inventory_id = r.inventory_id
order by
	rental_id; 


select 
	f.film_id,
	f.title, 
	r.rental_id,
	date(r.rental_date) as fecha
from 
	film f 
left join 	
	inventory i on f.film_id = i.film_id
left join 
	rental r on i.inventory_id = r.inventory_id
order by 
	title;


-- 34. Encuentra los 5 clientes que más dinero se hayan gastado con nosotros.

select
	c.customer_id ,
	concat ("first_name", ' ', "last_name") as nombre,
	sum (p.amount) as total_pagado
from
	"customer" c
join
	payment p on c.customer_id = p.customer_id
group by 
	c.customer_id 
order by
	total_pagado desc
limit 5;


-- 35. Selecciona todos los actores cuyo primer nombre es 'Johnny'.

select 
	"actor_id",
	concat("first_name", ' ',"last_name") as nombre
from 
	"actor" a 
where
first_name='Johnny';
-- Con esta consulta, como en el enunciado el nombre está en minuscula, no hay ningún actor con el primer nombre Johnny

select 
	"actor_id",
	concat("first_name", ' ',"last_name") as nombre
from 
	"actor" a 
where
first_name='JOHNNY';
-- Sin embargo, con esta consulta, si cambio Johnny por JOHNNY, sí que aparecen dos actores.


-- 36. Renombra la columna “first_name” como Nombre y “last_name” como Apellido.

select 
	"first_name" as Nombre, 
	"last_name" as Apellido
from "actor";


-- 37. Encuentra el ID del actor más bajo y más alto en la tabla actor.

select 
	min ("actor_id") as id_mínimo,
	max ("actor_id") as id_máximo
from "actor";


-- 38. Cuenta cuántos actores hay en la tabla “actor”.

select 
	count(*) as total_actor
from actor a ;


-- 39.  Selecciona todos los actores y ordénalos por apellido en orden ascendente.

select 
	"actor_id",
	"first_name" as nombre,
	"last_name" as apellido
from 
	"actor"
order by 
	apellido,
	nombre;


-- 40. Selecciona las primeras 5 películas de la tabla “film”.

select 
	"film_id",
	"title"
from 
	"film"
limit 5;


-- 41. Agrupa los actores por su nombre y cuenta cuántos actores tienen el mismo nombre. ¿Cuál es el nombre más repetido?

select
    "first_name" AS nombre,
    COUNT("first_name") AS cantidad
from
    "actor"
group by 
    nombre
order by
    cantidad DESC;
-- los nombres más repetidos son KENNETH, PENELOPE y JULIA con 4 veces cada nombre.


-- 42. Encuentra todos los alquileres y los nombres de los clientes que los realizaron.

select  
    r."rental_id",
    r."rental_date",
    concat ("first_name", ' ', "last_name") as nombre    
from 
    "rental" r
join 
    customer c ON r.customer_id = c.customer_id
order by 
    nombre;


-- 43. Muestra todos los clientes y sus alquileres si existen, incluyendo aquellos que no tienen alquileres.

select
    c.customer_id,
    concat ("first_name", ' ',"last_name") AS nombre,
    r.rental_id,
    r.rental_date
from 
    customer c
left join 
    rental r ON c.customer_id = r.customer_id
order by 
 	customer_id;


-- 44. Realiza un CROSS JOIN entre las tablas film y category. ¿Aporta valor esta consulta? ¿Por qué?

-- comprobamos cuantas categorías hay: hay 16 categorías.
select *
from "category";


select
    f."film_id",
    f."title",
    c."category_id",
    c."name" AS categoria
from 
    "film" f
cross join 
    category c
order by 
    f.film_id, c.category_id;

-- No aporta valor porque el CROSS JOIN es un producto cartesiano y como tal, no tiene sentido que una película tenga 16 categorías.


-- 45. Encuentra los actores que han participado en películas de la categoría 'Action'.

select 
    a."actor_id",
    concat ("first_name",' ',"last_name") as nombre   
from 
    "actor" a
join 
    film_actor fa ON a.actor_id = fa.actor_id
join 
    film_category fc ON fa.film_id = fc.film_id
join 
    category c ON fc.category_id = c.category_id
where 
    c.name = 'Action'
group by 
    a.actor_id, a.first_name, a.last_name
order by 
    a.actor_id ;


-- 46. Encuentra todos los actores que no han participado en películas.

select 
	"actor_id",
	"film_id"	
from 
	film_actor fa 
where 
	fa.film_id is null; 

select 
	a."actor_id",
	concat ("first_name", ' ', "last_name") as nombre
from
	"actor" a 
left join
	film_actor fa on a.actor_id = fa.actor_id 
where
	fa.film_id is null;


-- 47. Selecciona el nombre de los actores y la cantidad de películas en las que han participado.

select 
	concat ("first_name", ' ', "last_name") as nombre,
    count(fa.film_id) as cantidad_peliculas
from 
    actor a
join 
    film_actor fa on a.actor_id = fa.actor_id
group by 
    a.actor_id, a.first_name, a.last_name
order by 
    cantidad_peliculas DESC;


-- 48. Crea una vista llamada “actor_num_peliculas” que muestre los nombres de los actores y el número de películas en las que han participado.

create view actor_num_peliculas as
select 
	concat ("first_name", ' ', "last_name") as nombre,
    count(fa.film_id) AS cantidad_peliculas
from 
    actor a
join 
    film_actor fa ON a.actor_id = fa.actor_id
group by 
    a.actor_id, a.first_name, a.last_name
order by 
    cantidad_peliculas DESC;

select *
from actor_num_peliculas anp ;


-- 49. Calcula el número total de alquileres realizados por cada cliente.

select 
    c.customer_id,
    concat ("first_name", ' ', "last_name") as nombre,
    count(r.rental_id) AS total_alquileres
from 
    customer c
left join 
    rental r ON c.customer_id = r.customer_id
group by 
    c.customer_id, c.first_name, c.last_name
order by 
    total_alquileres DESC;


-- 50. Calcula la duración total de las películas en la categoría 'Action'

select 
    c.name AS categoria,
    SUM(f.length) AS duracion_total_minutos
from 
    film f
join 
    film_category fc ON f.film_id = fc.film_id
join
    category c ON fc.category_id = c.category_id
where 
    c.name = 'Action'
group by
    c.name;


-- 51. Crea una tabla temporal llamada “cliente_rentas_temporal” para almacenar el total de alquileres por cliente.

create temporary table cliente_rentas_temporal AS
select 
    c.customer_id,
    concat ("first_name", ' ', "last_name") AS nombre,
    COUNT(r.rental_id) AS total_alquileres
from 
    customer c
left join 
    rental r ON c.customer_id = r.customer_id
group by 
    c.customer_id, c.first_name, c.last_name;

select *
from cliente_rentas_temporal
order by total_alquileres desc;


-- 52. Crea una tabla temporal llamada “peliculas_alquiladas” que almacene las películas que han sido alquiladas al menos 10 veces

create temporary table peliculas_alquiladas AS
select 
    f.film_id,
    f.title,
    count(r.rental_id) AS total_alquileres
from 
    film f
join 
    inventory i ON f.film_id = i.film_id
join 
    rental r ON i.inventory_id = r.inventory_id
group by 
    f.film_id, f.title
having 
    count(r.rental_id) >= 10;

select *
from peliculas_alquiladas
order by total_alquileres;


-- 53. Encuentra el título de las películas que han sido alquiladas por el cliente con el nombre ‘Tammy Sanders’ y que aún no se han devuelto. Ordena los resultados alfabéticamente por título de película.

select 
    f.title
from 
    customer c
join 
    rental r ON c.customer_id = r.customer_id
join 
    inventory i ON r.inventory_id = i.inventory_id
join 
    film f ON i.film_id = f.film_id
where 
    c.first_name = 'Tammy' -- Si pongo el nombre en minúscula, me devuelve 0 porque no reconoce el nombre de Tammy en su base de datos.
    and c.last_name = 'Sanders'
    and r.return_date IS NULL
order by 
    f.title ASC;


select 
    f.title
from 
    customer c
join 
    rental r ON c.customer_id = r.customer_id
join 
    inventory i ON r.inventory_id = i.inventory_id
join 
    film f ON i.film_id = f.film_id
where 
    c.first_name = 'TAMMY' -- Si pongo el nombre en MAYUSCULA, me devuelve 3 películas alquiladas.
    and c.last_name = 'SANDERS'
    and r.return_date IS NULL
order by 
    f.title ASC;


-- 54. Encuentra los nombres de los actores que han actuado en al menos una película que pertenece a la categoría ‘Sci-Fi’. Ordena los resultados alfabéticamente por apellido.

select 
    distinct a.first_name AS nombre,
    a.last_name AS apellido
from 
    actor a
join 
    film_actor fa ON a.actor_id = fa.actor_id
join 
    film_category fc ON fa.film_id = fc.film_id
join 
    category c ON fc.category_id = c.category_id
where 
    c.name = 'Sci-Fi'
order by 
    apellido asc;


-- 55. Encuentra el nombre y apellido de los actores que han actuado en películas que se alquilaron después de que la película ‘Spartacus Cheaper’ se alquilara por primera vez. Ordena los resultados alfabéticamente por apellido.

select distinct 
    a.first_name AS nombre,
    a.last_name AS apellido
from 
    actor a
join 
    film_actor fa ON a.actor_id = fa.actor_id
join 
    film f ON fa.film_id = f.film_id
join 
    inventory i ON f.film_id = i.film_id
join 
    rental r ON i.inventory_id = r.inventory_id
where 
    r.rental_date > (
        select min(r2.rental_date)
        from rental r2
        join inventory i2 ON r2.inventory_id = i2.inventory_id
        join film f2 ON i2.film_id = f2.film_id
        where f2.title = 'SPARTACUS CHEAPER' -- si lo pongo en mayúscula sí que lo detecta.
    )
order by 
    a.last_name ASC;


-- 56. Encuentra el nombre y apellido de los actores que no han actuado en ninguna película de la categoría ‘Music’.

select 
    a.first_name AS nombre,
    a.last_name AS apellido
from 
    actor a
where 
    a.actor_id NOT IN (
        select distinct fa.actor_id
        from film_actor fa
        join film_category fc ON fa.film_id = fc.film_id
        join category c ON fc.category_id = c.category_id
        where c.name = 'Music'
    )
order by 
    a.last_name asc;


-- 57. Encuentra el título de todas las películas que fueron alquiladas por más de 8 días

select 
	f.title,
    round(extract(EPOCH FROM (r.return_date - r.rental_date)) / 86400, 2) AS días_alquilada
from 
    rental r
join 
    inventory i ON r.inventory_id = i.inventory_id
join 
    film f ON i.film_id = f.film_id
where 
    r.return_date is not null
    and (r.return_date - r.rental_date) > INTERVAL '8 days'
order by
    f.title;


 -- 58. Encuentra el título de todas las películas que son de la misma categoría que ‘Animation’.

select 
    f.title
from 
    film f
join 
    film_category fc ON f.film_id = fc.film_id
join 
    category c ON fc.category_id = c.category_id
where 
    c.name = 'Animation'
order by 
    f.title ASC;

-- comprobación de la categoría.
select 
    f.title,
	c.name as categoria
from 
    film f
join 
    film_category fc ON f.film_id = fc.film_id
join 
    category c ON fc.category_id = c.category_id
where 
    c.name = 'Animation'
order by 
    f.title ASC;


-- 59. Encuentra los nombres de las películas que tienen la misma duración que la película con el título ‘Dancing Fever’. Ordena los resultados alfabéticamente por título de película.

select
	"title",
	"length"
from 
	"film"
where "length" = (
		select "length"
		from "film"
		where "title"= 'DANCING FEVER')
order by  
	title;

-- comprobación1
select 
	"title",
	"length"
from
	"film"
where 
	"title" = 'DANCING FEVER';

-- comprobación2
select 
	"title",
	"length"
from
	"film"
where "length" = 144
order by title;


-- 60. Encuentra los nombres de los clientes que han alquilado al menos 7 películas distintas. Ordena los resultados alfabéticamente por apellido.

select
    c.first_name as nombre,
    c.last_name as apellido,
    count (distinct f.film_id) as peliculas_distintas
from
    customer c
join
    rental r ON c.customer_id = r.customer_id
join 
    inventory i ON r.inventory_id = i.inventory_id
join 
    film f ON i.film_id = f.film_id
group by
    c.customer_id, c.first_name, c.last_name
having
    count (distinct f.film_id) >= 7
order by 
    c.last_name asc;


-- 61. Encuentra la cantidad total de películas alquiladas por categoría y muestra el nombre de la categoría junto con el recuento de alquileres.

select 
    c.name as categoria,
    count (r.rental_id) as total_alquileres
from 
    category c
join
    film_category fc on c.category_id = fc.category_id
join
    inventory i on fc.film_id = i.film_id
join
    rental r on i.inventory_id = r.inventory_id
group by
    c.name
order by
    total_alquileres DESC;


--62. Encuentra el número de películas por categoría estrenadas en 2006.

select
    c.name as categoria,
    count(f.film_id) as total_peliculas
from
    category c
join 
    film_category fc ON c.category_id = fc.category_id
join 
    film f ON fc.film_id = f.film_id
where
    f.release_year = 2006
group by
    c.name
order by 
    total_peliculas DESC;


-- 63. Obtén todas las combinaciones posibles de trabajadores con las tiendas que tenemos.

-- comprobación de personal
select *
from "staff";

-- comprobación de tiendas
select *
from "store";

select
	concat("first_name", ' ',"last_name") as nombre_empleado,
    st.store_id as tienda_id
from
    staff s
cross join
    store st
order by
     st.store_id ASC;


--64. Encuentra la cantidad total de películas alquiladas por cada cliente y muestra el ID del cliente, su nombre y apellido junto con la cantidad de películas alquiladas.

select
    c.customer_id as id_cliente,
    concat("first_name", ' ',"last_name") as nombre,
    count(r.rental_id) as total_alquileres
from 
    customer c
left join
    rental r ON c.customer_id = r.customer_id
group by 
    c.customer_id, 
    nombre
order by
    total_alquileres DESC;

