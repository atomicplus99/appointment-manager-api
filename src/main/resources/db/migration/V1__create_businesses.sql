CREATE TABLE businesses (
    id                  UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    name                VARCHAR(255) NOT NULL,
    type                VARCHAR(50),
    timezone            VARCHAR(100) NOT NULL,
    phone               VARCHAR(30),
    email               VARCHAR(255),
    address             TEXT,
    walk_ins_allowed    BOOLEAN DEFAULT FALSE,
    cancellation_hours  INT DEFAULT 2,
    active              BOOLEAN DEFAULT TRUE,
    created_at          TIMESTAMPTZ DEFAULT now(),
    updated_at          TIMESTAMPTZ DEFAULT now()
);
