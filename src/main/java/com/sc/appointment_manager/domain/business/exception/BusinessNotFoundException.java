package com.sc.appointment_manager.domain.business.exception;

import java.util.UUID;

public class BusinessNotFoundException extends RuntimeException {

    public BusinessNotFoundException(UUID id) {
        super("Negocio no encontrado con el id: '" + id + "'");
    }
}
