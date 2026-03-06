package com.sc.appointment_manager.application.client.port.in;

import java.util.UUID;

public interface DeactivateClientUseCase {
    void deactivateClient(UUID id, UUID callerBusinessId);
}
