-- Турниры
INSERT INTO tournaments (tournament_name, start_date, end_date, status, max_participants) VALUES
('Чемпионат по футболу 2024', '2024-01-15', '2024-02-15', 'completed', 8),
('Кубок по баскетболу', '2024-03-01', NULL, 'ongoing', 16),
('Турнир по теннису', '2024-04-10', NULL, 'planned', 4),
('Киберспортивный турнир', '2024-05-01', NULL, 'planned', 32);

-- Участники
INSERT INTO participants (participant_name, participant_type, email, phone) VALUES
('Динамо', 'team', 'dynamo@example.com', '+996555111111'),
('Алга', 'team', 'alga@example.com', '+996555222222'),
('Абдыш-Ата', 'team', 'abdysh@example.com', '+996555333333'),
('Нефтчи', 'team', 'neftchi@example.com', '+996555444444'),
('Алай', 'team', 'alay@example.com', '+996555555555'),
('Илбирс', 'team', 'ilbirs@example.com', '+996555666666'),
('Алтын-Алма', 'team', 'altyn@example.com', '+996555777777'),
('Кара-Балта', 'team', 'karabalta@example.com', '+996555888888'),
('Баскет-Клуб А', 'team', 'basket_a@example.com', '+996555111222'),
('Баскет-Клуб Б', 'team', 'basket_b@example.com', '+996555222333'),
('Баскет-Клуб В', 'team', 'basket_c@example.com', '+996555333444'),
('Баскет-Клуб Г', 'team', 'basket_d@example.com', '+996555444555'),
('Баскет-Клуб Д', 'team', 'basket_e@example.com', '+996555555666'),
('Баскет-Клуб Е', 'team', 'basket_f@example.com', '+996555666777'),
('Баскет-Клуб Ж', 'team', 'basket_g@example.com', '+996555777888'),
('Баскет-Клуб З', 'team', 'basket_h@example.com', '+996555888999'),
('Баскет-Клуб И', 'team', 'basket_i@example.com', '+996555999000'),
('Баскет-Клуб К', 'team', 'basket_k@example.com', '+996555000111'),
('Баскет-Клуб Л', 'team', 'basket_l@example.com', '+996555111333'),
('Баскет-Клуб М', 'team', 'basket_m@example.com', '+996555222444'),
('Баскет-Клуб Н', 'team', 'basket_n@example.com', '+996555333555'),
('Баскет-Клуб О', 'team', 'basket_o@example.com', '+996555444666'),
('Баскет-Клуб П', 'team', 'basket_p@example.com', '+996555555777'),
('Баскет-Клуб Р', 'team', 'basket_r@example.com', '+996555666888'),
('Иван Петров', 'player', 'ivan@example.com', '+996555111000'),
('Сергей Иванов', 'player', 'sergey@example.com', '+996555222000'),
('Алексей Сидоров', 'player', 'alexey@example.com', '+996555333000'),
('Дмитрий Козлов', 'player', 'dmitry@example.com', '+996555444000');

-- Регистрация участников
INSERT INTO tournament_participants (tournament_id, participant_id, seed) VALUES
(1,1,1),(1,2,2),(1,3,3),(1,4,4),(1,5,5),(1,6,6),(1,7,7),(1,8,8),
(2,9,1),(2,10,2),(2,11,3),(2,12,4),(2,13,5),(2,14,6),(2,15,7),(2,16,8),
(2,17,9),(2,18,10),(2,19,11),(2,20,12),(2,21,13),(2,22,14),(2,23,15),(2,24,16),
(3,25,1),(3,26,2),(3,27,3),(3,28,4);

-- Раунды
INSERT INTO rounds (tournament_id, round_number, round_name) VALUES
(1,1,'Четвертьфинал'),
(1,2,'Полуфинал'),
(1,3,'Финал'),
(2,1,'Раунд 1'),
(3,1,'Полуфинал'),
(3,2,'Финал');

-- Матчи футбола
INSERT INTO matches (tournament_id, round_id, match_number, participant1_id, participant2_id, winner_id, match_date, status) VALUES
(1,1,1,1,2,1,'2024-01-20 15:00','completed'),
(1,1,2,3,4,3,'2024-01-20 17:00','completed'),
(1,1,3,5,6,5,'2024-01-21 15:00','completed'),
(1,1,4,7,8,7,'2024-01-21 17:00','completed'),
(1,2,1,1,3,1,'2024-02-05 15:00','completed'),
(1,2,2,5,7,5,'2024-02-05 17:00','completed'),
(1,3,1,1,5,1,'2024-02-15 18:00','completed');

-- Результаты футбола
INSERT INTO match_results (match_id, participant_id, score, is_winner) VALUES
(1,1,2,TRUE),(1,2,1,FALSE),
(2,3,3,TRUE),(2,4,0,FALSE),
(3,5,1,TRUE),(3,6,0,FALSE),
(4,7,2,TRUE),(4,8,1,FALSE),
(5,1,2,TRUE),(5,3,0,FALSE),
(6,5,3,TRUE),(6,7,1,FALSE),
(7,1,1,TRUE),(7,5,0,FALSE);

-- Матчи баскетбола
INSERT INTO matches (tournament_id, round_id, match_number, participant1_id, participant2_id, match_date, status) VALUES
(2,4,1,9,10,'2024-03-05 10:00','scheduled'),
(2,4,2,11,12,'2024-03-05 12:00','scheduled'),
(2,4,3,13,14,'2024-03-05 14:00','scheduled'),
(2,4,4,15,16,'2024-03-05 16:00','scheduled'),
(2,4,5,17,18,'2024-03-06 10:00','scheduled'),
(2,4,6,19,20,'2024-03-06 12:00','scheduled'),
(2,4,7,21,22,'2024-03-06 14:00','scheduled'),
(2,4,8,23,24,'2024-03-06 16:00','scheduled');

-- Матчи тенниса
INSERT INTO matches (tournament_id, round_id, match_number, participant1_id, participant2_id, match_date, status) VALUES
(3,5,1,25,26,'2024-04-15 10:00','scheduled'),
(3,5,2,27,28,'2024-04-15 12:00','scheduled'),
(3,6,1,NULL,NULL,'2024-04-20 15:00','scheduled');
