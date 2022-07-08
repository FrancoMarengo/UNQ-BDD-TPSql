-- 1. Obtener nombre, usuario y tipo de los repositorios con +6 commits de usuarios de Quilmes,
   -- ordenados por cantidad_pull_request ASC:
/*
  Comienzo proyectando los atributos pedidos -> nombre, usuario y tipo_repositorio de los REPOSITORIOs
  que obtuvieron más de 6 commits de usuarios de la ciudad de 'Quilmes'.
  ¿Cómo obtenemos COMMITs de un REPOSITORIO? Coloquialmente hablando, primero debo fijarme sus ARCHIVOs.
  Y luego, en si esos ARCHIVOs fueron "commiteados".
  ¿Cómo obtenemos los usuarios que contribuyeron en estos COMMITs? Debo fijarme sus CONTRIBUCIONes, que
  nos dicen el usuario contribuyente. Finalmente, de estos mismos usuarios podemos acceder a su ciudad
  a través de la tabla USUARIO.
  Debe cumplirse que la ciudad sea 'Quilmes' (WHERE -> opera sobre atributo individual);
  Necesaria agrupación de los atributos proyectados (GROUP BY) para preguntar si la cantidad total
  es mayor a 6 (HAVING). Así, se filtrarán los repositorios que obtuvieron más de 6 commits de 
  usuarios de la ciudad de 'Quilmes'.
  Finalmente, se ordena a los mismos ascendentemente por su cantidad_pull_request.
  Asumimos que este último atributo se refiere a los pull request de los repositorios.
*/
SELECT repositorio.nombre, repositorio.usuario, repositorio.tipo_repositorio
FROM repositorio
JOIN archivo ON archivo.nombre_repositorio = repositorio.nombre 
                AND archivo.usuario_repositorio = repositorio.usuario
JOIN commit ON archivo.id = commit.id_archivo
JOIN contribucion ON commit.hash = contribucion.hash
JOIN usuario ON contribucion.usuario = usuario.usuario
WHERE usuario.ciudad = 'Quilmes'
GROUP BY repositorio.nombre, repositorio.usuario, repositorio.tipo_repositorio
HAVING COUNT(*) > 6
ORDER BY repositorio.cantidad_pull_request ASC;




-- 2. Obtener los commits con fecha de cambio luego del 01/10/2021 ordenados descendentemente por hash, 
   -- ascendentemente por archivo y descendentemente por la fecha de cambio:
SELECT *
FROM commit 
WHERE fecha_cambio > '2021-10-1'
ORDER BY hash DESC, id_archivo ASC, fecha_cambio DESC;




-- 3. Obtener los repositorios que sólo poseen contribuciones de usuarios de Solano y con edad entre 18 y 21
   -- Deben cumplirse ambas condiciones:
SELECT repositorio.nombre, repositorio.usuario
FROM contribucion
JOIN (SELECT * 
          FROM usuario 
          WHERE usuario.ciudad = 'Solano' AND 
                        DATE_PART('years', AGE(usuario.fecha_nacimiento)) >= 18 AND 
                        DATE_PART('years', AGE(usuario.fecha_nacimiento)) <= 21) AS us
ON us.usuario = contribucion.usuario
JOIN commit ON commit.hash = contribucion.hash
JOIN archivo ON archivo.id = commit.id_archivo
JOIN repositorio ON repositorio.nombre = archivo.nombre_repositorio AND 
                                     repositorio.usuario = archivo.usuario_repositorio

EXCEPT 

SELECT repositorio.nombre, repositorio.usuario
FROM contribucion
JOIN (SELECT * 
          FROM usuario 
          WHERE usuario.ciudad <> 'Solano' AND 
                        DATE_PART('years', AGE(usuario.fecha_nacimiento)) <= 18 AND 
                        DATE_PART('years', AGE(usuario.fecha_nacimiento)) >= 21) AS usu
ON usu.usuario = contribucion.usuario
JOIN commit ON commit.hash = contribucion.hash
JOIN archivo ON archivo.id = commit.id_archivo
JOIN repositorio ON repositorio.nombre = archivo.nombre_repositorio AND 
                                     repositorio.usuario = archivo.usuario_repositorio;
    -- con AGE obtenemos la edad en base a una fecha, con respecto a la actual. Formato 'ys/ms/ds'
    -- y con DATE_PART, obtenemos una parte de este formato -> Los años, con 'years'. Cantidad comparable con 18 y 21




-- 4. Obtener un listado que muestre de cada repositorio, 
   -- el promedio de contribuciones de usuarios de Quilmes y de Varela:
   -- Asumimos que las contribuciones cuentan si el usuario es, o bien de 'Quilmes', o bien de 'Varela';
WITH contribucion_en_repo AS (
SELECT repositorio.nombre, contribucion.usuario, COUNT(contribucion) AS contr_hechas 
FROM repositorio
LEFT JOIN archivo ON repositorio.nombre = archivo.nombre_repositorio
                    AND repositorio.usuario = archivo.usuario_repositorio
LEFT JOIN commit ON archivo.id = commit.id_archivo
LEFT JOIN contribucion ON commit.hash = contribucion.hash
LEFT JOIN usuario ON contribucion.usuario = usuario.usuario
GROUP BY repositorio.nombre, contribucion.usuario
)
SELECT contribucion_en_repo.nombre, COALESCE(ROUND(AVG(contr_hechas),2), 0)
FROM contribucion_en_repo
LEFT JOIN 
(SELECT usuario 
FROM usuario 
WHERE usuario.ciudad = 'Quilmes' OR usuario.ciudad = 'Varela') AS usuarioQuilmesVarela
ON contribucion_en_repo.usuario=usuarioQuilmesVarela.usuario
GROUP BY contribucion_en_repo.nombre;




-- 5. Obtener un listado que muestre de cada archivo, el usuario que más commiteó en el mismo junto 
   -- con la cant de commits:
CREATE VIEW max_commits_archivo AS 
SELECT archivo_cant_commit.id_archivo, MAX (archivo_cant_commit.cant_commit) AS max_cant_commit
FROM (SELECT commit.id_archivo, usuario.usuario, COUNT(commit) AS cant_commit
FROM usuario
JOIN contribucion ON contribucion.usuario = usuario.usuario
JOIN commit ON commit.hash = contribucion.hash
GROUP BY commit.id_archivo, usuario.usuario) AS archivo_cant_commit
GROUP BY archivo_cant_commit.id_archivo;

SELECT commit.id_archivo, usuario.usuario, COUNT(commit) AS cant_commit
FROM usuario
JOIN contribucion ON contribucion.usuario = usuario.usuario
JOIN commit ON commit.hash = contribucion.hash
JOIN max_commits_archivo ON max_commits_archivo.id_archivo = commit.id_archivo
GROUP BY commit.id_archivo, usuario.usuario, max_commits_archivo.max_cant_commit
HAVING COUNT(commit) = max_commits_archivo.max_cant_commit
ORDER BY commit.id_archivo;




-- 6. Listado de las últimas actividades -> por usuario, suma de contribuciones hechas
   -- y promedio de la cantidad de cambios, ordenados DESC por las 2:
   -- Asumimos que debíamos listar todos los usuarios. Por eso realizamos un LEFT JOIN con usuario y contribucion
SELECT usuario.usuario, COALESCE(COUNT(contribucion.usuario), 0) AS total_contribuciones, 
                        COALESCE(AVG(contribucion.cantidad_cambios), 0) AS promedio_total_cambios
FROM usuario
LEFT JOIN contribucion ON usuario.usuario = contribucion.usuario
GROUP BY usuario.usuario
ORDER BY COUNT(contribucion.usuario) DESC, AVG(cantidad_cambios) DESC;




-- 7. Obtener el nombre de usuario y el repositorio en donde el usuario sea el creador del repositorio
   -- pero que NO haya hecho contribuciones, o haya hecho al menos 3:
SELECT repositorio.usuario, repositorio.nombre
FROM repositorio
JOIN contribucion ON contribucion.usuario = repositorio.usuario
GROUP BY repositorio.usuario, repositorio.nombre
HAVING COUNT(contribucion) >= 3

UNION

SELECT repositorio.usuario, repositorio.nombre
FROM repositorio
LEFT JOIN contribucion ON contribucion.usuario = repositorio.usuario
WHERE contribucion.usuario IS NULL;




-- 8 -- 
/* Obtener la cantidad de repositorios superseguros por ciudad:
   Pertenecen a usuarios con contraseña que poseen al menos un "#", +32 caracteres,
   mismo usuario hizo más de 10 contribuciones. Ordenados DESC por cantidad de favoritos.
   Listamos por cada ciudad existente en el sistema (conocida por USUARIO), la cantidad de 
   repositorios superseguros. Asumimos que el usuario autor del repositorio, tuvo que haber 
   hecho más de 10 contribuciones en total, sin importar el repositorio (no se especifica).
*/
SELECT usuario.ciudad, COALESCE(COUNT(repo_superseg), 0) AS cantidad_repos_superseguros
FROM usuario
LEFT JOIN repositorio ON usuario.usuario = repositorio.usuario
LEFT JOIN(
SELECT repositorio.*
FROM repositorio
JOIN usuario ON repositorio.usuario = usuario.usuario
JOIN contribucion ON usuario.usuario = contribucion.usuario
WHERE usuario.contrasenia LIKE '%#%' AND char_length(usuario.contrasenia) > 32
        AND 10 < (SELECT COUNT(*)
                  FROM contribucion
                  WHERE contribucion.usuario = repositorio.usuario)) AS repo_superseg
ON repositorio.nombre = repo_superseg.nombre
   AND repositorio.usuario = repo_superseg.usuario
GROUP BY usuario.ciudad, repo_superseg.cantidad_favoritos
ORDER BY repo_superseg.cantidad_favoritos DESC; 




-- 9. Obtener los 3 archivos más modificados del 2021 por usuarios que hayan hecho +6 pull requests,
   -- o que posean -3 repositorios (1 o ambas condiciones):
SELECT archivo.id
FROM archivo
JOIN commit ON archivo.id = commit.id_archivo AND 
          commit.fecha_cambio >= '2021-01-01' AND 
          commit.fecha_cambio <= '2021-12-31'
JOIN contribucion ON contribucion.hash = commit.hash 
JOIN (SELECT usuario.usuario
FROM usuario
JOIN repositorio ON repositorio.usuario = usuario.usuario
GROUP BY usuario.usuario
HAVING COUNT(repositorio) < 3) AS us_menos_3_repos
ON us_menos_3_repos.usuario = contribucion.usuario
JOIN (SELECT usuario
FROM usuario
WHERE cantidad_pull_request > 6) AS us_mas_6_pull
ON us_mas_6_pull.usuario = contribucion.usuario
GROUP BY archivo.id
ORDER BY COUNT(contribucion) DESC
LIMIT(3);




-- 10 --
/* Obtener de los repositorios 'family friendly', el repo y cantidad de contribuidores por edad:
   Aquellos en los que la edad de TODOS los usuarios contribuyentes es < 21:
*/
SELECT nombre_repositorio, usuario_repositorio, COUNT(contribuidores_menores) AS cantidad_menores 
FROM(
SELECT archivo.nombre_repositorio, archivo.usuario_repositorio, COUNT(contribucion.usuario) 
    AS contribuidores_menores
FROM contribucion
JOIN usuario ON contribucion.usuario = usuario.usuario
JOIN commit ON contribucion.hash = commit.hash
JOIN archivo ON commit.id_archivo = archivo.id
WHERE DATE_PART('year', AGE(usuario.fecha_nacimiento)) < 21
GROUP BY archivo.nombre_repositorio, archivo.usuario_repositorio) AS subc_contribuidores
GROUP BY nombre_repositorio, usuario_repositorio;




-- 11. Obtener los más activos -> Usuarios que realizaron más commits que el promedio, ordenados
    -- ASC por nyAp y ciudad, y DESC por la cantidad de commits:
CREATE VIEW commits AS 
SELECT usuario.usuario, COUNT(commit) AS cant_commit
FROM usuario
JOIN contribucion ON contribucion.usuario = usuario.usuario
JOIN commit ON commit.hash = contribucion.hash
GROUP BY usuario.usuario;

CREATE VIEW avg_commits AS 
SELECT AVG(cant_commit)
FROM commits;

SELECT commits.usuario, commits.cant_commit
FROM commits
CROSS JOIN avg_commits
JOIN usuario ON usuario.usuario = commits.usuario
WHERE commits.cant_commit > avg_commits.avg
ORDER BY nyap ASC, ciudad ASC, cant_commit DESC;




-- 12. Obtener de cada repositorio su contribuidor insignia:
    -- Aquel que más cambios realizó durante sus distintas contribuciones.
-- En esta primera solución funcional, el contribuidor insignia es el que más CONTRIBUCIONes realizó:
SELECT r1.nombre, r1.usuario, COALESCE(contribucion.usuario, 'Sin contribuciones') AS contribuidor_insignia
FROM repositorio r1
LEFT JOIN archivo ON r1.nombre = archivo.nombre_repositorio
                    AND r1.usuario = archivo.usuario_repositorio
LEFT JOIN commit ON archivo.id = commit.id_archivo
LEFT JOIN contribucion ON commit.hash = contribucion.hash
GROUP BY r1.nombre, r1.usuario, contribucion.usuario
HAVING COUNT(contribucion.usuario) = (SELECT COUNT(usuario)
                            FROM contribucion
                            JOIN commit ON contribucion.hash = commit.hash
                            JOIN archivo ON commit.id_archivo = archivo.id 
                            WHERE archivo.nombre_repositorio = r1.nombre AND
                                  archivo.usuario_repositorio = r1.usuario);
-- No pudimos aplicar que cuente los cambios.




-- 13. Alta demanda de commits por archivo y fecha de cambio. Aplicar una estrategia para compensarla:
CREATE INDEX commit_archivo_fcambio
ON commit (id_archivo, fecha_cambio);




-- 14. View de usuarios:
    -- cuyo promedio histórico de contribuciones en repositorios de Quilmes sea > 5,
    -- hayan commiteado al menos 5 veces en al menos 3 repos diferentes,
    -- tengan menos de 3 repositorios con +100 favoritos y -20 pull request,
    -- y nacieron en la década de los 90:
CREATE VIEW usuarios_historicos AS
SELECT u1.usuario
FROM usuario u1
JOIN contribucion ON u1.usuario = contribucion.usuario
JOIN commit ON contribucion.hash = commit.hash
JOIN archivo ON commit.id_archivo = archivo.id
GROUP BY u1.usuario, archivo.nombre_repositorio, archivo.usuario_repositorio
HAVING 5 < (SELECT AVG(contribuciones) AS promedio
            FROM(
              SELECT COUNT(contribucion.hash) AS contribuciones
              FROM contribucion
              JOIN usuario u2 ON contribucion.usuario = u2.usuario
              WHERE u2.ciudad = 'Quilmes') AS subc_contribuciones)

INTERSECT

SELECT u3.usuario 
FROM usuario u3 
JOIN contribucion ON u3.usuario = contribucion.usuario
JOIN commit ON contribucion.hash = commit.hash
JOIN archivo ON commit.id_archivo = archivo.id
GROUP BY u3.usuario, archivo.nombre_repositorio, archivo.usuario_repositorio
HAVING 3 <= COUNT(DISTINCT archivo.nombre_repositorio) -- Contemplo 3 repos diferentes en los que commiteó
        AND 5 <= COUNT(u3.usuario) -- Si tiene más de 5 contribuciones el mismo usuario

INTERSECT 

SELECT u4.usuario 
FROM usuario u4
JOIN repositorio ON u4.usuario = repositorio.usuario
WHERE 3 >= (SELECT COUNT(*)
            FROM usuario 
            JOIN repositorio ON usuario.usuario = repositorio.usuario
            WHERE repositorio.usuario = u4.usuario AND
            repositorio.cantidad_favoritos > 100 AND repositorio.cantidad_pull_request < 20)

INTERSECT 

SELECT u5.usuario 
FROM usuario u5
WHERE u5.fecha_nacimiento >= '01-01-1990' AND u5.fecha_nacimiento <= '12-12-1999';




-- 15. Estrategia para resolver requerimiento de que la combinación de correo y ciudad sea única:
ALTER TABLE usuario
ADD CONSTRAINT correo_ciudad_unicos
UNIQUE (correo, ciudad);

