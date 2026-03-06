package com.sc.appointment_manager.interfaces.rest.auth.dto;

import io.swagger.v3.oas.annotations.media.Schema;
import jakarta.validation.constraints.NotBlank;

@Schema(description = "Token de refresco para renovar o cerrar sesión")
public record RefreshRequest(
        @Schema(description = "Token de refresco obtenido al iniciar sesión", example = "550e8400-e29b-41d4-a716-446655440000")
        @NotBlank(message = "El token de refresco es obligatorio") String refreshToken
) {
}
