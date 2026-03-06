package com.sc.appointment_manager.domain.business.exception;

import com.sc.appointment_manager.domain.shared.exception.DomainEntityNotActiveException;

import java.util.UUID;

public class BusinessNotActiveException extends DomainEntityNotActiveException {

    public BusinessNotActiveException(UUID id) {
        super("El negocio con id '" + id + "' se encuentra inactivo");
    }
}
