package com.sc.appointment_manager.application.business.command;

import com.sc.appointment_manager.domain.business.BusinessType;

public record UpdateBusinessCommand(
        String name,
        BusinessType type,
        String timezone,
        String phone,
        String email,
        String address,
        boolean walkInsAllowed,
        int cancellationHours
) {}
