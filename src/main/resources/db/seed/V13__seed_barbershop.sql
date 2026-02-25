-- ============================================================
-- Seed data: Classic Cuts Barbershop
-- For local development and SQL query testing only.
-- Passwords hash corresponds to: password123
-- ============================================================

-- ==================== Business ====================
INSERT INTO businesses (id, name, type, timezone, phone, email, address, walk_ins_allowed, cancellation_hours, active)
VALUES (
    'b1000000-0000-0000-0000-000000000001',
    'Classic Cuts Barbershop',
    'BARBERSHOP',
    'America/New_York',
    '+1-555-123-4567',
    'info@classiccuts.com',
    '123 Main Street, New York, NY 10001',
    TRUE,
    2,
    TRUE
);

-- ==================== Users ====================

-- Owner
INSERT INTO users (id, business_id, name, email, password_hash, phone, role, no_show_count, flagged, active)
VALUES (
    'u1000000-0000-0000-0000-000000000001',
    'b1000000-0000-0000-0000-000000000001',
    'Marcus Johnson',
    'marcus@classiccuts.com',
    '$2a$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi',
    '+1-555-100-0001',
    'OWNER',
    0, FALSE, TRUE
);

-- Staff users (barbers)
INSERT INTO users (id, business_id, name, email, password_hash, phone, role, no_show_count, flagged, active)
VALUES
    ('u1000000-0000-0000-0000-000000000002', 'b1000000-0000-0000-0000-000000000001', 'Derek Williams',  'derek@classiccuts.com',  '$2a$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', '+1-555-100-0002', 'STAFF', 0, FALSE, TRUE),
    ('u1000000-0000-0000-0000-000000000003', 'b1000000-0000-0000-0000-000000000001', 'Carlos Rivera',   'carlos@classiccuts.com', '$2a$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', '+1-555-100-0003', 'STAFF', 0, FALSE, TRUE),
    ('u1000000-0000-0000-0000-000000000004', 'b1000000-0000-0000-0000-000000000001', 'James Thompson',  'james@classiccuts.com',  '$2a$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', '+1-555-100-0004', 'STAFF', 0, FALSE, TRUE);

-- Clients (not linked to any business)
INSERT INTO users (id, business_id, name, email, password_hash, phone, role, no_show_count, flagged, active)
VALUES
    ('u1000000-0000-0000-0000-000000000005', NULL, 'Ethan Brown',    'ethan.brown@gmail.com',    '$2a$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', '+1-555-200-0001', 'CLIENT', 0, FALSE, TRUE),
    ('u1000000-0000-0000-0000-000000000006', NULL, 'Noah Martinez',  'noah.martinez@gmail.com',  '$2a$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', '+1-555-200-0002', 'CLIENT', 1, FALSE, TRUE),
    ('u1000000-0000-0000-0000-000000000007', NULL, 'Liam Davis',     'liam.davis@gmail.com',     '$2a$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', '+1-555-200-0003', 'CLIENT', 0, FALSE, TRUE),
    ('u1000000-0000-0000-0000-000000000008', NULL, 'Oliver Wilson',  'oliver.wilson@gmail.com',  '$2a$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', '+1-555-200-0004', 'CLIENT', 2, TRUE,  TRUE),
    ('u1000000-0000-0000-0000-000000000009', NULL, 'William Garcia', 'william.garcia@gmail.com', '$2a$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', '+1-555-200-0005', 'CLIENT', 0, FALSE, TRUE);

-- ==================== Services ====================
INSERT INTO services (id, business_id, name, description, duration_minutes, buffer_minutes, price, active)
VALUES
    ('s1000000-0000-0000-0000-000000000001', 'b1000000-0000-0000-0000-000000000001', 'Classic Haircut',       'Traditional scissors cut with styling',            30, 5,  25.00, TRUE),
    ('s1000000-0000-0000-0000-000000000002', 'b1000000-0000-0000-0000-000000000001', 'Fade Haircut',          'Skin or low fade with precision detailing',        45, 5,  35.00, TRUE),
    ('s1000000-0000-0000-0000-000000000003', 'b1000000-0000-0000-0000-000000000001', 'Beard Trim',            'Shape and trim with straight razor finish',        20, 5,  15.00, TRUE),
    ('s1000000-0000-0000-0000-000000000004', 'b1000000-0000-0000-0000-000000000001', 'Hot Towel Shave',       'Classic hot towel straight razor shave',           30, 10, 30.00, TRUE),
    ('s1000000-0000-0000-0000-000000000005', 'b1000000-0000-0000-0000-000000000001', 'Kids Haircut',          'Haircut for children 12 and under',                20, 5,  20.00, TRUE),
    ('s1000000-0000-0000-0000-000000000006', 'b1000000-0000-0000-0000-000000000001', 'Haircut + Beard Combo', 'Full haircut combined with beard trim and styling', 60, 10, 45.00, TRUE);

-- ==================== Staff ====================
INSERT INTO staff (id, user_id, business_id, bio, active)
VALUES
    ('st000000-0000-0000-0000-000000000001', 'u1000000-0000-0000-0000-000000000002', 'b1000000-0000-0000-0000-000000000001', 'Senior barber with 10 years of experience. Specialist in fades and classic cuts.', TRUE),
    ('st000000-0000-0000-0000-000000000002', 'u1000000-0000-0000-0000-000000000003', 'b1000000-0000-0000-0000-000000000001', 'Expert in beard grooming and hot towel shaves. 7 years in the trade.',             TRUE),
    ('st000000-0000-0000-0000-000000000003', 'u1000000-0000-0000-0000-000000000004', 'b1000000-0000-0000-0000-000000000001', 'Specializes in kids cuts and classic styles. Known for patience and precision.',    TRUE);

-- ==================== Staff Services ====================

-- Derek: Classic Haircut, Fade, Beard Trim, Combo
INSERT INTO staff_services (staff_id, service_id) VALUES
    ('st000000-0000-0000-0000-000000000001', 's1000000-0000-0000-0000-000000000001'),
    ('st000000-0000-0000-0000-000000000001', 's1000000-0000-0000-0000-000000000002'),
    ('st000000-0000-0000-0000-000000000001', 's1000000-0000-0000-0000-000000000003'),
    ('st000000-0000-0000-0000-000000000001', 's1000000-0000-0000-0000-000000000006');

-- Carlos: Beard Trim, Hot Towel Shave, Combo
INSERT INTO staff_services (staff_id, service_id) VALUES
    ('st000000-0000-0000-0000-000000000002', 's1000000-0000-0000-0000-000000000003'),
    ('st000000-0000-0000-0000-000000000002', 's1000000-0000-0000-0000-000000000004'),
    ('st000000-0000-0000-0000-000000000002', 's1000000-0000-0000-0000-000000000006');

-- James: Classic Haircut, Kids Haircut, Fade
INSERT INTO staff_services (staff_id, service_id) VALUES
    ('st000000-0000-0000-0000-000000000003', 's1000000-0000-0000-0000-000000000001'),
    ('st000000-0000-0000-0000-000000000003', 's1000000-0000-0000-0000-000000000002'),
    ('st000000-0000-0000-0000-000000000003', 's1000000-0000-0000-0000-000000000005');

-- ==================== Working Hours ====================
-- day_of_week: 0=Sunday, 1=Monday, 2=Tuesday, 3=Wednesday, 4=Thursday, 5=Friday, 6=Saturday

-- Derek: Monday–Saturday
INSERT INTO working_hours (staff_id, day_of_week, start_time, end_time, active) VALUES
    ('st000000-0000-0000-0000-000000000001', 1, '09:00', '18:00', TRUE),
    ('st000000-0000-0000-0000-000000000001', 2, '09:00', '18:00', TRUE),
    ('st000000-0000-0000-0000-000000000001', 3, '09:00', '18:00', TRUE),
    ('st000000-0000-0000-0000-000000000001', 4, '09:00', '18:00', TRUE),
    ('st000000-0000-0000-0000-000000000001', 5, '09:00', '18:00', TRUE),
    ('st000000-0000-0000-0000-000000000001', 6, '09:00', '17:00', TRUE);

-- Carlos: Tuesday–Saturday
INSERT INTO working_hours (staff_id, day_of_week, start_time, end_time, active) VALUES
    ('st000000-0000-0000-0000-000000000002', 2, '10:00', '19:00', TRUE),
    ('st000000-0000-0000-0000-000000000002', 3, '10:00', '19:00', TRUE),
    ('st000000-0000-0000-0000-000000000002', 4, '10:00', '19:00', TRUE),
    ('st000000-0000-0000-0000-000000000002', 5, '10:00', '19:00', TRUE),
    ('st000000-0000-0000-0000-000000000002', 6, '10:00', '17:00', TRUE);

-- James: Monday–Friday
INSERT INTO working_hours (staff_id, day_of_week, start_time, end_time, active) VALUES
    ('st000000-0000-0000-0000-000000000003', 1, '08:00', '17:00', TRUE),
    ('st000000-0000-0000-0000-000000000003', 2, '08:00', '17:00', TRUE),
    ('st000000-0000-0000-0000-000000000003', 3, '08:00', '17:00', TRUE),
    ('st000000-0000-0000-0000-000000000003', 4, '08:00', '17:00', TRUE),
    ('st000000-0000-0000-0000-000000000003', 5, '08:00', '17:00', TRUE);

-- ==================== Staff Unavailability ====================
INSERT INTO staff_unavailability (id, staff_id, start_at, end_at, reason)
VALUES
    ('su000000-0000-0000-0000-000000000001', 'st000000-0000-0000-0000-000000000001', '2026-03-10 00:00:00+00', '2026-03-12 23:59:59+00', 'Vacation'),
    ('su000000-0000-0000-0000-000000000002', 'st000000-0000-0000-0000-000000000002', '2026-02-28 00:00:00+00', '2026-02-28 23:59:59+00', 'Personal day'),
    ('su000000-0000-0000-0000-000000000003', 'st000000-0000-0000-0000-000000000003', '2026-03-05 00:00:00+00', '2026-03-06 23:59:59+00', 'Medical appointment');

-- ==================== Appointments ====================
-- Past appointments
INSERT INTO appointments (id, business_id, client_id, staff_id, service_id, start_at, end_at, status, preferred_staff, notes, confirmation_token, confirmed_at, cancelled_at, cancel_reason, created_at, updated_at)
VALUES
    -- COMPLETED: Ethan → Derek, Fade Haircut
    ('ap000000-0000-0000-0000-000000000001',
     'b1000000-0000-0000-0000-000000000001', 'u1000000-0000-0000-0000-000000000005', 'st000000-0000-0000-0000-000000000001', 's1000000-0000-0000-0000-000000000002',
     '2026-02-10 10:00:00+00', '2026-02-10 10:50:00+00',
     'COMPLETED', TRUE, 'Regular client, prefers low fade', 'TOKEN-CC-001', '2026-02-09 20:00:00+00', NULL, NULL,
     '2026-02-09 19:00:00+00', '2026-02-10 10:50:00+00'),

    -- COMPLETED: Noah → Carlos, Hot Towel Shave
    ('ap000000-0000-0000-0000-000000000002',
     'b1000000-0000-0000-0000-000000000001', 'u1000000-0000-0000-0000-000000000006', 'st000000-0000-0000-0000-000000000002', 's1000000-0000-0000-0000-000000000004',
     '2026-02-10 11:00:00+00', '2026-02-10 11:40:00+00',
     'COMPLETED', FALSE, NULL, 'TOKEN-CC-002', '2026-02-09 21:00:00+00', NULL, NULL,
     '2026-02-09 20:00:00+00', '2026-02-10 11:40:00+00'),

    -- COMPLETED: Liam → James, Kids Haircut
    ('ap000000-0000-0000-0000-000000000003',
     'b1000000-0000-0000-0000-000000000001', 'u1000000-0000-0000-0000-000000000007', 'st000000-0000-0000-0000-000000000003', 's1000000-0000-0000-0000-000000000005',
     '2026-02-12 09:00:00+00', '2026-02-12 09:25:00+00',
     'COMPLETED', FALSE, 'Short on the sides', 'TOKEN-CC-003', '2026-02-11 18:00:00+00', NULL, NULL,
     '2026-02-11 17:00:00+00', '2026-02-12 09:25:00+00'),

    -- NO_SHOW: Oliver → Derek, Haircut + Beard Combo
    ('ap000000-0000-0000-0000-000000000004',
     'b1000000-0000-0000-0000-000000000001', 'u1000000-0000-0000-0000-000000000008', 'st000000-0000-0000-0000-000000000001', 's1000000-0000-0000-0000-000000000006',
     '2026-02-14 14:00:00+00', '2026-02-14 15:10:00+00',
     'NO_SHOW', TRUE, NULL, 'TOKEN-CC-004', NULL, NULL, NULL,
     '2026-02-13 14:00:00+00', '2026-02-14 15:10:00+00'),

    -- COMPLETED: William → Carlos, Beard Trim
    ('ap000000-0000-0000-0000-000000000005',
     'b1000000-0000-0000-0000-000000000001', 'u1000000-0000-0000-0000-000000000009', 'st000000-0000-0000-0000-000000000002', 's1000000-0000-0000-0000-000000000003',
     '2026-02-17 15:00:00+00', '2026-02-17 15:25:00+00',
     'COMPLETED', FALSE, NULL, 'TOKEN-CC-005', '2026-02-16 12:00:00+00', NULL, NULL,
     '2026-02-16 11:00:00+00', '2026-02-17 15:25:00+00'),

    -- CANCELLED: Ethan → James, Classic Haircut
    ('ap000000-0000-0000-0000-000000000006',
     'b1000000-0000-0000-0000-000000000001', 'u1000000-0000-0000-0000-000000000005', 'st000000-0000-0000-0000-000000000003', 's1000000-0000-0000-0000-000000000001',
     '2026-02-18 10:00:00+00', '2026-02-18 10:35:00+00',
     'CANCELLED', FALSE, NULL, 'TOKEN-CC-006', NULL, '2026-02-17 18:00:00+00', 'Client cancelled via phone',
     '2026-02-17 09:00:00+00', '2026-02-17 18:00:00+00'),

    -- COMPLETED: Noah → Derek, Fade Haircut
    ('ap000000-0000-0000-0000-000000000007',
     'b1000000-0000-0000-0000-000000000001', 'u1000000-0000-0000-0000-000000000006', 'st000000-0000-0000-0000-000000000001', 's1000000-0000-0000-0000-000000000002',
     '2026-02-20 11:00:00+00', '2026-02-20 11:50:00+00',
     'COMPLETED', TRUE, 'Skin fade this time', 'TOKEN-CC-007', '2026-02-19 19:00:00+00', NULL, NULL,
     '2026-02-19 18:00:00+00', '2026-02-20 11:50:00+00'),

    -- Upcoming appointments
    -- CONFIRMED: Liam → Derek, Fade Haircut (tomorrow)
    ('ap000000-0000-0000-0000-000000000008',
     'b1000000-0000-0000-0000-000000000001', 'u1000000-0000-0000-0000-000000000007', 'st000000-0000-0000-0000-000000000001', 's1000000-0000-0000-0000-000000000002',
     '2026-02-26 10:00:00+00', '2026-02-26 10:50:00+00',
     'CONFIRMED', TRUE, NULL, 'TOKEN-CC-008', '2026-02-25 08:00:00+00', NULL, NULL,
     '2026-02-24 20:00:00+00', '2026-02-25 08:00:00+00'),

    -- SCHEDULED: William → Carlos, Hot Towel Shave (tomorrow)
    ('ap000000-0000-0000-0000-000000000009',
     'b1000000-0000-0000-0000-000000000001', 'u1000000-0000-0000-0000-000000000009', 'st000000-0000-0000-0000-000000000002', 's1000000-0000-0000-0000-000000000004',
     '2026-02-26 13:00:00+00', '2026-02-26 13:40:00+00',
     'SCHEDULED', FALSE, 'First time client', 'TOKEN-CC-009', NULL, NULL, NULL,
     '2026-02-25 07:00:00+00', '2026-02-25 07:00:00+00'),

    -- SCHEDULED: Ethan → Derek, Haircut + Beard Combo
    ('ap000000-0000-0000-0000-000000000010',
     'b1000000-0000-0000-0000-000000000001', 'u1000000-0000-0000-0000-000000000005', 'st000000-0000-0000-0000-000000000001', 's1000000-0000-0000-0000-000000000006',
     '2026-03-02 09:00:00+00', '2026-03-02 10:10:00+00',
     'SCHEDULED', TRUE, 'Monthly combo', 'TOKEN-CC-010', NULL, NULL, NULL,
     '2026-02-25 06:00:00+00', '2026-02-25 06:00:00+00'),

    -- SCHEDULED: Oliver → James, Classic Haircut
    ('ap000000-0000-0000-0000-000000000011',
     'b1000000-0000-0000-0000-000000000001', 'u1000000-0000-0000-0000-000000000008', 'st000000-0000-0000-0000-000000000003', 's1000000-0000-0000-0000-000000000001',
     '2026-03-03 14:00:00+00', '2026-03-03 14:35:00+00',
     'SCHEDULED', FALSE, NULL, 'TOKEN-CC-011', NULL, NULL, NULL,
     '2026-02-25 10:00:00+00', '2026-02-25 10:00:00+00'),

    -- SCHEDULED: Noah → Carlos, Beard Trim
    ('ap000000-0000-0000-0000-000000000012',
     'b1000000-0000-0000-0000-000000000001', 'u1000000-0000-0000-0000-000000000006', 'st000000-0000-0000-0000-000000000002', 's1000000-0000-0000-0000-000000000003',
     '2026-03-04 11:00:00+00', '2026-03-04 11:25:00+00',
     'SCHEDULED', FALSE, NULL, 'TOKEN-CC-012', NULL, NULL, NULL,
     '2026-02-25 11:00:00+00', '2026-02-25 11:00:00+00');

-- ==================== Waitlist ====================
INSERT INTO waitlist (id, business_id, client_id, service_id, staff_id, preferred_date, notified_at, status, created_at)
VALUES
    -- Oliver waiting for a Fade with Derek on Feb 26
    ('wl000000-0000-0000-0000-000000000001', 'b1000000-0000-0000-0000-000000000001',
     'u1000000-0000-0000-0000-000000000008', 's1000000-0000-0000-0000-000000000002', 'st000000-0000-0000-0000-000000000001',
     '2026-02-26', NULL, 'WAITING', '2026-02-24 15:00:00+00'),

    -- Liam notified for Hot Towel Shave on Feb 27
    ('wl000000-0000-0000-0000-000000000002', 'b1000000-0000-0000-0000-000000000001',
     'u1000000-0000-0000-0000-000000000007', 's1000000-0000-0000-0000-000000000004', NULL,
     '2026-02-27', '2026-02-25 09:00:00+00', 'NOTIFIED', '2026-02-23 12:00:00+00'),

    -- William on expired waitlist for Classic Haircut
    ('wl000000-0000-0000-0000-000000000003', 'b1000000-0000-0000-0000-000000000001',
     'u1000000-0000-0000-0000-000000000009', 's1000000-0000-0000-0000-000000000001', NULL,
     '2026-02-20', NULL, 'EXPIRED', '2026-02-18 10:00:00+00');

-- ==================== Notifications ====================
INSERT INTO notifications (id, appointment_id, type, event, sent_at, status, error_message)
VALUES
    ('no000000-0000-0000-0000-000000000001', 'ap000000-0000-0000-0000-000000000001', 'EMAIL',    'APPOINTMENT_CONFIRMATION', '2026-02-09 19:01:00+00', 'SENT',    NULL),
    ('no000000-0000-0000-0000-000000000002', 'ap000000-0000-0000-0000-000000000001', 'SMS',      'APPOINTMENT_REMINDER',     '2026-02-10 08:00:00+00', 'SENT',    NULL),
    ('no000000-0000-0000-0000-000000000003', 'ap000000-0000-0000-0000-000000000002', 'EMAIL',    'APPOINTMENT_CONFIRMATION', '2026-02-09 20:01:00+00', 'SENT',    NULL),
    ('no000000-0000-0000-0000-000000000004', 'ap000000-0000-0000-0000-000000000003', 'EMAIL',    'APPOINTMENT_CONFIRMATION', '2026-02-11 17:01:00+00', 'SENT',    NULL),
    ('no000000-0000-0000-0000-000000000005', 'ap000000-0000-0000-0000-000000000004', 'EMAIL',    'APPOINTMENT_CONFIRMATION', '2026-02-13 14:01:00+00', 'SENT',    NULL),
    ('no000000-0000-0000-0000-000000000006', 'ap000000-0000-0000-0000-000000000004', 'SMS',      'APPOINTMENT_REMINDER',     '2026-02-14 08:00:00+00', 'SENT',    NULL),
    ('no000000-0000-0000-0000-000000000007', 'ap000000-0000-0000-0000-000000000004', 'EMAIL',    'NO_SHOW_ALERT',             '2026-02-14 15:15:00+00', 'SENT',    NULL),
    ('no000000-0000-0000-0000-000000000008', 'ap000000-0000-0000-0000-000000000005', 'EMAIL',    'APPOINTMENT_CONFIRMATION', '2026-02-16 11:01:00+00', 'SENT',    NULL),
    ('no000000-0000-0000-0000-000000000009', 'ap000000-0000-0000-0000-000000000006', 'EMAIL',    'APPOINTMENT_CANCELLATION', '2026-02-17 18:01:00+00', 'SENT',    NULL),
    ('no000000-0000-0000-0000-000000000010', 'ap000000-0000-0000-0000-000000000007', 'EMAIL',    'APPOINTMENT_CONFIRMATION', '2026-02-19 18:01:00+00', 'SENT',    NULL),
    ('no000000-0000-0000-0000-000000000011', 'ap000000-0000-0000-0000-000000000007', 'WHATSAPP', 'APPOINTMENT_REMINDER',     '2026-02-20 08:00:00+00', 'SENT',    NULL),
    ('no000000-0000-0000-0000-000000000012', 'ap000000-0000-0000-0000-000000000008', 'EMAIL',    'APPOINTMENT_CONFIRMATION', '2026-02-25 08:01:00+00', 'SENT',    NULL),
    ('no000000-0000-0000-0000-000000000013', 'ap000000-0000-0000-0000-000000000009', 'EMAIL',    'APPOINTMENT_CONFIRMATION', '2026-02-25 07:01:00+00', 'FAILED',  'SMTP connection timeout'),
    ('no000000-0000-0000-0000-000000000014', 'ap000000-0000-0000-0000-000000000009', 'EMAIL',    'APPOINTMENT_CONFIRMATION', NULL,                     'PENDING', NULL);

-- ==================== Notification Templates ====================
INSERT INTO notification_templates (id, business_id, channel, event, template)
VALUES
    ('nt000000-0000-0000-0000-000000000001', 'b1000000-0000-0000-0000-000000000001', 'EMAIL',    'APPOINTMENT_CONFIRMATION', 'Hi {{client_name}}, your appointment for {{service_name}} with {{staff_name}} on {{date}} at {{time}} is confirmed. See you soon! — Classic Cuts'),
    ('nt000000-0000-0000-0000-000000000002', 'b1000000-0000-0000-0000-000000000001', 'EMAIL',    'APPOINTMENT_REMINDER',     'Hi {{client_name}}, reminder: your {{service_name}} is tomorrow at {{time}} with {{staff_name}}. Reply CANCEL to cancel. — Classic Cuts'),
    ('nt000000-0000-0000-0000-000000000003', 'b1000000-0000-0000-0000-000000000001', 'EMAIL',    'APPOINTMENT_CANCELLATION', 'Hi {{client_name}}, your appointment on {{date}} at {{time}} has been cancelled. Book again at classiccuts.com — Classic Cuts'),
    ('nt000000-0000-0000-0000-000000000004', 'b1000000-0000-0000-0000-000000000001', 'EMAIL',    'NO_SHOW_ALERT',             'Hi {{client_name}}, we missed you today! Your appointment was marked as a no-show. Please contact us to reschedule. — Classic Cuts'),
    ('nt000000-0000-0000-0000-000000000005', 'b1000000-0000-0000-0000-000000000001', 'SMS',      'APPOINTMENT_CONFIRMATION', 'Classic Cuts: {{service_name}} confirmed for {{date}} at {{time}} with {{staff_name}}. Reply STOP to unsubscribe.'),
    ('nt000000-0000-0000-0000-000000000006', 'b1000000-0000-0000-0000-000000000001', 'SMS',      'APPOINTMENT_REMINDER',     'Classic Cuts: Reminder - {{service_name}} tomorrow at {{time}}. Reply CANCEL to cancel.'),
    ('nt000000-0000-0000-0000-000000000007', 'b1000000-0000-0000-0000-000000000001', 'WHATSAPP', 'APPOINTMENT_CONFIRMATION', 'Hi {{client_name}}! Your *{{service_name}}* with *{{staff_name}}* is confirmed for {{date}} at {{time}}. See you at Classic Cuts!'),
    ('nt000000-0000-0000-0000-000000000008', 'b1000000-0000-0000-0000-000000000001', 'WHATSAPP', 'APPOINTMENT_REMINDER',     'Hi {{client_name}}! Reminder: *{{service_name}}* tomorrow at {{time}} with {{staff_name}}. Reply *CANCEL* if you need to reschedule.');

-- ==================== Ratings ====================
-- Only for COMPLETED appointments: 001, 002, 003, 005, 007
INSERT INTO ratings (id, appointment_id, client_id, staff_id, score, comment, created_at)
VALUES
    ('ra000000-0000-0000-0000-000000000001', 'ap000000-0000-0000-0000-000000000001', 'u1000000-0000-0000-0000-000000000005', 'st000000-0000-0000-0000-000000000001', 5, 'Derek is the best! Perfect fade every time.',                     '2026-02-10 12:00:00+00'),
    ('ra000000-0000-0000-0000-000000000002', 'ap000000-0000-0000-0000-000000000002', 'u1000000-0000-0000-0000-000000000006', 'st000000-0000-0000-0000-000000000002', 4, 'Great shave, very relaxing experience.',                          '2026-02-10 14:00:00+00'),
    ('ra000000-0000-0000-0000-000000000003', 'ap000000-0000-0000-0000-000000000003', 'u1000000-0000-0000-0000-000000000007', 'st000000-0000-0000-0000-000000000003', 5, 'My son loved his haircut! James is so patient with kids.',        '2026-02-12 11:00:00+00'),
    ('ra000000-0000-0000-0000-000000000004', 'ap000000-0000-0000-0000-000000000005', 'u1000000-0000-0000-0000-000000000009', 'st000000-0000-0000-0000-000000000002', 3, 'Good trim but had to wait a bit longer than expected.',           '2026-02-17 16:00:00+00'),
    ('ra000000-0000-0000-0000-000000000005', 'ap000000-0000-0000-0000-000000000007', 'u1000000-0000-0000-0000-000000000006', 'st000000-0000-0000-0000-000000000001', 5, 'Amazing skin fade, exactly what I wanted!',                      '2026-02-20 13:00:00+00');
