package com.sc.appointment_manager.infrastructure.persistence.business;

import com.sc.appointment_manager.domain.business.Business;
import com.sc.appointment_manager.domain.business.port.BusinessRepository;
import com.sc.appointment_manager.domain.business.query.BusinessFilterQuery;
import lombok.RequiredArgsConstructor;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Component;

import java.util.Optional;
import java.util.UUID;

@Component
@RequiredArgsConstructor
public class BusinessRepositoryAdapter implements BusinessRepository {

    private final BusinessJpaRepository jpaRepository;
    private final BusinessMapper mapper;

    @Override
    public Business save(Business business) {
        return mapper.toDomain(jpaRepository.save(mapper.toEntity(business)));
    }

    @Override
    public Optional<Business> findById(UUID id) {
        return jpaRepository.findById(id).map(mapper::toDomain);
    }

    @Override
    public Page<Business> findAll(BusinessFilterQuery filter, Pageable pageable) {
        return jpaRepository.findAll(BusinessSpecification.withFilter(filter), pageable)
                .map(mapper::toDomain);
    }

    @Override
    public boolean existsById(UUID id) {
        return jpaRepository.existsById(id);
    }
}
