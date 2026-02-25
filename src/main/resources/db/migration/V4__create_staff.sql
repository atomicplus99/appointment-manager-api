CREATE TABLE staff (
    id          UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    user_id     UUID NOT NULL REFERENCES users(id),
    business_id UUID NOT NULL REFERENCES businesses(id),
    bio         TEXT,
    active      BOOLEAN DEFAULT TRUE
);

CREATE INDEX idx_staff_business_id ON staff(business_id);
CREATE INDEX idx_staff_user_id ON staff(user_id);
