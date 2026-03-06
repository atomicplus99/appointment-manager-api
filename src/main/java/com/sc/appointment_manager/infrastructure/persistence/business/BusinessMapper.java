package com.sc.appointment_manager.infrastructure.persistence.business;

import com.sc.appointment_manager.domain.business.Business;
import org.springframework.stereotype.Component;

@Component
public class BusinessMapper {

    public Business toDomain(BusinessJpaEntity entity) {
        return Business.builder()
                .id(entity.getId())
                .name(entity.getName())
                .type(entity.getType())
                .timezone(entity.getTimezone())
                .phone(entity.getPhone())
                .email(entity.getEmail())
                .address(entity.getAddress())
                .walkInsAllowed(entity.isWalkInsAllowed())
                .cancellationHours(entity.getCancellationHours())
                .active(entity.isActive())
                .createdAt(entity.getCreatedAt())
                .updatedAt(entity.getUpdatedAt())
                .build();
    }

    public BusinessJpaEntity toEntity(Business domain) {
        return BusinessJpaEntity.builder()
                .id(domain.getId())
                .name(domain.getName())
                .type(domain.getType())
                .timezone(domain.getTimezone())
                .phone(domain.getPhone())
                .email(domain.getEmail())
                .address(domain.getAddress())
                .walkInsAllowed(domain.isWalkInsAllowed())
                .cancellationHours(domain.getCancellationHours())
                .active(domain.isActive())
                .createdAt(domain.getCreatedAt())
                .updatedAt(domain.getUpdatedAt())
                .build();
    }
}
