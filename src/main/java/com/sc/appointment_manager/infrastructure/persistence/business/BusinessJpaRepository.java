package com.sc.appointment_manager.infrastructure.persistence.business;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.stereotype.Repository;

import java.util.UUID;

@Repository
public interface BusinessJpaRepository extends JpaRepository<BusinessJpaEntity, UUID>,
        JpaSpecificationExecutor<BusinessJpaEntity> {
}
