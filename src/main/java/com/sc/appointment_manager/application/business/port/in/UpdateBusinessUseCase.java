package com.sc.appointment_manager.application.business.port.in;

import com.sc.appointment_manager.application.business.command.UpdateBusinessCommand;
import com.sc.appointment_manager.domain.business.Business;

import java.util.UUID;

public interface UpdateBusinessUseCase {

    Business updateBusiness(UUID id, UpdateBusinessCommand command);
}
