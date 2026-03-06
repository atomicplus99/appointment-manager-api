package com.sc.appointment_manager.infrastructure.persistence.client;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.stereotype.Repository;

import java.util.UUID;

@Repository
public interface ClientJpaRepository extends JpaRepository<ClientJpaEntity, UUID>,
        JpaSpecificationExecutor<ClientJpaEntity> {
}
