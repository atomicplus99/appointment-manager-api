package com.sc.appointment_manager.application.business.service;

import com.sc.appointment_manager.application.business.command.CreateBusinessCommand;
import com.sc.appointment_manager.application.business.command.UpdateBusinessCommand;
import com.sc.appointment_manager.application.business.port.in.CreateBusinessUseCase;
import com.sc.appointment_manager.application.business.port.in.DeactivateBusinessUseCase;
import com.sc.appointment_manager.application.business.port.in.GetBusinessUseCase;
import com.sc.appointment_manager.application.business.port.in.UpdateBusinessUseCase;
import com.sc.appointment_manager.domain.business.Business;
import com.sc.appointment_manager.domain.business.exception.BusinessNotActiveException;
import com.sc.appointment_manager.domain.business.exception.BusinessNotFoundException;
import com.sc.appointment_manager.domain.business.port.BusinessRepository;
import com.sc.appointment_manager.domain.business.query.BusinessFilterQuery;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.time.OffsetDateTime;
import java.util.List;
import java.util.UUID;

@Service
@RequiredArgsConstructor
public class BusinessService implements
        CreateBusinessUseCase,
        GetBusinessUseCase,
        UpdateBusinessUseCase,
        DeactivateBusinessUseCase {

    private final BusinessRepository businessRepository;

    @Override
    @Transactional
    public Business createBusiness(CreateBusinessCommand command) {
        Business business = Business.builder()
                .id(UUID.randomUUID())
                .name(command.name())
                .type(command.type())
                .timezone(command.timezone())
                .phone(command.phone())
                .email(command.email())
                .address(command.address())
                .walkInsAllowed(command.walkInsAllowed())
                .cancellationHours(command.cancellationHours())
                .active(true)
                .createdAt(OffsetDateTime.now())
                .updatedAt(OffsetDateTime.now())
                .build();

        return businessRepository.save(business);
    }

    @Override
    @Transactional(readOnly = true)
    public Business getById(UUID id) {
        Business business = businessRepository.findById(id)
                .orElseThrow(() -> new BusinessNotFoundException(id));
        if (!business.isActive()) {
            throw new BusinessNotActiveException(id);
        }
        return business;
    }

    @Override
    @Transactional(readOnly = true)
    public List<Business> getAll(BusinessFilterQuery filter) {
        return businessRepository.findAll(filter);
    }

    @Override
    @Transactional
    public Business updateBusiness(UUID id, UpdateBusinessCommand command) {
        Business existing = businessRepository.findById(id)
                .orElseThrow(() -> new BusinessNotFoundException(id));
        if (!existing.isActive()) {
            throw new BusinessNotActiveException(id);
        }

        Business updated = existing.toBuilder()
                .name(command.name())
                .type(command.type())
                .timezone(command.timezone())
                .phone(command.phone())
                .email(command.email())
                .address(command.address())
                .walkInsAllowed(command.walkInsAllowed())
                .cancellationHours(command.cancellationHours())
                .updatedAt(OffsetDateTime.now())
                .build();

        return businessRepository.save(updated);
    }

    @Override
    @Transactional
    public void deactivateBusiness(UUID id) {
        Business existing = businessRepository.findById(id)
                .orElseThrow(() -> new BusinessNotFoundException(id));

        businessRepository.save(existing.toBuilder()
                .active(false)
                .updatedAt(OffsetDateTime.now())
                .build());
    }
}
