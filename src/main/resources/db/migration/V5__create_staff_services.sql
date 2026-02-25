CREATE TABLE staff_services (
    staff_id    UUID NOT NULL REFERENCES staff(id),
    service_id  UUID NOT NULL REFERENCES services(id),
    PRIMARY KEY (staff_id, service_id)
);
