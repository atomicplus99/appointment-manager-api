package com.sc.appointment_manager.interfaces.rest.client.dto;

import io.swagger.v3.oas.annotations.media.Schema;
import jakarta.validation.constraints.Email;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotNull;

import java.util.UUID;

@Schema(description = "Datos para registrar un nuevo cliente")
public record CreateClientRequest(

        @Schema(description = "ID del negocio al que pertenece el cliente", example = "550e8400-e29b-41d4-a716-446655440000")
        @NotNull(message = "El ID del negocio es obligatorio")
        UUID businessId,

        @Schema(description = "Nombre completo del cliente", example = "Juan Pérez")
        @NotBlank(message = "El nombre es obligatorio")
        String name,

        @Schema(description = "Correo electrónico del cliente", example = "juan.perez@email.com")
        @Email(message = "El formato del correo electrónico es inválido")
        String email,

        @Schema(description = "Teléfono del cliente", example = "+51 987 654 321")
        String phone
) {}
