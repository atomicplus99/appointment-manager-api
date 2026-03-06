package com.sc.appointment_manager.infrastructure.persistence.business;

import com.sc.appointment_manager.domain.business.Business;
import com.sc.appointment_manager.domain.business.port.BusinessRepository;
import com.sc.appointment_manager.domain.business.query.BusinessFilterQuery;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Component;

import java.util.List;
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
    public List<Business> findAll(BusinessFilterQuery filter) {
        return jpaRepository.findAll(BusinessSpecification.withFilter(filter)).stream()
                .map(mapper::toDomain)
                .toList();
    }

    @Override
    public boolean existsById(UUID id) {
        return jpaRepository.existsById(id);
    }
}
