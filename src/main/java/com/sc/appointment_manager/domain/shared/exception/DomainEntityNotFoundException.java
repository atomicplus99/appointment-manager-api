package com.sc.appointment_manager.domain.shared.exception;

public abstract class DomainEntityNotFoundException extends RuntimeException {
    protected DomainEntityNotFoundException(String message) {
        super(message);
    }
}
