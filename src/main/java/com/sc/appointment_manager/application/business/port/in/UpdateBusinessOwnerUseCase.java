package com.sc.appointment_manager.application.business.port.in;

import com.sc.appointment_manager.application.business.command.UpdateBusinessOwnerCommand;
import com.sc.appointment_manager.domain.business.Business;

import java.util.UUID;

public interface UpdateBusinessOwnerUseCase {
    Business updateBusinessByOwner(UUID id, UpdateBusinessOwnerCommand command, UUID callerBusinessId);
}
