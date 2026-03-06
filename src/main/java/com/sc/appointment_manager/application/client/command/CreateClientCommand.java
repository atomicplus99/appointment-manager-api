package com.sc.appointment_manager.application.client.command;

import java.util.UUID;

public record CreateClientCommand(
        UUID callerBusinessId,
        UUID businessId,
        String name,
        String email,
        String phone
) {}
