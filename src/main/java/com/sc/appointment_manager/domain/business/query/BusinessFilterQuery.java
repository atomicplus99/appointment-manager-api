package com.sc.appointment_manager.domain.business.query;

import com.sc.appointment_manager.domain.business.BusinessType;

import java.util.UUID;

public record BusinessFilterQuery(
        UUID id,
        String name,
        BusinessType type,
        Boolean active,
        Boolean walkInsAllowed,
        String timezone
) {}
