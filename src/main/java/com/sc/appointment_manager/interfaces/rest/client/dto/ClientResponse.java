package com.sc.appointment_manager.interfaces.rest.client.dto;

import com.sc.appointment_manager.domain.client.Client;

import java.time.OffsetDateTime;
import java.util.UUID;

public record ClientResponse(
        UUID id,
        UUID businessId,
        String name,
        String email,
        String phone,
        int noShowCount,
        boolean flagged,
        boolean active,
        OffsetDateTime createdAt
) {
    public static ClientResponse from(Client client) {
        return new ClientResponse(
                client.getId(),
                client.getBusinessId(),
                client.getName(),
                client.getEmail(),
                client.getPhone(),
                client.getNoShowCount(),
                client.isFlagged(),
                client.isActive(),
                client.getCreatedAt()
        );
    }
}
