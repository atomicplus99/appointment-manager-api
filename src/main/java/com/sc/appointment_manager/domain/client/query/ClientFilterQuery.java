package com.sc.appointment_manager.domain.client.query;

import java.util.UUID;

public record ClientFilterQuery(
        UUID businessId,
        String name,
        String email,
        Boolean flagged,
        Boolean active
) {}
