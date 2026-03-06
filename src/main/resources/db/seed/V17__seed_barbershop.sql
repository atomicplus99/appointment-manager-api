-- ============================================================
-- Datos de prueba: Barbería El Maestro — Lima, Perú
-- Este seed se ejecuta DESPUÉS de todas las migraciones (V1–V16).
-- Refleja el esquema final: sin columnas eliminadas, con columnas nuevas.
-- Contraseña de todos los usuarios del sistema: password123
--
-- UUID prefijos (todos válidos en hex):
--   b1xxxxxx = businesses
--   a1xxxxxx = users (OWNER y STAFF)
--   c1xxxxxx = services
--   d0xxxxxx = staff
--   e0xxxxxx = staff_unavailability
--   a2xxxxxx = clients
--   ab0xxxxx = appointments
--   f0xxxxxx = waitlist
--   b0xxxxxx = notifications
--   c0xxxxxx = notification_templates
--   daxxxxxx = ratings
-- ============================================================

-- ==================== Negocio ====================
INSERT INTO businesses (id, name, type, timezone, phone, email, address, walk_ins_allowed, cancellation_hours, active)
VALUES (
    'b1000000-0000-0000-0000-000000000001',
    'Barbería El Maestro',
    'BARBERSHOP',
    'America/Lima',
    '+51-1-445-2280',
    'contacto@barberiaelmaestro.pe',
    'Av. Larco 742, Miraflores, Lima 15074, Perú',
    TRUE,
    2,
    TRUE
);

-- ==================== Usuarios del sistema (sin no_show_count ni flagged) ====================

-- Dueño
INSERT INTO users (id, business_id, name, email, password_hash, phone, role, active)
VALUES (
    'a1000000-0000-0000-0000-000000000001',
    'b1000000-0000-0000-0000-000000000001',
    'Luis Mendoza Ríos',
    'luis@barberiaelmaestro.pe',
    '$2a$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi',
    '+51-987-654-001',
    'OWNER',
    TRUE
);

-- Barberos
INSERT INTO users (id, business_id, name, email, password_hash, phone, role, active)
VALUES
    ('a1000000-0000-0000-0000-000000000002', 'b1000000-0000-0000-0000-000000000001', 'Diego Quispe Vargas',   'diego@barberiaelmaestro.pe',   '$2a$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', '+51-987-654-002', 'STAFF', TRUE),
    ('a1000000-0000-0000-0000-000000000003', 'b1000000-0000-0000-0000-000000000001', 'Rodrigo Huanca Flores', 'rodrigo@barberiaelmaestro.pe', '$2a$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', '+51-987-654-003', 'STAFF', TRUE),
    ('a1000000-0000-0000-0000-000000000004', 'b1000000-0000-0000-0000-000000000001', 'Carlos Mamani Cáceres', 'carlos@barberiaelmaestro.pe', '$2a$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', '+51-987-654-004', 'STAFF', TRUE);

-- ==================== Servicios (con categoría) ====================
INSERT INTO services (id, business_id, name, description, category, duration_minutes, buffer_minutes, price, active)
VALUES
    ('c1000000-0000-0000-0000-000000000001', 'b1000000-0000-0000-0000-000000000001', 'Corte Clásico',       'Corte tradicional con tijera y peinado incluido',              'Cortes',  30, 5,  35.00, TRUE),
    ('c1000000-0000-0000-0000-000000000002', 'b1000000-0000-0000-0000-000000000001', 'Corte Degradé',       'Degradé a piel o bajo con delineado de precisión',            'Cortes',  45, 5,  45.00, TRUE),
    ('c1000000-0000-0000-0000-000000000003', 'b1000000-0000-0000-0000-000000000001', 'Recorte de Barba',    'Perfilado y recorte con acabado en navaja recta',             'Barba',   20, 5,  25.00, TRUE),
    ('c1000000-0000-0000-0000-000000000004', 'b1000000-0000-0000-0000-000000000001', 'Afeitado con Navaja', 'Afeitado clásico con toalla caliente y navaja recta',         'Barba',   30, 10, 40.00, TRUE),
    ('c1000000-0000-0000-0000-000000000005', 'b1000000-0000-0000-0000-000000000001', 'Corte Infantil',      'Corte para niños menores de 12 años',                         'Cortes',  20, 5,  25.00, TRUE),
    ('c1000000-0000-0000-0000-000000000006', 'b1000000-0000-0000-0000-000000000001', 'Combo Corte y Barba', 'Corte completo más recorte y perfilado de barba',             'Combos',  60, 10, 60.00, TRUE);

-- ==================== Staff (sin business_id) ====================
INSERT INTO staff (id, user_id, bio, active)
VALUES
    ('d0000000-0000-0000-0000-000000000001', 'a1000000-0000-0000-0000-000000000002', 'Barbero senior con 10 años de experiencia. Especialista en degradés y cortes modernos.', TRUE),
    ('d0000000-0000-0000-0000-000000000002', 'a1000000-0000-0000-0000-000000000003', 'Experto en cuidado de barba y afeitado clásico con navaja. 7 años en el oficio.',         TRUE),
    ('d0000000-0000-0000-0000-000000000003', 'a1000000-0000-0000-0000-000000000004', 'Especialista en cortes infantiles y estilos clásicos. Reconocido por su paciencia.',      TRUE);

-- ==================== Servicios por barbero ====================

-- Diego: Corte Clásico, Degradé, Recorte de Barba, Combo
INSERT INTO staff_services (staff_id, service_id) VALUES
    ('d0000000-0000-0000-0000-000000000001', 'c1000000-0000-0000-0000-000000000001'),
    ('d0000000-0000-0000-0000-000000000001', 'c1000000-0000-0000-0000-000000000002'),
    ('d0000000-0000-0000-0000-000000000001', 'c1000000-0000-0000-0000-000000000003'),
    ('d0000000-0000-0000-0000-000000000001', 'c1000000-0000-0000-0000-000000000006');

-- Rodrigo: Recorte de Barba, Afeitado con Navaja, Combo
INSERT INTO staff_services (staff_id, service_id) VALUES
    ('d0000000-0000-0000-0000-000000000002', 'c1000000-0000-0000-0000-000000000003'),
    ('d0000000-0000-0000-0000-000000000002', 'c1000000-0000-0000-0000-000000000004'),
    ('d0000000-0000-0000-0000-000000000002', 'c1000000-0000-0000-0000-000000000006');

-- Carlos: Corte Clásico, Degradé, Corte Infantil
INSERT INTO staff_services (staff_id, service_id) VALUES
    ('d0000000-0000-0000-0000-000000000003', 'c1000000-0000-0000-0000-000000000001'),
    ('d0000000-0000-0000-0000-000000000003', 'c1000000-0000-0000-0000-000000000002'),
    ('d0000000-0000-0000-0000-000000000003', 'c1000000-0000-0000-0000-000000000005');

-- ==================== Horarios de trabajo ====================
-- day_of_week: 0=Domingo, 1=Lunes, 2=Martes, 3=Miércoles, 4=Jueves, 5=Viernes, 6=Sábado

-- Diego: Lunes a Sábado (turno partido el miércoles)
INSERT INTO working_hours (staff_id, day_of_week, start_time, end_time, active) VALUES
    ('d0000000-0000-0000-0000-000000000001', 1, '09:00', '19:00', TRUE),
    ('d0000000-0000-0000-0000-000000000001', 2, '09:00', '19:00', TRUE),
    ('d0000000-0000-0000-0000-000000000001', 3, '09:00', '13:00', TRUE),
    ('d0000000-0000-0000-0000-000000000001', 3, '15:00', '20:00', TRUE),
    ('d0000000-0000-0000-0000-000000000001', 4, '09:00', '19:00', TRUE),
    ('d0000000-0000-0000-0000-000000000001', 5, '09:00', '19:00', TRUE),
    ('d0000000-0000-0000-0000-000000000001', 6, '09:00', '18:00', TRUE);

-- Rodrigo: Martes a Sábado
INSERT INTO working_hours (staff_id, day_of_week, start_time, end_time, active) VALUES
    ('d0000000-0000-0000-0000-000000000002', 2, '10:00', '20:00', TRUE),
    ('d0000000-0000-0000-0000-000000000002', 3, '10:00', '20:00', TRUE),
    ('d0000000-0000-0000-0000-000000000002', 4, '10:00', '20:00', TRUE),
    ('d0000000-0000-0000-0000-000000000002', 5, '10:00', '20:00', TRUE),
    ('d0000000-0000-0000-0000-000000000002', 6, '10:00', '18:00', TRUE);

-- Carlos: Lunes a Viernes
INSERT INTO working_hours (staff_id, day_of_week, start_time, end_time, active) VALUES
    ('d0000000-0000-0000-0000-000000000003', 1, '08:00', '17:00', TRUE),
    ('d0000000-0000-0000-0000-000000000003', 2, '08:00', '17:00', TRUE),
    ('d0000000-0000-0000-0000-000000000003', 3, '08:00', '17:00', TRUE),
    ('d0000000-0000-0000-0000-000000000003', 4, '08:00', '17:00', TRUE),
    ('d0000000-0000-0000-0000-000000000003', 5, '08:00', '17:00', TRUE);

-- ==================== Inasistencias del personal ====================
INSERT INTO staff_unavailability (id, staff_id, start_at, end_at, reason)
VALUES
    ('e0000000-0000-0000-0000-000000000001', 'd0000000-0000-0000-0000-000000000001', '2026-03-10 00:00:00+00', '2026-03-12 23:59:59+00', 'Vacaciones'),
    ('e0000000-0000-0000-0000-000000000002', 'd0000000-0000-0000-0000-000000000002', '2026-02-28 00:00:00+00', '2026-02-28 23:59:59+00', 'Día personal'),
    ('e0000000-0000-0000-0000-000000000003', 'd0000000-0000-0000-0000-000000000003', '2026-03-05 00:00:00+00', '2026-03-06 23:59:59+00', 'Cita médica');

-- ==================== Clientes (con business_id) ====================
INSERT INTO clients (id, business_id, name, email, phone, no_show_count, flagged, active)
VALUES
    ('a2000000-0000-0000-0000-000000000001', 'b1000000-0000-0000-0000-000000000001', 'Andrés Torres Salas',      'andres.torres@gmail.com',    '+51-991-100-001', 0, FALSE, TRUE),
    ('a2000000-0000-0000-0000-000000000002', 'b1000000-0000-0000-0000-000000000001', 'Miguel Flores Paredes',    'miguel.flores@gmail.com',    '+51-991-100-002', 1, FALSE, TRUE),
    ('a2000000-0000-0000-0000-000000000003', 'b1000000-0000-0000-0000-000000000001', 'Sebastián Chávez Luna',    'sebastian.chavez@gmail.com', '+51-991-100-003', 0, FALSE, TRUE),
    ('a2000000-0000-0000-0000-000000000004', 'b1000000-0000-0000-0000-000000000001', 'Fernando Ruiz Medina',     'fernando.ruiz@gmail.com',    '+51-991-100-004', 2, TRUE,  TRUE),
    ('a2000000-0000-0000-0000-000000000005', 'b1000000-0000-0000-0000-000000000001', 'Jorge Paredes Villanueva', 'jorge.paredes@gmail.com',    '+51-991-100-005', 0, FALSE, TRUE);

-- ==================== Citas ====================
INSERT INTO appointments (id, business_id, client_id, staff_id, service_id, start_at, end_at, status, preferred_staff, notes, confirmation_token, confirmed_at, cancelled_at, cancel_reason, created_at, updated_at)
VALUES
    -- COMPLETADA: Andrés → Diego, Corte Degradé
    ('ab000000-0000-0000-0000-000000000001',
     'b1000000-0000-0000-0000-000000000001', 'a2000000-0000-0000-0000-000000000001', 'd0000000-0000-0000-0000-000000000001', 'c1000000-0000-0000-0000-000000000002',
     '2026-02-10 10:00:00+00', '2026-02-10 10:50:00+00',
     'COMPLETED', TRUE, 'Cliente frecuente, prefiere degradé bajo', 'TOKEN-EM-001', '2026-02-09 20:00:00+00', NULL, NULL,
     '2026-02-09 19:00:00+00', '2026-02-10 10:50:00+00'),

    -- COMPLETADA: Miguel → Rodrigo, Afeitado con Navaja
    ('ab000000-0000-0000-0000-000000000002',
     'b1000000-0000-0000-0000-000000000001', 'a2000000-0000-0000-0000-000000000002', 'd0000000-0000-0000-0000-000000000002', 'c1000000-0000-0000-0000-000000000004',
     '2026-02-10 11:00:00+00', '2026-02-10 11:40:00+00',
     'COMPLETED', FALSE, NULL, 'TOKEN-EM-002', '2026-02-09 21:00:00+00', NULL, NULL,
     '2026-02-09 20:00:00+00', '2026-02-10 11:40:00+00'),

    -- COMPLETADA: Sebastián → Carlos, Corte Infantil
    ('ab000000-0000-0000-0000-000000000003',
     'b1000000-0000-0000-0000-000000000001', 'a2000000-0000-0000-0000-000000000003', 'd0000000-0000-0000-0000-000000000003', 'c1000000-0000-0000-0000-000000000005',
     '2026-02-12 09:00:00+00', '2026-02-12 09:25:00+00',
     'COMPLETED', FALSE, 'Corte para su hijo, corto en los costados', 'TOKEN-EM-003', '2026-02-11 18:00:00+00', NULL, NULL,
     '2026-02-11 17:00:00+00', '2026-02-12 09:25:00+00'),

    -- NO SE PRESENTÓ: Fernando → Diego, Combo Corte y Barba
    ('ab000000-0000-0000-0000-000000000004',
     'b1000000-0000-0000-0000-000000000001', 'a2000000-0000-0000-0000-000000000004', 'd0000000-0000-0000-0000-000000000001', 'c1000000-0000-0000-0000-000000000006',
     '2026-02-14 14:00:00+00', '2026-02-14 15:10:00+00',
     'NO_SHOW', TRUE, NULL, 'TOKEN-EM-004', NULL, NULL, NULL,
     '2026-02-13 14:00:00+00', '2026-02-14 15:10:00+00'),

    -- COMPLETADA: Jorge → Rodrigo, Recorte de Barba
    ('ab000000-0000-0000-0000-000000000005',
     'b1000000-0000-0000-0000-000000000001', 'a2000000-0000-0000-0000-000000000005', 'd0000000-0000-0000-0000-000000000002', 'c1000000-0000-0000-0000-000000000003',
     '2026-02-17 15:00:00+00', '2026-02-17 15:25:00+00',
     'COMPLETED', FALSE, NULL, 'TOKEN-EM-005', '2026-02-16 12:00:00+00', NULL, NULL,
     '2026-02-16 11:00:00+00', '2026-02-17 15:25:00+00'),

    -- CANCELADA: Andrés → Carlos, Corte Clásico
    ('ab000000-0000-0000-0000-000000000006',
     'b1000000-0000-0000-0000-000000000001', 'a2000000-0000-0000-0000-000000000001', 'd0000000-0000-0000-0000-000000000003', 'c1000000-0000-0000-0000-000000000001',
     '2026-02-18 10:00:00+00', '2026-02-18 10:35:00+00',
     'CANCELLED', FALSE, NULL, 'TOKEN-EM-006', NULL, '2026-02-17 18:00:00+00', 'Cliente canceló por teléfono',
     '2026-02-17 09:00:00+00', '2026-02-17 18:00:00+00'),

    -- COMPLETADA: Miguel → Diego, Corte Degradé
    ('ab000000-0000-0000-0000-000000000007',
     'b1000000-0000-0000-0000-000000000001', 'a2000000-0000-0000-0000-000000000002', 'd0000000-0000-0000-0000-000000000001', 'c1000000-0000-0000-0000-000000000002',
     '2026-02-20 11:00:00+00', '2026-02-20 11:50:00+00',
     'COMPLETED', TRUE, 'Degradé a piel esta vez', 'TOKEN-EM-007', '2026-02-19 19:00:00+00', NULL, NULL,
     '2026-02-19 18:00:00+00', '2026-02-20 11:50:00+00'),

    -- CONFIRMADA: Sebastián → Diego, Corte Degradé
    ('ab000000-0000-0000-0000-000000000008',
     'b1000000-0000-0000-0000-000000000001', 'a2000000-0000-0000-0000-000000000003', 'd0000000-0000-0000-0000-000000000001', 'c1000000-0000-0000-0000-000000000002',
     '2026-02-26 10:00:00+00', '2026-02-26 10:50:00+00',
     'CONFIRMED', TRUE, NULL, 'TOKEN-EM-008', '2026-02-25 08:00:00+00', NULL, NULL,
     '2026-02-24 20:00:00+00', '2026-02-25 08:00:00+00'),

    -- PROGRAMADA: Jorge → Rodrigo, Afeitado con Navaja
    ('ab000000-0000-0000-0000-000000000009',
     'b1000000-0000-0000-0000-000000000001', 'a2000000-0000-0000-0000-000000000005', 'd0000000-0000-0000-0000-000000000002', 'c1000000-0000-0000-0000-000000000004',
     '2026-02-26 13:00:00+00', '2026-02-26 13:40:00+00',
     'SCHEDULED', FALSE, 'Primera vez del cliente', 'TOKEN-EM-009', NULL, NULL, NULL,
     '2026-02-25 07:00:00+00', '2026-02-25 07:00:00+00'),

    -- PROGRAMADA: Andrés → Diego, Combo Corte y Barba
    ('ab000000-0000-0000-0000-000000000010',
     'b1000000-0000-0000-0000-000000000001', 'a2000000-0000-0000-0000-000000000001', 'd0000000-0000-0000-0000-000000000001', 'c1000000-0000-0000-0000-000000000006',
     '2026-03-02 09:00:00+00', '2026-03-02 10:10:00+00',
     'SCHEDULED', TRUE, 'Combo mensual', 'TOKEN-EM-010', NULL, NULL, NULL,
     '2026-02-25 06:00:00+00', '2026-02-25 06:00:00+00'),

    -- PROGRAMADA: Fernando → Carlos, Corte Clásico
    ('ab000000-0000-0000-0000-000000000011',
     'b1000000-0000-0000-0000-000000000001', 'a2000000-0000-0000-0000-000000000004', 'd0000000-0000-0000-0000-000000000003', 'c1000000-0000-0000-0000-000000000001',
     '2026-03-03 14:00:00+00', '2026-03-03 14:35:00+00',
     'SCHEDULED', FALSE, NULL, 'TOKEN-EM-011', NULL, NULL, NULL,
     '2026-02-25 10:00:00+00', '2026-02-25 10:00:00+00'),

    -- PROGRAMADA: Miguel → Rodrigo, Recorte de Barba
    ('ab000000-0000-0000-0000-000000000012',
     'b1000000-0000-0000-0000-000000000001', 'a2000000-0000-0000-0000-000000000002', 'd0000000-0000-0000-0000-000000000002', 'c1000000-0000-0000-0000-000000000003',
     '2026-03-04 11:00:00+00', '2026-03-04 11:25:00+00',
     'SCHEDULED', FALSE, NULL, 'TOKEN-EM-012', NULL, NULL, NULL,
     '2026-02-25 11:00:00+00', '2026-02-25 11:00:00+00');

-- ==================== Lista de espera (con priority) ====================
INSERT INTO waitlist (id, business_id, client_id, service_id, staff_id, preferred_date, notified_at, status, priority, created_at)
VALUES
    ('f0000000-0000-0000-0000-000000000001', 'b1000000-0000-0000-0000-000000000001',
     'a2000000-0000-0000-0000-000000000004', 'c1000000-0000-0000-0000-000000000002', 'd0000000-0000-0000-0000-000000000001',
     '2026-02-26', NULL, 'WAITING', 1, '2026-02-24 15:00:00+00'),

    ('f0000000-0000-0000-0000-000000000002', 'b1000000-0000-0000-0000-000000000001',
     'a2000000-0000-0000-0000-000000000003', 'c1000000-0000-0000-0000-000000000004', NULL,
     '2026-02-27', '2026-02-25 09:00:00+00', 'NOTIFIED', 2, '2026-02-23 12:00:00+00'),

    ('f0000000-0000-0000-0000-000000000003', 'b1000000-0000-0000-0000-000000000001',
     'a2000000-0000-0000-0000-000000000005', 'c1000000-0000-0000-0000-000000000001', NULL,
     '2026-02-20', NULL, 'EXPIRED', 0, '2026-02-18 10:00:00+00');

-- ==================== Notificaciones ====================
INSERT INTO notifications (id, appointment_id, type, event, sent_at, status, error_message)
VALUES
    ('b0000000-0000-0000-0000-000000000001', 'ab000000-0000-0000-0000-000000000001', 'EMAIL',    'APPOINTMENT_CONFIRMATION', '2026-02-09 19:01:00+00', 'SENT',   NULL),
    ('b0000000-0000-0000-0000-000000000002', 'ab000000-0000-0000-0000-000000000001', 'WHATSAPP', 'APPOINTMENT_REMINDER',     '2026-02-10 08:00:00+00', 'SENT',   NULL),
    ('b0000000-0000-0000-0000-000000000003', 'ab000000-0000-0000-0000-000000000002', 'EMAIL',    'APPOINTMENT_CONFIRMATION', '2026-02-09 20:01:00+00', 'SENT',   NULL),
    ('b0000000-0000-0000-0000-000000000004', 'ab000000-0000-0000-0000-000000000003', 'EMAIL',    'APPOINTMENT_CONFIRMATION', '2026-02-11 17:01:00+00', 'SENT',   NULL),
    ('b0000000-0000-0000-0000-000000000005', 'ab000000-0000-0000-0000-000000000004', 'EMAIL',    'APPOINTMENT_CONFIRMATION', '2026-02-13 14:01:00+00', 'SENT',   NULL),
    ('b0000000-0000-0000-0000-000000000006', 'ab000000-0000-0000-0000-000000000004', 'WHATSAPP', 'APPOINTMENT_REMINDER',     '2026-02-14 08:00:00+00', 'SENT',   NULL),
    ('b0000000-0000-0000-0000-000000000007', 'ab000000-0000-0000-0000-000000000004', 'EMAIL',    'NO_SHOW_ALERT',            '2026-02-14 15:15:00+00', 'SENT',   NULL),
    ('b0000000-0000-0000-0000-000000000008', 'ab000000-0000-0000-0000-000000000005', 'EMAIL',    'APPOINTMENT_CONFIRMATION', '2026-02-16 11:01:00+00', 'SENT',   NULL),
    ('b0000000-0000-0000-0000-000000000009', 'ab000000-0000-0000-0000-000000000006', 'EMAIL',    'APPOINTMENT_CANCELLATION', '2026-02-17 18:01:00+00', 'SENT',   NULL),
    ('b0000000-0000-0000-0000-000000000010', 'ab000000-0000-0000-0000-000000000007', 'EMAIL',    'APPOINTMENT_CONFIRMATION', '2026-02-19 18:01:00+00', 'SENT',   NULL),
    ('b0000000-0000-0000-0000-000000000011', 'ab000000-0000-0000-0000-000000000007', 'WHATSAPP', 'APPOINTMENT_REMINDER',     '2026-02-20 08:00:00+00', 'SENT',   NULL),
    ('b0000000-0000-0000-0000-000000000012', 'ab000000-0000-0000-0000-000000000008', 'EMAIL',    'APPOINTMENT_CONFIRMATION', '2026-02-25 08:01:00+00', 'SENT',   NULL),
    ('b0000000-0000-0000-0000-000000000013', 'ab000000-0000-0000-0000-000000000009', 'EMAIL',    'APPOINTMENT_CONFIRMATION', NULL,                     'FAILED', 'Tiempo de espera agotado en el servidor SMTP'),
    ('b0000000-0000-0000-0000-000000000014', 'ab000000-0000-0000-0000-000000000009', 'EMAIL',    'APPOINTMENT_CONFIRMATION', NULL,                     'PENDING', NULL);

-- ==================== Plantillas de notificación ====================
INSERT INTO notification_templates (id, business_id, channel, event, template)
VALUES
    ('c0000000-0000-0000-0000-000000000001', 'b1000000-0000-0000-0000-000000000001', 'EMAIL',    'APPOINTMENT_CONFIRMATION', 'Hola {{client_name}}, tu cita para {{service_name}} con {{staff_name}} el {{date}} a las {{time}} está confirmada. ¡Te esperamos! — Barbería El Maestro'),
    ('c0000000-0000-0000-0000-000000000002', 'b1000000-0000-0000-0000-000000000001', 'EMAIL',    'APPOINTMENT_REMINDER',     'Hola {{client_name}}, te recordamos que mañana a las {{time}} tienes tu cita de {{service_name}} con {{staff_name}}. Responde CANCELAR si necesitas anular. — Barbería El Maestro'),
    ('c0000000-0000-0000-0000-000000000003', 'b1000000-0000-0000-0000-000000000001', 'EMAIL',    'APPOINTMENT_CANCELLATION', 'Hola {{client_name}}, tu cita del {{date}} a las {{time}} ha sido cancelada. Puedes reagendar en barberiaelmaestro.pe — Barbería El Maestro'),
    ('c0000000-0000-0000-0000-000000000004', 'b1000000-0000-0000-0000-000000000001', 'EMAIL',    'NO_SHOW_ALERT',             'Hola {{client_name}}, hoy no pudimos atenderte. Tu cita fue marcada como no presentado. Contáctanos para reagendar. — Barbería El Maestro'),
    ('c0000000-0000-0000-0000-000000000005', 'b1000000-0000-0000-0000-000000000001', 'SMS',      'APPOINTMENT_CONFIRMATION', 'Barbería El Maestro: {{service_name}} confirmado para el {{date}} a las {{time}} con {{staff_name}}. Responde STOP para cancelar.'),
    ('c0000000-0000-0000-0000-000000000006', 'b1000000-0000-0000-0000-000000000001', 'SMS',      'APPOINTMENT_REMINDER',     'Barbería El Maestro: Recordatorio — {{service_name}} mañana a las {{time}}. Responde CANCELAR para anular.'),
    ('c0000000-0000-0000-0000-000000000007', 'b1000000-0000-0000-0000-000000000001', 'WHATSAPP', 'APPOINTMENT_CONFIRMATION', '¡Hola {{client_name}}! Tu cita de *{{service_name}}* con *{{staff_name}}* está confirmada para el {{date}} a las {{time}}. ¡Te esperamos en Barbería El Maestro!'),
    ('c0000000-0000-0000-0000-000000000008', 'b1000000-0000-0000-0000-000000000001', 'WHATSAPP', 'APPOINTMENT_REMINDER',     '¡Hola {{client_name}}! Recordatorio: *{{service_name}}* mañana a las {{time}} con {{staff_name}}. Escribe *CANCELAR* si necesitas cambiar tu cita.');

-- ==================== Calificaciones ====================
-- Solo para citas COMPLETADAS: 001, 002, 003, 005, 007
INSERT INTO ratings (id, appointment_id, client_id, staff_id, score, comment, created_at)
VALUES
    ('da000000-0000-0000-0000-000000000001', 'ab000000-0000-0000-0000-000000000001', 'a2000000-0000-0000-0000-000000000001', 'd0000000-0000-0000-0000-000000000001', 5, '¡Diego es un crack! El degradé quedó perfecto, mejor que siempre.',    '2026-02-10 12:00:00+00'),
    ('da000000-0000-0000-0000-000000000002', 'ab000000-0000-0000-0000-000000000002', 'a2000000-0000-0000-0000-000000000002', 'd0000000-0000-0000-0000-000000000002', 4, 'Muy buen afeitado, muy relajante. Rodrigo sabe lo que hace.',           '2026-02-10 14:00:00+00'),
    ('da000000-0000-0000-0000-000000000003', 'ab000000-0000-0000-0000-000000000003', 'a2000000-0000-0000-0000-000000000003', 'd0000000-0000-0000-0000-000000000003', 5, 'Mi hijo salió feliz. Carlos tiene mucha paciencia con los niños.',      '2026-02-12 11:00:00+00'),
    ('da000000-0000-0000-0000-000000000004', 'ab000000-0000-0000-0000-000000000005', 'a2000000-0000-0000-0000-000000000005', 'd0000000-0000-0000-0000-000000000002', 3, 'Buen recorte, aunque tuve que esperar un poco más de lo esperado.',     '2026-02-17 16:00:00+00'),
    ('da000000-0000-0000-0000-000000000005', 'ab000000-0000-0000-0000-000000000007', 'a2000000-0000-0000-0000-000000000002', 'd0000000-0000-0000-0000-000000000001', 5, '¡Excelente degradé a piel! Exactamente lo que pedí, muy recomendado.', '2026-02-20 13:00:00+00');
