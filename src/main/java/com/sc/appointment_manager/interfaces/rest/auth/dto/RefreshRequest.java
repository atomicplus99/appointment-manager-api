package com.sc.appointment_manager.interfaces.rest.auth.dto;

import jakarta.validation.constraints.NotBlank;

public record RefreshRequest(
        @NotBlank(message = "El token de refresco es obligatorio") String refreshToken
) {
}
