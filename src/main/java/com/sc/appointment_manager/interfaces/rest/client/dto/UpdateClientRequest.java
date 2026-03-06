package com.sc.appointment_manager.interfaces.rest.client.dto;

import jakarta.validation.constraints.Email;
import jakarta.validation.constraints.NotBlank;

public record UpdateClientRequest(

        @NotBlank(message = "El nombre es obligatorio")
        String name,

        @Email(message = "El formato del correo electrónico es inválido")
        String email,

        String phone,

        boolean flagged
) {}
