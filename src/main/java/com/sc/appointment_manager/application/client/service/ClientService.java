package com.sc.appointment_manager.application.client.service;

import com.sc.appointment_manager.application.client.command.CreateClientCommand;
import com.sc.appointment_manager.application.client.command.UpdateClientCommand;
import com.sc.appointment_manager.application.client.port.in.CreateClientUseCase;
import com.sc.appointment_manager.application.client.port.in.DeactivateClientUseCase;
import com.sc.appointment_manager.application.client.port.in.GetClientUseCase;
import com.sc.appointment_manager.application.client.port.in.UpdateClientUseCase;
import com.sc.appointment_manager.domain.client.Client;
import com.sc.appointment_manager.domain.client.exception.ClientNotActiveException;
import com.sc.appointment_manager.domain.client.exception.ClientNotFoundException;
import com.sc.appointment_manager.domain.client.port.ClientRepository;
import com.sc.appointment_manager.domain.client.query.ClientFilterQuery;
import lombok.RequiredArgsConstructor;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.time.OffsetDateTime;
import java.util.UUID;

@Service
@RequiredArgsConstructor
public class ClientService implements
        CreateClientUseCase,
        GetClientUseCase,
        UpdateClientUseCase,
        DeactivateClientUseCase {

    private final ClientRepository clientRepository;

    @Override
    @Transactional
    public Client createClient(CreateClientCommand command) {
        Client client = Client.builder()
                .id(UUID.randomUUID())
                .businessId(command.businessId())
                .name(command.name())
                .email(command.email())
                .phone(command.phone())
                .noShowCount(0)
                .flagged(false)
                .active(true)
                .createdAt(OffsetDateTime.now())
                .build();
        return clientRepository.save(client);
    }

    @Override
    @Transactional(readOnly = true)
    public Client getById(UUID id) {
        Client client = clientRepository.findById(id)
                .orElseThrow(() -> new ClientNotFoundException(id));
        if (!client.isActive()) {
            throw new ClientNotActiveException(id);
        }
        return client;
    }

    @Override
    @Transactional(readOnly = true)
    public Page<Client> getAll(ClientFilterQuery filter, Pageable pageable) {
        return clientRepository.findAll(filter, pageable);
    }

    @Override
    @Transactional
    public Client updateClient(UUID id, UpdateClientCommand command) {
        Client existing = clientRepository.findById(id)
                .orElseThrow(() -> new ClientNotFoundException(id));
        if (!existing.isActive()) {
            throw new ClientNotActiveException(id);
        }
        return clientRepository.save(existing.toBuilder()
                .name(command.name())
                .email(command.email())
                .phone(command.phone())
                .flagged(command.flagged())
                .build());
    }

    @Override
    @Transactional
    public void deactivateClient(UUID id) {
        Client existing = clientRepository.findById(id)
                .orElseThrow(() -> new ClientNotFoundException(id));
        clientRepository.save(existing.toBuilder()
                .active(false)
                .build());
    }
}
