package com.sc.appointment_manager.interfaces.rest.client.dto;

import io.swagger.v3.oas.annotations.media.Schema;
import jakarta.validation.constraints.Email;
import jakarta.validation.constraints.NotBlank;

@Schema(description = "Datos para actualizar un cliente existente")
public record UpdateClientRequest(

        @Schema(description = "Nombre completo del cliente", example = "Juan Pérez")
        @NotBlank(message = "El nombre es obligatorio")
        String name,

        @Schema(description = "Correo electrónico del cliente", example = "juan.perez@email.com")
        @Email(message = "El formato del correo electrónico es inválido")
        String email,

        @Schema(description = "Teléfono del cliente", example = "+51 987 654 321")
        String phone,

        @Schema(description = "Indica si el cliente está marcado como problemático", example = "false")
        boolean flagged
) {}
