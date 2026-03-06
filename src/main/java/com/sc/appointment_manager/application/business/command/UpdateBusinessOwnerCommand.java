package com.sc.appointment_manager.application.business.command;

public record UpdateBusinessOwnerCommand(
        String name,
        String phone,
        String email,
        String address,
        boolean walkInsAllowed,
        int cancellationHours
) {}
