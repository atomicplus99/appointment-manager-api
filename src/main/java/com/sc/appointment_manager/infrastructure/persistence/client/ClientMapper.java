package com.sc.appointment_manager.infrastructure.persistence.client;

import com.sc.appointment_manager.domain.client.Client;
import org.springframework.stereotype.Component;

@Component
public class ClientMapper {

    public Client toDomain(ClientJpaEntity entity) {
        return Client.builder()
                .id(entity.getId())
                .businessId(entity.getBusinessId())
                .name(entity.getName())
                .email(entity.getEmail())
                .phone(entity.getPhone())
                .noShowCount(entity.getNoShowCount())
                .flagged(entity.isFlagged())
                .active(entity.isActive())
                .createdAt(entity.getCreatedAt())
                .build();
    }

    public ClientJpaEntity toEntity(Client client) {
        return ClientJpaEntity.builder()
                .id(client.getId())
                .businessId(client.getBusinessId())
                .name(client.getName())
                .email(client.getEmail())
                .phone(client.getPhone())
                .noShowCount(client.getNoShowCount())
                .flagged(client.isFlagged())
                .active(client.isActive())
                .createdAt(client.getCreatedAt())
                .build();
    }
}
