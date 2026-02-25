CREATE TABLE services (
    id               UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    business_id      UUID NOT NULL REFERENCES businesses(id),
    name             VARCHAR(255) NOT NULL,
    description      TEXT,
    duration_minutes INT NOT NULL,
    buffer_minutes   INT DEFAULT 0,
    price            NUMERIC(10,2),
    active           BOOLEAN DEFAULT TRUE
);

CREATE INDEX idx_services_business_id ON services(business_id);
