-- 1. Таблица турниров

CREATE TABLE tournaments (
    tournament_id SERIAL PRIMARY KEY,
    tournament_name VARCHAR(100) NOT NULL,
    start_date DATE NOT NULL,
    end_date DATE,
    status VARCHAR(20) DEFAULT 'planned'
        CHECK (status IN ('planned', 'ongoing', 'completed', 'cancelled')),
    max_participants INTEGER NOT NULL CHECK (max_participants > 0),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- 2. Таблица участников

CREATE TABLE participants (
    participant_id SERIAL PRIMARY KEY,
    participant_name VARCHAR(100) NOT NULL,
    participant_type VARCHAR(20) DEFAULT 'player'
        CHECK (participant_type IN ('team', 'player')),
    email VARCHAR(100),
    phone VARCHAR(20),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- 3. Участники в конкретных турнирах (регистрация)

CREATE TABLE tournament_participants (
    tournament_id INTEGER NOT NULL,
    participant_id INTEGER NOT NULL,
    seed INTEGER, -- посев участника в сетке
    status VARCHAR(20) DEFAULT 'registered'
        CHECK (status IN ('registered', 'confirmed', 'withdrawn', 'disqualified')),
    registered_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,

    PRIMARY KEY (tournament_id, participant_id),

    FOREIGN KEY (tournament_id) REFERENCES tournaments(tournament_id) ON DELETE CASCADE,
    FOREIGN KEY (participant_id) REFERENCES participants(participant_id) ON DELETE CASCADE
);

-- 4. Таблица раундов в турнирах

CREATE TABLE rounds (
    round_id SERIAL PRIMARY KEY,
    tournament_id INTEGER NOT NULL,
    round_number INTEGER NOT NULL CHECK (round_number > 0),
    round_name VARCHAR(50),   -- например: Quarterfinal, Semifinal, Final
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,

    FOREIGN KEY (tournament_id) REFERENCES tournaments(tournament_id) ON DELETE CASCADE,
    UNIQUE (tournament_id, round_number)
);

-- 5. Таблица матчей

CREATE TABLE matches (
    match_id SERIAL PRIMARY KEY,
    tournament_id INTEGER NOT NULL,
    round_id INTEGER NOT NULL,
    match_number INTEGER NOT NULL CHECK (match_number > 0),

    participant1_id INTEGER,
    participant2_id INTEGER,
    winner_id INTEGER,

    match_date TIMESTAMP,
    status VARCHAR(20) DEFAULT 'scheduled'
        CHECK (status IN ('scheduled', 'in_progress', 'completed', 'cancelled')),

    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,

    FOREIGN KEY (tournament_id) REFERENCES tournaments(tournament_id) ON DELETE CASCADE,
    FOREIGN KEY (round_id) REFERENCES rounds(round_id) ON DELETE CASCADE,
    FOREIGN KEY (participant1_id) REFERENCES participants(participant_id) ON DELETE SET NULL,
    FOREIGN KEY (participant2_id) REFERENCES participants(participant_id) ON DELETE SET NULL,
    FOREIGN KEY (winner_id) REFERENCES participants(participant_id) ON DELETE SET NULL,

    UNIQUE (round_id, match_number)
);

-- 6. Таблица результатов матчей

CREATE TABLE match_results (
    result_id SERIAL PRIMARY KEY,
    match_id INTEGER NOT NULL,
    participant_id INTEGER NOT NULL,
    score INTEGER NOT NULL DEFAULT 0,
    is_winner BOOLEAN DEFAULT FALSE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,

    FOREIGN KEY (match_id) REFERENCES matches(match_id) ON DELETE CASCADE,
    FOREIGN KEY (participant_id) REFERENCES participants(participant_id) ON DELETE CASCADE,

    UNIQUE(match_id, participant_id)
);

-- Индексы
CREATE INDEX idx_matches_tournament ON matches(tournament_id);
CREATE INDEX idx_matches_round ON matches(round_id);
CREATE INDEX idx_tournament_participants ON tournament_participants(tournament_id);
CREATE INDEX idx_match_results_match ON match_results(match_id);
CREATE INDEX idx_tournaments_status ON tournaments(status);
