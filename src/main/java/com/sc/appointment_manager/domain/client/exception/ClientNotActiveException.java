package com.sc.appointment_manager.domain.client.exception;

import com.sc.appointment_manager.domain.shared.exception.DomainEntityNotActiveException;

import java.util.UUID;

public class ClientNotActiveException extends DomainEntityNotActiveException {

    public ClientNotActiveException(UUID id) {
        super("El cliente con id '" + id + "' se encuentra inactivo");
    }
}
