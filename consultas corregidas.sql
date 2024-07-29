-- 1. Calificación promedio que da cada profesor:
-- Para manejar casos donde un profesor no tiene cursos, utilizaremos COALESCE para devolver 0 en lugar de NULL

SELECT p.nombre_profesor, COALESCE(AVG(ca.nota), 0) AS calificacion_promedio
FROM calificaciones ca
JOIN cursos cu ON ca.curso_id = cu.` id_curso`
JOIN profesores p ON cu.profesor_id = p.` id_profesor`
GROUP BY p.nombre_profesor;


-- 2. Mejores calificaciones de cada estudiante:
-- Para manejar casos donde un estudiante no tiene calificaciones, también usaremos COALESCE.

SELECT e.nombre_estudiante, COALESCE(MAX(ca.nota), 0) AS mejor_calificacion
FROM calificaciones ca
JOIN estudiantes e ON ca.estudiante_id = e.id_estudiantes
GROUP BY e.nombre_estudiante;


-- 3. Ordenar a los estudiantes por los cursos en los que están matriculados:
-- La consulta ya está adecuada. Asegurémonos de manejar los posibles errores con NULL en los nombres de los cursos.

SELECT e.nombre_estudiante, cu.nombre_curso
FROM calificaciones ca
JOIN estudiantes e ON ca.estudiante_id = e.id_estudiantes
JOIN cursos cu ON ca.curso_id = cu.` id_curso`
ORDER BY e.nombre_estudiante, cu.nombre_curso;


-- 4. Informe resumen de los cursos y sus calificaciones promedio:
-- Utilizaremos COALESCE para asegurarnos de que los cursos sin calificaciones muestren 0 en lugar de NULL

SELECT cu.nombre_curso, COALESCE(AVG(ca.nota), 0) AS calificacion_promedio
FROM calificaciones ca
JOIN cursos cu ON ca.curso_id = cu.` id_curso`
GROUP BY cu.nombre_curso
ORDER BY calificacion_promedio ASC;


-- 5. Estudiante y profesor con más cursos en común:
-- Para manejar posibles ambigüedades y asegurar que todos los estudiantes/profesores relevantes sean considerados,
-- utilizaremos identificadores únicos y ajustaremos la consulta para manejar múltiples resultados con ORDER BY y LIMIT.

SELECT e.id_estudiantes, e.nombre_estudiante, p.`id_profesor`, p.nombre_profesor, COUNT(*) AS cursos_comunes
FROM calificaciones ca
JOIN estudiantes e ON ca.estudiante_id = e.id_estudiantes
JOIN cursos cu ON ca.curso_id = cu.`id_curso`
JOIN profesores p ON cu.profesor_id = p.`id_profesor`
GROUP BY e.id_estudiantes, e.nombre_estudiante, p.`id_profesor`, p.nombre_profesor
ORDER BY cursos_comunes DESC;