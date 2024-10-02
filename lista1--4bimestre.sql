-- 1. Exibir lista de alunos e seus cursos
CREATE VIEW alunos_cursos AS
SELECT a.nome AS aluno_nome, d.nome AS disciplina_nome, c.nome AS curso_nome
FROM alunos a
INNER JOIN matriculas m ON a.id = m.aluno_id
INNER JOIN disciplinas d ON m.disciplina_id = d.id
INNER JOIN cursos c ON d.curso_id = c.id;

-- 2. Exibir total de alunos por disciplina
CREATE VIEW total_alunos_disciplina AS
SELECT d.nome AS disciplina_nome, COUNT(m.aluno_id) AS total_alunos
FROM disciplinas d
LEFT JOIN matriculas m ON d.id = m.disciplina_id
GROUP BY d.nome;

-- 3. Exibir alunos e status das suas matrículas
CREATE VIEW alunos_status_matricula AS
SELECT a.nome AS aluno_nome, d.nome AS disciplina_nome, m.status AS matricula_status
FROM alunos a
INNER JOIN matriculas m ON a.id = m.aluno_id
INNER JOIN disciplinas d ON m.disciplina_id = d.id;

-- 4. Exibir professores e suas turmas
CREATE VIEW professores_turmas AS
SELECT p.nome AS professor_nome, d.nome AS disciplina_nome, t.horario AS turma_horario
FROM professores p
INNER JOIN disciplinas d ON p.id = d.professor_id
INNER JOIN turmas t ON d.id = t.disciplina_id;

-- 5. Exibir alunos maiores de 20 anos
CREATE VIEW alunos_maiores_20 AS
SELECT a.nome AS aluno_nome, a.data_nascimento
FROM alunos a
WHERE DATE_PART('year', age(a.data_nascimento)) > 20;

-- 6. Exibir disciplinas e carga horária total por curso
CREATE VIEW carga_horaria_cursos AS
SELECT c.nome AS curso_nome, COUNT(d.id) AS total_disciplinas, SUM(d.carga_horaria) AS carga_horaria_total
FROM cursos c
INNER JOIN disciplinas d ON c.id = d.curso_id
GROUP BY c.nome;

-- 7. Exibir professores e suas especialidades
CREATE VIEW professores_especialidades AS
SELECT p.nome AS professor_nome, p.especialidade
FROM professores p;

-- 8. Exibir alunos matriculados em mais de uma disciplina
CREATE VIEW alunos_multidisciplinas AS
SELECT a.nome AS aluno_nome
FROM alunos a
INNER JOIN matriculas m ON a.id = m.aluno_id
GROUP BY a.id
HAVING COUNT(m.disciplina_id) > 1;

-- 9. Exibir alunos e o número de disciplinas que concluíram
CREATE VIEW alunos_disciplinas_concluidas AS
SELECT a.nome AS aluno_nome, COUNT(m.disciplina_id) AS disciplinas_concluidas
FROM alunos a
INNER JOIN matriculas m ON a.id = m.aluno_id
WHERE m.status = 'Concluído'
GROUP BY a.id;

-- 10. Exibir todas as turmas de um semestre específico
CREATE VIEW turmas_semestre AS
SELECT t.*
FROM turmas t
WHERE t.semestre = '2024.1';

-- 11. Exibir alunos com matrículas trancadas
CREATE VIEW alunos_matriculas_trancadas AS
SELECT a.nome AS aluno_nome
FROM alunos a
INNER JOIN matriculas m ON a.id = m.aluno_id
WHERE m.status = 'Trancado';

-- 12. Exibir disciplinas que não têm alunos matriculados
CREATE VIEW disciplinas_sem_alunos AS
SELECT d.nome AS disciplina_nome
FROM disciplinas d
LEFT JOIN matriculas m ON d.id = m.disciplina_id
WHERE m.aluno_id IS NULL;

-- 13. Exibir a quantidade de alunos por status de matrícula
CREATE VIEW total_alunos_por_status AS
SELECT m.status AS matricula_status, COUNT(m.aluno_id) AS total_alunos
FROM matriculas m
GROUP BY m.status;

-- 14. Exibir o total de professores por especialidade
CREATE VIEW total_professores_por_especialidade AS
SELECT p.especialidade, COUNT(p.id) AS total_professores
FROM professores p
GROUP BY p.especialidade;

-- 15. Exibir lista de alunos e suas idades
CREATE VIEW alunos_idades AS
SELECT a.nome AS aluno_nome, DATE_PART('year', age(a.data_nascimento)) AS idade
FROM alunos a;

-- 16. Exibir alunos e suas últimas matrículas
CREATE VIEW alunos_ultimas_matriculas AS
SELECT a.nome AS aluno_nome, MAX(m.data_matricula) AS ultima_matricula
FROM alunos a
INNER JOIN matriculas m ON a.id = m.aluno_id
GROUP BY a.id;

-- 17. Exibir todas as disciplinas de um curso específico
CREATE VIEW disciplinas_curso_especifico AS
SELECT d.*
FROM disciplinas d
INNER JOIN cursos c ON d.curso_id = c.id
WHERE c.nome = 'Engenharia de Software';

-- 18. Exibir os professores que não têm turmas
CREATE VIEW professores_sem_turmas AS
SELECT p.nome AS professor_nome
FROM professores p
LEFT JOIN disciplinas d ON p.id = d.professor_id
LEFT JOIN turmas t ON d.id = t.disciplina_id
WHERE t.id IS NULL;

-- 19. Exibir lista de alunos com CPF e email
CREATE VIEW alunos_cpf_email AS
SELECT a.nome AS aluno_nome, a.cpf, a.email
FROM alunos a;

-- 20. Exibir o total de disciplinas por professor
CREATE VIEW total_disciplinas_por_professor AS
SELECT p.nome AS professor_nome, COUNT(d.id) AS total_disciplinas
FROM professores p
INNER JOIN disciplinas d ON p.id = d.professor_id
GROUP BY p.id;
