package com.sc.appointment_manager.domain.client.port;

import com.sc.appointment_manager.domain.client.Client;
import com.sc.appointment_manager.domain.client.query.ClientFilterQuery;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;

import java.util.Optional;
import java.util.UUID;

public interface ClientRepository {

    Client save(Client client);

    Optional<Client> findById(UUID id);

    Page<Client> findAll(ClientFilterQuery filter, Pageable pageable);

    boolean existsById(UUID id);
}
