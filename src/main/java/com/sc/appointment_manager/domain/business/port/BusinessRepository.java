package com.sc.appointment_manager.domain.business.port;

import com.sc.appointment_manager.domain.business.Business;
import com.sc.appointment_manager.domain.business.query.BusinessFilterQuery;

import java.util.List;
import java.util.Optional;
import java.util.UUID;

public interface BusinessRepository {

    Business save(Business business);

    Optional<Business> findById(UUID id);

    List<Business> findAll(BusinessFilterQuery filter);

    boolean existsById(UUID id);
}
