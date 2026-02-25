CREATE TABLE staff_unavailability (
    id       UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    staff_id UUID NOT NULL REFERENCES staff(id),
    start_at TIMESTAMPTZ NOT NULL,
    end_at   TIMESTAMPTZ NOT NULL,
    reason   VARCHAR(255),
    CONSTRAINT chk_unavailability_range CHECK (end_at > start_at)
);

CREATE INDEX idx_staff_unavailability_staff_id ON staff_unavailability(staff_id);
CREATE INDEX idx_staff_unavailability_range ON staff_unavailability(staff_id, start_at, end_at);
