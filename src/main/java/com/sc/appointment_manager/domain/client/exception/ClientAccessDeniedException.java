package com.sc.appointment_manager.domain.client.exception;

import java.util.UUID;

public class ClientAccessDeniedException extends RuntimeException {
    public ClientAccessDeniedException(UUID id) {
        super("No tienes permiso para acceder al cliente con id: " + id);
    }
}
