package com.sc.appointment_manager.domain.business;

import lombok.Builder;
import lombok.Getter;

import java.time.OffsetDateTime;
import java.util.UUID;

@Getter
@Builder(toBuilder = true)
public class Business {

    private final UUID id;
    private final String name;
    private final BusinessType type;
    private final String timezone;
    private final String phone;
    private final String email;
    private final String address;
    private final boolean walkInsAllowed;
    private final int cancellationHours;
    private final boolean active;
    private final OffsetDateTime createdAt;
    private final OffsetDateTime updatedAt;
}
