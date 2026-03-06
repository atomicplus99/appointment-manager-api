package com.sc.appointment_manager.application.business.port.in;

import java.util.UUID;

public interface DeactivateBusinessUseCase {

    void deactivateBusiness(UUID id);
}
