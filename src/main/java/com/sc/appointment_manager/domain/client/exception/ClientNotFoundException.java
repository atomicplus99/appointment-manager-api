package com.sc.appointment_manager.domain.client.exception;

import com.sc.appointment_manager.domain.shared.exception.DomainEntityNotFoundException;

import java.util.UUID;

public class ClientNotFoundException extends DomainEntityNotFoundException {

    public ClientNotFoundException(UUID id) {
        super("Cliente no encontrado con el id: '" + id + "'");
    }
}
