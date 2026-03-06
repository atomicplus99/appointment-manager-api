package com.sc.appointment_manager.interfaces.rest.business.dto;

import io.swagger.v3.oas.annotations.media.Schema;
import jakarta.validation.constraints.Email;
import jakarta.validation.constraints.Min;
import jakarta.validation.constraints.NotBlank;

@Schema(description = "Datos que el propietario puede actualizar de su propio negocio")
public record UpdateBusinessOwnerRequest(

        @Schema(description = "Nombre del negocio", example = "Barbería El Maestro")
        @NotBlank(message = "El nombre es obligatorio")
        String name,

        @Schema(description = "Teléfono de contacto", example = "+51 987 654 321")
        String phone,

        @Schema(description = "Correo electrónico de contacto", example = "contacto@barberiaelmaestro.pe")
        @Email(message = "El formato del correo electrónico es inválido")
        String email,

        @Schema(description = "Dirección física del negocio", example = "Av. Larco 1234, Miraflores, Lima")
        String address,

        @Schema(description = "Indica si se aceptan clientes sin cita previa", example = "true")
        boolean walkInsAllowed,

        @Schema(description = "Horas mínimas de anticipación para cancelar una cita", example = "24")
        @Min(value = 0, message = "Las horas de cancelación deben ser 0 o más")
        int cancellationHours
) {}
