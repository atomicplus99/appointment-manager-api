CREATE TABLE users (
    id              UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    business_id     UUID REFERENCES businesses(id),
    name            VARCHAR(255) NOT NULL,
    email           VARCHAR(255) UNIQUE NOT NULL,
    password_hash   VARCHAR(255) NOT NULL,
    phone           VARCHAR(30),
    role            VARCHAR(30) NOT NULL,
    no_show_count   INT DEFAULT 0,
    flagged         BOOLEAN DEFAULT FALSE,
    active          BOOLEAN DEFAULT TRUE,
    created_at      TIMESTAMPTZ DEFAULT now()
);

CREATE INDEX idx_users_business_id ON users(business_id);
CREATE INDEX idx_users_email ON users(email);
