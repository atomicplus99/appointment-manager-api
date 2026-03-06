package com.sc.appointment_manager.interfaces.rest.auth.dto;

import io.swagger.v3.oas.annotations.media.Schema;

@Schema(description = "Respuesta de autenticación con tokens de acceso y refresco")
public record AuthResponse(
        @Schema(description = "Token JWT de acceso") String accessToken,
        @Schema(description = "Token de refresco (UUID)") String refreshToken,
        @Schema(description = "Tipo de token", example = "Bearer") String tokenType,
        @Schema(description = "Correo electrónico del usuario autenticado") String email,
        @Schema(description = "Rol del usuario", example = "OWNER") String role
) {
    public static AuthResponse of(String accessToken, String refreshToken, String email, String role) {
        return new AuthResponse(accessToken, refreshToken, "Bearer", email, role);
    }
}
