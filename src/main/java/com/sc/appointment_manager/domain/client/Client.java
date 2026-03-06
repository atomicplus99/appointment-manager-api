package com.sc.appointment_manager.domain.client;

import lombok.Builder;
import lombok.Getter;

import java.time.OffsetDateTime;
import java.util.UUID;

@Getter
@Builder(toBuilder = true)
public class Client {
    private final UUID id;
    private final UUID businessId;
    private final String name;
    private final String email;
    private final String phone;
    private final int noShowCount;
    private final boolean flagged;
    private final boolean active;
    private final OffsetDateTime createdAt;
}
