CREATE TABLE appointments (
    id                  UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    business_id         UUID NOT NULL REFERENCES businesses(id),
    client_id           UUID NOT NULL REFERENCES users(id),
    staff_id            UUID NOT NULL REFERENCES staff(id),
    service_id          UUID NOT NULL REFERENCES services(id),
    start_at            TIMESTAMPTZ NOT NULL,
    end_at              TIMESTAMPTZ NOT NULL,
    status              VARCHAR(30) NOT NULL DEFAULT 'SCHEDULED',
    preferred_staff     BOOLEAN DEFAULT FALSE,
    notes               TEXT,
    metadata            JSONB,
    confirmation_token  VARCHAR(100) UNIQUE,
    confirmed_at        TIMESTAMPTZ,
    cancelled_at        TIMESTAMPTZ,
    cancel_reason       TEXT,
    created_at          TIMESTAMPTZ DEFAULT now(),
    updated_at          TIMESTAMPTZ DEFAULT now(),
    CONSTRAINT chk_appointment_range CHECK (end_at > start_at),
    CONSTRAINT chk_appointment_status CHECK (
        status IN ('SCHEDULED', 'CONFIRMED', 'COMPLETED', 'CANCELLED', 'NO_SHOW', 'AUTO_CANCELLED')
    )
);

CREATE INDEX idx_appointments_business_id ON appointments(business_id);
CREATE INDEX idx_appointments_client_id ON appointments(client_id);
CREATE INDEX idx_appointments_staff_time
    ON appointments(staff_id, start_at, end_at)
    WHERE status NOT IN ('CANCELLED', 'AUTO_CANCELLED');
