package com.sc.appointment_manager.domain.business.query;

import com.sc.appointment_manager.domain.business.BusinessType;

public record BusinessFilterQuery(
        String name,
        BusinessType type,
        Boolean active,
        Boolean walkInsAllowed,
        String timezone
) {}
