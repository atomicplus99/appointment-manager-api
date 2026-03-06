
-- ============================================================
-- V16: Schema improvements
-- 1.  users              — remove no_show_count, flagged
-- 2.  clients            — add business_id (multi-tenant isolation)
-- 3.  services           — add category
-- 4.  staff              — remove business_id (duplicated from users)
-- 5.  working_hours      — allow split shifts (drop day uniqueness)
-- 6.  appointments       — EXCLUDE constraint (prevent double booking)
-- 7.  waitlist           — add priority
-- 8.  status/type fields — convert VARCHAR + CHECK to PostgreSQL ENUMs
-- ============================================================

-- ==================== 1. users ====================
ALTER TABLE users DROP COLUMN no_show_count;
ALTER TABLE users DROP COLUMN flagged;

-- ==================== 2. clients: add business_id ====================
ALTER TABLE clients ADD COLUMN business_id UUID REFERENCES businesses(id);

-- Populate from appointments (primary source)
UPDATE clients
SET business_id = (
    SELECT a.business_id
    FROM appointments a
    WHERE a.client_id = clients.id
    LIMIT 1
);

-- Fallback: populate from waitlist for clients with no appointments
UPDATE clients
SET business_id = (
    SELECT w.business_id
    FROM waitlist w
    WHERE w.client_id = clients.id
    LIMIT 1
)
WHERE business_id IS NULL;

ALTER TABLE clients ALTER COLUMN business_id SET NOT NULL;
CREATE INDEX idx_clients_business_id ON clients(business_id);

-- ==================== 3. services: add category ====================
ALTER TABLE services ADD COLUMN category VARCHAR(100);

-- ==================== 4. staff: remove duplicated business_id ====================
DROP INDEX idx_staff_business_id;
ALTER TABLE staff DROP COLUMN business_id;

-- ==================== 5. working_hours: allow split shifts ====================
-- Drop the unique constraint that limited one schedule block per day.
-- Businesses may operate with split shifts (e.g. 09:00-13:00 and 15:00-20:00).
ALTER TABLE working_hours DROP CONSTRAINT working_hours_staff_id_day_of_week_key;

-- ==================== 6. waitlist: add priority ====================
ALTER TABLE waitlist ADD COLUMN priority INT NOT NULL DEFAULT 0;

-- ==================== 7. PostgreSQL ENUM types ====================
-- IMPORTANT: any index or constraint whose predicate references status must be
-- dropped before ALTER COLUMN TYPE, then recreated after. PostgreSQL cannot
-- rebuild predicates that involve a column whose type is changing.

-- Drop partial index from V8 (WHERE predicate references status)
DROP INDEX idx_appointments_staff_time;

-- Drop existing CHECK constraints (ENUMs enforce valid values at the type level)
ALTER TABLE appointments DROP CONSTRAINT chk_appointment_status;
ALTER TABLE notifications DROP CONSTRAINT chk_notification_type;
ALTER TABLE notifications DROP CONSTRAINT chk_notification_status;
ALTER TABLE waitlist      DROP CONSTRAINT chk_waitlist_status;

-- Create ENUM types
CREATE TYPE appointment_status   AS ENUM ('SCHEDULED', 'CONFIRMED', 'COMPLETED', 'CANCELLED', 'NO_SHOW', 'AUTO_CANCELLED');
CREATE TYPE notification_channel AS ENUM ('EMAIL', 'SMS', 'WHATSAPP');
CREATE TYPE notification_status  AS ENUM ('PENDING', 'SENT', 'FAILED');
CREATE TYPE waitlist_status      AS ENUM ('WAITING', 'NOTIFIED', 'BOOKED', 'EXPIRED');

-- Drop defaults before type change (PostgreSQL cannot cast string defaults automatically)
ALTER TABLE appointments  ALTER COLUMN status DROP DEFAULT;
ALTER TABLE notifications ALTER COLUMN status DROP DEFAULT;
ALTER TABLE waitlist      ALTER COLUMN status DROP DEFAULT;

-- Migrate columns to ENUM types
ALTER TABLE appointments
    ALTER COLUMN status TYPE appointment_status   USING status::appointment_status;
ALTER TABLE notifications
    ALTER COLUMN type   TYPE notification_channel USING type::notification_channel;
ALTER TABLE notifications
    ALTER COLUMN status TYPE notification_status  USING status::notification_status;
ALTER TABLE waitlist
    ALTER COLUMN status TYPE waitlist_status      USING status::waitlist_status;

-- Re-apply defaults with correct ENUM type
ALTER TABLE appointments  ALTER COLUMN status SET DEFAULT 'SCHEDULED';
ALTER TABLE notifications ALTER COLUMN status SET DEFAULT 'PENDING';
ALTER TABLE waitlist      ALTER COLUMN status SET DEFAULT 'WAITING';

-- Recreate partial index (status is now ENUM — string literals cast automatically)
CREATE INDEX idx_appointments_staff_time
    ON appointments(staff_id, start_at, end_at)
    WHERE status NOT IN ('CANCELLED', 'AUTO_CANCELLED');

-- ==================== 8. appointments: prevent double booking ====================
CREATE EXTENSION IF NOT EXISTS btree_gist;

ALTER TABLE appointments
    ADD CONSTRAINT no_overlapping_appointments
    EXCLUDE USING GIST (
        staff_id WITH =,
        tstzrange(start_at, end_at, '[)') WITH &&
    ) WHERE (status NOT IN ('CANCELLED', 'NO_SHOW', 'AUTO_CANCELLED'));
