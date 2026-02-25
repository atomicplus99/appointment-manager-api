CREATE TABLE ratings (
    id             UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    appointment_id UUID UNIQUE NOT NULL REFERENCES appointments(id),
    client_id      UUID NOT NULL REFERENCES users(id),
    staff_id       UUID NOT NULL REFERENCES staff(id),
    score          SMALLINT NOT NULL,
    comment        TEXT,
    created_at     TIMESTAMPTZ DEFAULT now(),
    CONSTRAINT chk_rating_score CHECK (score BETWEEN 1 AND 5)
);

CREATE INDEX idx_ratings_staff_id ON ratings(staff_id);
