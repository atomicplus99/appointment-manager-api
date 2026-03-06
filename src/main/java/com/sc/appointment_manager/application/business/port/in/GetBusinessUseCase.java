package com.sc.appointment_manager.application.business.port.in;

import com.sc.appointment_manager.domain.business.Business;
import com.sc.appointment_manager.domain.business.query.BusinessFilterQuery;

import java.util.List;
import java.util.UUID;

public interface GetBusinessUseCase {

    Business getById(UUID id);

    List<Business> getAll(BusinessFilterQuery filter);
}
