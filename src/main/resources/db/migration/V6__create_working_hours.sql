CREATE TABLE working_hours (
    id           UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    staff_id     UUID NOT NULL REFERENCES staff(id),
    day_of_week  SMALLINT NOT NULL,
    start_time   TIME NOT NULL,
    end_time     TIME NOT NULL,
    active       BOOLEAN DEFAULT TRUE,
    CONSTRAINT chk_day_of_week CHECK (day_of_week BETWEEN 0 AND 6),
    CONSTRAINT chk_time_range CHECK (end_time > start_time),
    UNIQUE (staff_id, day_of_week)
);

CREATE INDEX idx_working_hours_staff_id ON working_hours(staff_id);
