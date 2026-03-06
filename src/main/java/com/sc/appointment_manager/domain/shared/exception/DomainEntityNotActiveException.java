package com.sc.appointment_manager.domain.shared.exception;

public abstract class DomainEntityNotActiveException extends RuntimeException {
    protected DomainEntityNotActiveException(String message) {
        super(message);
    }
}
