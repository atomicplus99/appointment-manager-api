package com.sc.appointment_manager.interfaces.rest.auth.dto;

import io.swagger.v3.oas.annotations.media.Schema;
import jakarta.validation.constraints.NotBlank;

@Schema(description = "Datos de acceso para iniciar sesión")
public record LoginRequest(
        @Schema(description = "Correo electrónico del usuario", example = "luis@barberiaelmaestro.pe")
        @NotBlank(message = "El email es obligatorio") String email,

        @Schema(description = "Contraseña del usuario", example = "admin123")
        @NotBlank(message = "La contraseña es obligatoria") String password
) {
}
