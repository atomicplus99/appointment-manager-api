package com.sc.appointment_manager.domain.business.exception;

import java.util.UUID;

public class BusinessNotActiveException extends RuntimeException {

    public BusinessNotActiveException(UUID id) {
        super("El negocio con id '" + id + "' se encuentra inactivo");
    }
}
