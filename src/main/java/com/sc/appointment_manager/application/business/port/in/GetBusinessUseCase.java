package com.sc.appointment_manager.application.business.port.in;

import com.sc.appointment_manager.domain.business.Business;
import com.sc.appointment_manager.domain.business.query.BusinessFilterQuery;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;

import java.util.UUID;

public interface GetBusinessUseCase {

    Business getById(UUID id);

    Page<Business> getAll(BusinessFilterQuery filter, Pageable pageable);
}
