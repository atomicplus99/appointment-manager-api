package com.sc.appointment_manager.application.client.command;

public record UpdateClientCommand(
        String name,
        String email,
        String phone,
        boolean flagged
) {}
