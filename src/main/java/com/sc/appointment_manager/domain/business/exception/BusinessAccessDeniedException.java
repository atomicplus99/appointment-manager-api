package com.sc.appointment_manager.domain.business.exception;

import java.util.UUID;

public class BusinessAccessDeniedException extends RuntimeException {
    public BusinessAccessDeniedException(UUID businessId) {
        super("No tienes permiso para modificar el negocio con id: " + businessId);
    }
}
