-- ============================================
-- Примеры транзакций
-- ============================================

BEGIN;

INSERT INTO match_results (match_id, participant_id, score, is_winner) VALUES
(1, 1, 3, TRUE),
(1, 2, 1, FALSE);

UPDATE matches
SET winner_id = 1,
    status = 'completed'
WHERE match_id = 1;

COMMIT;

BEGIN;

INSERT INTO tournaments (tournament_name, start_date, end_date, status, max_participants)
VALUES ('Тестовый турнир', '2025-07-01', '2025-07-15', 'planned', 4);

INSERT INTO participants (participant_name, participant_type, email, phone) VALUES
('Test Team 1', 'team', 'team1@example.com', '+996555101010'),
('Test Team 2', 'team', 'team2@example.com', '+996555202020');

INSERT INTO tournament_participants (tournament_id, participant_id, seed)
SELECT 
    (SELECT tournament_id FROM tournaments WHERE tournament_name = 'Тестовый турнир' ORDER BY created_at DESC LIMIT 1),
    participant_id,
    ROW_NUMBER() OVER ()
FROM participants
WHERE participant_name LIKE 'Test Team%';

INSERT INTO rounds (tournament_id, round_number, round_name)
VALUES (
    (SELECT tournament_id FROM tournaments WHERE tournament_name='Тестовый турнир' ORDER BY created_at DESC LIMIT 1),
    0,
    'Ошибка'
);

ROLLBACK;
