CREATE TABLE waitlist (
    id             UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    business_id    UUID NOT NULL REFERENCES businesses(id),
    client_id      UUID NOT NULL REFERENCES users(id),
    service_id     UUID REFERENCES services(id),
    staff_id       UUID REFERENCES staff(id),
    preferred_date DATE NOT NULL,
    notified_at    TIMESTAMPTZ,
    status         VARCHAR(20) NOT NULL DEFAULT 'WAITING',
    created_at     TIMESTAMPTZ DEFAULT now(),
    CONSTRAINT chk_waitlist_status CHECK (
        status IN ('WAITING', 'NOTIFIED', 'BOOKED', 'EXPIRED')
    )
);

CREATE INDEX idx_waitlist_business_id ON waitlist(business_id);
CREATE INDEX idx_waitlist_client_id ON waitlist(client_id);
CREATE INDEX idx_waitlist_status ON waitlist(status, preferred_date);
