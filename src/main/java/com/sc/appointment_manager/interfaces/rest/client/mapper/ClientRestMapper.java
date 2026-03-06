package com.sc.appointment_manager.interfaces.rest.client.mapper;

import com.sc.appointment_manager.application.client.command.CreateClientCommand;
import com.sc.appointment_manager.application.client.command.UpdateClientCommand;
import com.sc.appointment_manager.domain.client.query.ClientFilterQuery;
import com.sc.appointment_manager.interfaces.rest.client.dto.CreateClientRequest;
import com.sc.appointment_manager.interfaces.rest.client.dto.UpdateClientRequest;
import org.springframework.stereotype.Component;

import java.util.UUID;

@Component
public class ClientRestMapper {

    public CreateClientCommand toCommand(CreateClientRequest request) {
        return new CreateClientCommand(
                request.businessId(),
                request.name(),
                request.email(),
                request.phone()
        );
    }

    public UpdateClientCommand toCommand(UpdateClientRequest request) {
        return new UpdateClientCommand(
                request.name(),
                request.email(),
                request.phone(),
                request.flagged()
        );
    }

    public ClientFilterQuery toQuery(UUID businessId, String name, String email,
                                     Boolean flagged, Boolean active) {
        return new ClientFilterQuery(businessId, name, email, flagged, active);
    }
}
