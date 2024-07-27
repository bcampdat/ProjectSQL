-- 1. Calificación promedio que da cada profesor:
SELECT p.nombre_profesor, AVG(ca.nota) AS calificacion_promedio
FROM calificaciones ca
JOIN cursos cu ON ca.curso_id = cu.` id_curso`
JOIN profesores p ON cu.profesor_id = p.` id_profesor`
GROUP BY p.nombre_profesor;

-- 2. Mejores calificaciones de cada estudiante:
SELECT e.nombre_estudiante, MAX(ca.nota) AS mejor_calificacion
FROM calificaciones ca
JOIN estudiantes e ON ca.estudiante_id = e.id_estudiantes
GROUP BY e.nombre_estudiante;


-- 3. Ordenar a los estudiantes por los cursos en los que están matriculados:
SELECT e.nombre_estudiante, cu.nombre_curso
FROM calificaciones ca
JOIN estudiantes e ON ca.estudiante_id = e.id_estudiantes
JOIN cursos cu ON ca.curso_id = cu.` id_curso`
ORDER BY e.nombre_estudiante, cu.nombre_curso;


-- 4. Informe resumen de los cursos y sus calificaciones promedio:
SELECT cu.nombre_curso, AVG(ca.nota) AS calificacion_promedio
FROM calificaciones ca
JOIN cursos cu ON ca.curso_id = cu.` id_curso`
GROUP BY cu.nombre_curso
ORDER BY calificacion_promedio ASC;


-- 5. Estudiante y profesor con más cursos en común:
SELECT e.nombre_estudiante, p.nombre_profesor, COUNT(*) AS cursos_comunes
FROM calificaciones ca
JOIN estudiantes e ON ca.estudiante_id = e.id_estudiantes
JOIN cursos cu ON ca.curso_id = cu.` id_curso`
JOIN profesores p ON cu.profesor_id = p.` id_profesor`
GROUP BY e.nombre_estudiante, p.nombre_profesor
ORDER BY cursos_comunes DESC
LIMIT 1;
