package com.sc.appointment_manager.interfaces.rest.business.dto;

import com.sc.appointment_manager.domain.business.BusinessType;
import jakarta.validation.constraints.Email;
import jakarta.validation.constraints.Min;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotNull;

public record UpdateBusinessRequest(

        @NotBlank(message = "El nombre es obligatorio")
        String name,

        @NotNull(message = "El tipo de negocio es obligatorio")
        BusinessType type,

        @NotBlank(message = "La zona horaria es obligatoria")
        String timezone,

        String phone,

        @Email(message = "El formato del correo electrónico es inválido")
        String email,

        String address,

        boolean walkInsAllowed,

        @Min(value = 0, message = "Las horas de cancelación deben ser 0 o más")
        int cancellationHours
) {}
