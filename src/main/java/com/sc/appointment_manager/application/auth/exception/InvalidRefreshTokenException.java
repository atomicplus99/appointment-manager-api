package com.sc.appointment_manager.application.auth.exception;

public class InvalidRefreshTokenException extends RuntimeException {

    public InvalidRefreshTokenException() {
        super("Token de refresco inválido o expirado");
    }
}
