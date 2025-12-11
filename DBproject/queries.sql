-- 1. Показать все активные турниры
SELECT 
    tournament_id,
    tournament_name,
    start_date,
    end_date,
    status,
    max_participants
FROM tournaments
WHERE status IN ('ongoing', 'planned')
ORDER BY start_date;

-- 2. Показать матчи турнира с участниками
SELECT 
    r.round_number AS "Раунд",
    r.round_name AS "Название раунда",
    m.match_number AS "Матч",
    p1.participant_name AS "Участник 1",
    p2.participant_name AS "Участник 2",
    pw.participant_name AS "Победитель",
    m.status AS "Статус",
    m.match_date AS "Дата"
FROM matches m
JOIN rounds r ON m.round_id = r.round_id
LEFT JOIN participants p1 ON m.participant1_id = p1.participant_id
LEFT JOIN participants p2 ON m.participant2_id = p2.participant_id
LEFT JOIN participants pw ON m.winner_id = pw.participant_id
WHERE m.tournament_id = 1
ORDER BY r.round_number, m.match_number;

-- 3. Показать все завершенные матчи
SELECT 
    t.tournament_name AS "Турнир",
    r.round_number AS "Раунд",
    r.round_name AS "Название раунда",
    m.match_number AS "Матч",
    p1.participant_name AS "Участник 1",
    p2.participant_name AS "Участник 2",
    pw.participant_name AS "Победитель",
    m.match_date AS "Дата"
FROM matches m
JOIN tournaments t ON m.tournament_id = t.tournament_id
JOIN rounds r ON m.round_id = r.round_id
LEFT JOIN participants p1 ON m.participant1_id = p1.participant_id
LEFT JOIN participants p2 ON m.participant2_id = p2.participant_id
LEFT JOIN participants pw ON m.winner_id = pw.participant_id
WHERE m.status = 'completed'
ORDER BY m.match_date DESC;

-- 4. Показать результаты матчей
SELECT 
    m.match_id,
    p1.participant_name AS "Участник 1",
    mr1.score AS "Счет 1",
    p2.participant_name AS "Участник 2",
    mr2.score AS "Счет 2"
FROM matches m
JOIN participants p1 ON m.participant1_id = p1.participant_id
JOIN participants p2 ON m.participant2_id = p2.participant_id
JOIN match_results mr1 ON m.match_id = mr1.match_id AND mr1.participant_id = m.participant1_id
JOIN match_results mr2 ON m.match_id = mr2.match_id AND mr2.participant_id = m.participant2_id
WHERE m.status = 'completed'
ORDER BY m.match_date DESC;

-- 5. Статистика по турнирам
SELECT 
    t.tournament_name AS "Турнир",
    t.status AS "Статус",
    t.start_date AS "Начало",
    t.end_date AS "Окончание",
    COUNT(m.match_id) AS "Всего матчей",
    COUNT(CASE WHEN m.status = 'completed' THEN 1 END) AS "Завершено",
    COUNT(CASE WHEN m.status = 'scheduled' THEN 1 END) AS "Запланировано"
FROM tournaments t
LEFT JOIN matches m ON t.tournament_id = m.tournament_id
GROUP BY t.tournament_id, t.tournament_name, t.status, t.start_date, t.end_date
ORDER BY t.start_date DESC;

-- 6. Показать всех участников
SELECT 
    participant_id,
    participant_name AS "Участник",
    participant_type AS "Тип",
    email,
    phone
FROM participants
ORDER BY participant_name;

-- 7. Показать матчи участника
SELECT 
    p.participant_name AS "Участник",
    t.tournament_name AS "Турнир",
    r.round_number AS "Раунд",
    m.match_number AS "Матч",
    m.status AS "Статус"
FROM participants p
JOIN matches m ON (m.participant1_id = p.participant_id OR m.participant2_id = p.participant_id)
JOIN tournaments t ON m.tournament_id = t.tournament_id
JOIN rounds r ON m.round_id = r.round_id
WHERE p.participant_id = 1
ORDER BY m.match_date;

-- 8. Показать победителей матчей
SELECT 
    m.match_id,
    p.participant_name AS "Победитель",
    t.tournament_name AS "Турнир",
    r.round_number AS "Раунд"
FROM matches m
JOIN participants p ON m.winner_id = p.participant_id
JOIN tournaments t ON m.tournament_id = t.tournament_id
JOIN rounds r ON m.round_id = r.round_id
WHERE m.status = 'completed'
ORDER BY m.match_date DESC;

-- 9. Матчи, запланированные на ближайшие дни
SELECT 
    t.tournament_name AS "Турнир",
    r.round_number AS "Раунд",
    m.match_number AS "Матч",
    p1.participant_name AS "Участник 1",
    p2.participant_name AS "Участник 2",
    m.match_date AS "Дата и время"
FROM matches m
JOIN tournaments t ON m.tournament_id = t.tournament_id
JOIN rounds r ON m.round_id = r.round_id
LEFT JOIN participants p1 ON m.participant1_id = p1.participant_id
LEFT JOIN participants p2 ON m.participant2_id = p2.participant_id
WHERE m.status = 'scheduled'
  AND m.match_date >= CURRENT_DATE
  AND m.match_date <= CURRENT_DATE + INTERVAL '7 days'
ORDER BY m.match_date;

-- 10. Статистика конкретного турнира
SELECT 
    t.tournament_name AS "Турнир",
    COUNT(m.match_id) AS "Всего матчей",
    COUNT(CASE WHEN m.status = 'completed' THEN 1 END) AS "Завершено",
    COUNT(CASE WHEN m.status = 'scheduled' THEN 1 END) AS "Запланировано",
    MAX(r.round_number) AS "Текущий раунд"
FROM tournaments t
LEFT JOIN matches m ON t.tournament_id = m.tournament_id
LEFT JOIN rounds r ON m.round_id = r.round_id
WHERE t.tournament_id = 1
GROUP BY t.tournament_id, t.tournament_name;
