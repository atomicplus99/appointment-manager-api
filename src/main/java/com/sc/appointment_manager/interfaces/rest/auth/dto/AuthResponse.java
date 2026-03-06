package com.sc.appointment_manager.interfaces.rest.auth.dto;

public record AuthResponse(
        String accessToken,
        String refreshToken,
        String tokenType,
        String email,
        String role
) {
    public static AuthResponse of(String accessToken, String refreshToken, String email, String role) {
        return new AuthResponse(accessToken, refreshToken, "Bearer", email, role);
    }
}
