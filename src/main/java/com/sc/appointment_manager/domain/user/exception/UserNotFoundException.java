package com.sc.appointment_manager.domain.user.exception;

import com.sc.appointment_manager.domain.shared.exception.DomainEntityNotFoundException;

import java.util.UUID;

public class UserNotFoundException extends DomainEntityNotFoundException {

    public UserNotFoundException(UUID id) {
        super("Usuario no encontrado con id: " + id);
    }

    public UserNotFoundException(String email) {
        super("Usuario no encontrado con email: " + email);
    }
}
