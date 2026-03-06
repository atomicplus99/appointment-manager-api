package com.sc.appointment_manager.application.client.port.in;

import com.sc.appointment_manager.application.client.command.UpdateClientCommand;
import com.sc.appointment_manager.domain.client.Client;

import java.util.UUID;

public interface UpdateClientUseCase {
    Client updateClient(UUID id, UpdateClientCommand command, UUID callerBusinessId);
}
