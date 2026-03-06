package com.sc.appointment_manager.domain.user;

import lombok.Builder;
import lombok.Getter;

import java.time.OffsetDateTime;
import java.util.UUID;

@Getter
@Builder(toBuilder = true)
public class User {

    private final UUID id;
    private final UUID businessId;
    private final String name;
    private final String email;
    private final String passwordHash;
    private final String phone;
    private final UserRole role;
    private final boolean active;
    private final OffsetDateTime createdAt;
}
