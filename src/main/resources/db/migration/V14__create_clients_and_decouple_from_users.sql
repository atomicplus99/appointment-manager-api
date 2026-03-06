-- ============================================================
-- Separar clientes de usuarios del sistema.
-- Los clientes no necesitan cuenta ni autenticación.
-- Se coordinan con el barbero o admin por teléfono/WhatsApp.
-- ============================================================

-- 1. Crear tabla de clientes
CREATE TABLE clients (
    id              UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    name            VARCHAR(255) NOT NULL,
    email           VARCHAR(255) UNIQUE,
    phone           VARCHAR(30),
    no_show_count   INT DEFAULT 0,
    flagged         BOOLEAN DEFAULT FALSE,
    active          BOOLEAN DEFAULT TRUE,
    created_at      TIMESTAMPTZ DEFAULT now()
);

CREATE INDEX idx_clients_email ON clients(email);

-- 2. Migrar clientes existentes desde users (preservando UUIDs para integridad de FKs)
INSERT INTO clients (id, name, email, phone, no_show_count, flagged, active, created_at)
SELECT id, name, email, phone, no_show_count, flagged, active, created_at
FROM users
WHERE role = 'CLIENT';

-- 3. Eliminar FKs que apuntan a users(id) en columnas client_id
ALTER TABLE appointments DROP CONSTRAINT appointments_client_id_fkey;
ALTER TABLE waitlist     DROP CONSTRAINT waitlist_client_id_fkey;
ALTER TABLE ratings      DROP CONSTRAINT ratings_client_id_fkey;

-- 4. Agregar nuevas FKs apuntando a clients(id)
ALTER TABLE appointments ADD CONSTRAINT appointments_client_id_fkey FOREIGN KEY (client_id) REFERENCES clients(id);
ALTER TABLE waitlist     ADD CONSTRAINT waitlist_client_id_fkey     FOREIGN KEY (client_id) REFERENCES clients(id);
ALTER TABLE ratings      ADD CONSTRAINT ratings_client_id_fkey      FOREIGN KEY (client_id) REFERENCES clients(id);

-- 5. Eliminar registros de rol CLIENT de la tabla users
DELETE FROM users WHERE role = 'CLIENT';
