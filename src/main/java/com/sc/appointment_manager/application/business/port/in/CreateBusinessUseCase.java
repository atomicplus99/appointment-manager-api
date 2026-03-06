package com.sc.appointment_manager.application.business.port.in;

import com.sc.appointment_manager.application.business.command.CreateBusinessCommand;
import com.sc.appointment_manager.domain.business.Business;

public interface CreateBusinessUseCase {

    Business createBusiness(CreateBusinessCommand command);
}
