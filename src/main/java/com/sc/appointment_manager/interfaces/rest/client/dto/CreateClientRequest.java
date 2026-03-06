package com.sc.appointment_manager.interfaces.rest.client.dto;

import jakarta.validation.constraints.Email;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotNull;

import java.util.UUID;

public record CreateClientRequest(

        @NotNull(message = "El ID del negocio es obligatorio")
        UUID businessId,

        @NotBlank(message = "El nombre es obligatorio")
        String name,

        @Email(message = "El formato del correo electrónico es inválido")
        String email,

        String phone
) {}
