package com.sc.appointment_manager.application.auth.port.in;

import com.sc.appointment_manager.interfaces.rest.auth.dto.AuthResponse;

public interface RefreshTokenUseCase {

    AuthResponse refresh(String refreshToken);
}
