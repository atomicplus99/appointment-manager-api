-- ============================================================
-- Datos de prueba: Barbería El Maestro — Lima, Perú
-- Este seed se ejecuta DESPUÉS de todas las migraciones (V1–V16).
-- Refleja el esquema final: sin columnas eliminadas, con columnas nuevas.
-- Contraseña del usuario OWNER: admin123
--
-- UUID prefijos (todos válidos en hex):
--   b1xxxxxx = businesses
--   a1xxxxxx = users
--   c1xxxxxx = services
--   a2xxxxxx = clients
--   c0xxxxxx = notification_templates
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

-- ==================== Usuarios del sistema ====================

-- Dueño (contraseña: admin123)
INSERT INTO users (id, business_id, name, email, password_hash, phone, role, active)
VALUES (
    'a1000000-0000-0000-0000-000000000001',
    'b1000000-0000-0000-0000-000000000001',
    'Luis Mendoza Ríos',
    'luis@barberiaelmaestro.pe',
    '$2a$10$X63QkbFH0dMIcsMzPcbLAegbUpk/MP1ikHA2hWUdY.hGuS/3cyCua',
    '+51-987-654-001',
    'OWNER',
    TRUE
);

-- ==================== Servicios (con categoría) ====================
INSERT INTO services (id, business_id, name, description, category, duration_minutes, buffer_minutes, price, active)
VALUES
    ('c1000000-0000-0000-0000-000000000001', 'b1000000-0000-0000-0000-000000000001', 'Corte Clásico',       'Corte tradicional con tijera y peinado incluido',              'Cortes',  30, 5,  35.00, TRUE),
    ('c1000000-0000-0000-0000-000000000002', 'b1000000-0000-0000-0000-000000000001', 'Corte Degradé',       'Degradé a piel o bajo con delineado de precisión',            'Cortes',  45, 5,  45.00, TRUE),
    ('c1000000-0000-0000-0000-000000000003', 'b1000000-0000-0000-0000-000000000001', 'Recorte de Barba',    'Perfilado y recorte con acabado en navaja recta',             'Barba',   20, 5,  25.00, TRUE),
    ('c1000000-0000-0000-0000-000000000004', 'b1000000-0000-0000-0000-000000000001', 'Afeitado con Navaja', 'Afeitado clásico con toalla caliente y navaja recta',         'Barba',   30, 10, 40.00, TRUE),
    ('c1000000-0000-0000-0000-000000000005', 'b1000000-0000-0000-0000-000000000001', 'Corte Infantil',      'Corte para niños menores de 12 años',                         'Cortes',  20, 5,  25.00, TRUE),
    ('c1000000-0000-0000-0000-000000000006', 'b1000000-0000-0000-0000-000000000001', 'Combo Corte y Barba', 'Corte completo más recorte y perfilado de barba',             'Combos',  60, 10, 60.00, TRUE);



-- ==================== Clientes (con business_id) ====================
INSERT INTO clients (id, business_id, name, email, phone, no_show_count, flagged, active)
VALUES
    ('a2000000-0000-0000-0000-000000000001', 'b1000000-0000-0000-0000-000000000001', 'Andrés Torres Salas',      'andres.torres@gmail.com',    '+51-991-100-001', 0, FALSE, TRUE),
    ('a2000000-0000-0000-0000-000000000002', 'b1000000-0000-0000-0000-000000000001', 'Miguel Flores Paredes',    'miguel.flores@gmail.com',    '+51-991-100-002', 1, FALSE, TRUE),
    ('a2000000-0000-0000-0000-000000000003', 'b1000000-0000-0000-0000-000000000001', 'Sebastián Chávez Luna',    'sebastian.chavez@gmail.com', '+51-991-100-003', 0, FALSE, TRUE),
    ('a2000000-0000-0000-0000-000000000004', 'b1000000-0000-0000-0000-000000000001', 'Fernando Ruiz Medina',     'fernando.ruiz@gmail.com',    '+51-991-100-004', 2, TRUE,  TRUE),
    ('a2000000-0000-0000-0000-000000000005', 'b1000000-0000-0000-0000-000000000001', 'Jorge Paredes Villanueva', 'jorge.paredes@gmail.com',    '+51-991-100-005', 0, FALSE, TRUE);


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

