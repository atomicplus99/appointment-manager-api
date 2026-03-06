package com.sc.appointment_manager.domain.user.exception;

import com.sc.appointment_manager.domain.shared.exception.DomainEntityNotActiveException;

import java.util.UUID;

public class UserNotActiveException extends DomainEntityNotActiveException {

    public UserNotActiveException(UUID id) {
        super("Usuario inactivo con id: " + id);
    }
}
