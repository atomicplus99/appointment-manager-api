package com.sc.appointment_manager.domain.business.exception;

import com.sc.appointment_manager.domain.shared.exception.DomainEntityNotFoundException;

import java.util.UUID;

public class BusinessNotFoundException extends DomainEntityNotFoundException {

    public BusinessNotFoundException(UUID id) {
        super("Negocio no encontrado con el id: '" + id + "'");
    }
}
