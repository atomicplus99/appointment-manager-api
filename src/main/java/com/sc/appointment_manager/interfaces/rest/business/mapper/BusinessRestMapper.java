package com.sc.appointment_manager.interfaces.rest.business.mapper;

import com.sc.appointment_manager.application.business.command.CreateBusinessCommand;
import com.sc.appointment_manager.application.business.command.UpdateBusinessCommand;
import com.sc.appointment_manager.application.business.command.UpdateBusinessOwnerCommand;
import com.sc.appointment_manager.domain.business.BusinessType;
import com.sc.appointment_manager.domain.business.query.BusinessFilterQuery;
import com.sc.appointment_manager.interfaces.rest.business.dto.CreateBusinessRequest;
import com.sc.appointment_manager.interfaces.rest.business.dto.UpdateBusinessOwnerRequest;
import com.sc.appointment_manager.interfaces.rest.business.dto.UpdateBusinessRequest;
import org.springframework.stereotype.Component;

import java.util.UUID;

@Component
public class BusinessRestMapper {

    public CreateBusinessCommand toCommand(CreateBusinessRequest request) {
        return new CreateBusinessCommand(
                request.name(),
                request.type(),
                request.timezone(),
                request.phone(),
                request.email(),
                request.address(),
                request.walkInsAllowed(),
                request.cancellationHours()
        );
    }

    public UpdateBusinessCommand toCommand(UpdateBusinessRequest request) {
        return new UpdateBusinessCommand(
                request.name(),
                request.type(),
                request.timezone(),
                request.phone(),
                request.email(),
                request.address(),
                request.walkInsAllowed(),
                request.cancellationHours()
        );
    }

    public UpdateBusinessOwnerCommand toOwnerCommand(UpdateBusinessOwnerRequest request) {
        return new UpdateBusinessOwnerCommand(
                request.name(),
                request.phone(),
                request.email(),
                request.address(),
                request.walkInsAllowed(),
                request.cancellationHours()
        );
    }

    public BusinessFilterQuery toQuery(String name, BusinessType type, Boolean active,
                                       Boolean walkInsAllowed, String timezone, UUID callerBusinessId) {
        return new BusinessFilterQuery(callerBusinessId, name, type, active, walkInsAllowed, timezone);
    }
}
