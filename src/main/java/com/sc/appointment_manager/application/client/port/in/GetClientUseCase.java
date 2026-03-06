package com.sc.appointment_manager.application.client.port.in;

import com.sc.appointment_manager.domain.client.Client;
import com.sc.appointment_manager.domain.client.query.ClientFilterQuery;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;

import java.util.UUID;

public interface GetClientUseCase {
    Client getById(UUID id, UUID callerBusinessId);
    Page<Client> getAll(ClientFilterQuery filter, Pageable pageable);
}
