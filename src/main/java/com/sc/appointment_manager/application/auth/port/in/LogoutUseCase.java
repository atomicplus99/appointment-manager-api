package com.sc.appointment_manager.application.auth.port.in;

public interface LogoutUseCase {

    void logout(String refreshToken);
}
