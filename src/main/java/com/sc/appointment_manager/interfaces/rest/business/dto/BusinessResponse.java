package com.sc.appointment_manager.interfaces.rest.business.dto;

import com.sc.appointment_manager.domain.business.Business;
import com.sc.appointment_manager.domain.business.BusinessType;

import java.time.OffsetDateTime;
import java.util.UUID;

public record BusinessResponse(
        UUID id,
        String name,
        BusinessType type,
        String timezone,
        String phone,
        String email,
        String address,
        boolean walkInsAllowed,
        int cancellationHours,
        boolean active,
        OffsetDateTime createdAt,
        OffsetDateTime updatedAt
) {
    public static BusinessResponse from(Business business) {
        return new BusinessResponse(
                business.getId(),
                business.getName(),
                business.getType(),
                business.getTimezone(),
                business.getPhone(),
                business.getEmail(),
                business.getAddress(),
                business.isWalkInsAllowed(),
                business.getCancellationHours(),
                business.isActive(),
                business.getCreatedAt(),
                business.getUpdatedAt()
        );
    }
}
