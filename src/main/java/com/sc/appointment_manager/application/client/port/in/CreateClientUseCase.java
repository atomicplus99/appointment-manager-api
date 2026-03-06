package com.sc.appointment_manager.application.client.port.in;

import com.sc.appointment_manager.application.client.command.CreateClientCommand;
import com.sc.appointment_manager.domain.client.Client;

public interface CreateClientUseCase {
    Client createClient(CreateClientCommand command);
}
