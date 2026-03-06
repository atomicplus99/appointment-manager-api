package com.sc.appointment_manager.domain.business.port;

import com.sc.appointment_manager.domain.business.Business;
import com.sc.appointment_manager.domain.business.query.BusinessFilterQuery;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;

import java.util.Optional;
import java.util.UUID;

public interface BusinessRepository {

    Business save(Business business);

    Optional<Business> findById(UUID id);

    Page<Business> findAll(BusinessFilterQuery filter, Pageable pageable);

    boolean existsById(UUID id);
}
