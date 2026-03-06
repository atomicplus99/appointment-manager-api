package com.sc.appointment_manager.infrastructure.persistence.user;

import com.sc.appointment_manager.domain.user.User;
import org.springframework.stereotype.Component;

@Component
public class UserMapper {

    public User toDomain(UserJpaEntity entity) {
        return User.builder()
                .id(entity.getId())
                .businessId(entity.getBusinessId())
                .name(entity.getName())
                .email(entity.getEmail())
                .passwordHash(entity.getPasswordHash())
                .phone(entity.getPhone())
                .role(entity.getRole())
                .active(entity.isActive())
                .createdAt(entity.getCreatedAt())
                .build();
    }

    public UserJpaEntity toEntity(User domain) {
        return UserJpaEntity.builder()
                .id(domain.getId())
                .businessId(domain.getBusinessId())
                .name(domain.getName())
                .email(domain.getEmail())
                .passwordHash(domain.getPasswordHash())
                .phone(domain.getPhone())
                .role(domain.getRole())
                .active(domain.isActive())
                .createdAt(domain.getCreatedAt())
                .build();
    }
}
