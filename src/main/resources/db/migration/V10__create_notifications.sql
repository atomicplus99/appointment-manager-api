CREATE TABLE notifications (
    id             UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    appointment_id UUID NOT NULL REFERENCES appointments(id),
    type           VARCHAR(30) NOT NULL,
    event          VARCHAR(50) NOT NULL,
    sent_at        TIMESTAMPTZ,
    status         VARCHAR(20) NOT NULL DEFAULT 'PENDING',
    error_message  TEXT,
    CONSTRAINT chk_notification_type CHECK (
        type IN ('EMAIL', 'WHATSAPP', 'SMS')
    ),
    CONSTRAINT chk_notification_status CHECK (
        status IN ('PENDING', 'SENT', 'FAILED')
    )
);

CREATE INDEX idx_notifications_appointment_id ON notifications(appointment_id);
CREATE INDEX idx_notifications_status ON notifications(status);
