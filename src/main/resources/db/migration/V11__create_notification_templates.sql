CREATE TABLE notification_templates (
    id          UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    business_id UUID NOT NULL REFERENCES businesses(id),
    channel     VARCHAR(20) NOT NULL,
    event       VARCHAR(50) NOT NULL,
    template    TEXT NOT NULL,
    CONSTRAINT chk_template_channel CHECK (
        channel IN ('EMAIL', 'WHATSAPP', 'SMS')
    ),
    UNIQUE (business_id, channel, event)
);

CREATE INDEX idx_notification_templates_business_id ON notification_templates(business_id);
