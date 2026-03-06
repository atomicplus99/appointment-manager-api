package com.sc.appointment_manager.infrastructure.persistence.client;

import com.sc.appointment_manager.domain.client.Client;
import com.sc.appointment_manager.domain.client.port.ClientRepository;
import com.sc.appointment_manager.domain.client.query.ClientFilterQuery;
import lombok.RequiredArgsConstructor;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Component;

import java.util.Optional;
import java.util.UUID;

@Component
@RequiredArgsConstructor
public class ClientRepositoryAdapter implements ClientRepository {

    private final ClientJpaRepository jpaRepository;
    private final ClientMapper mapper;

    @Override
    public Client save(Client client) {
        return mapper.toDomain(jpaRepository.save(mapper.toEntity(client)));
    }

    @Override
    public Optional<Client> findById(UUID id) {
        return jpaRepository.findById(id).map(mapper::toDomain);
    }

    @Override
    public Page<Client> findAll(ClientFilterQuery filter, Pageable pageable) {
        return jpaRepository.findAll(ClientSpecification.withFilter(filter), pageable)
                .map(mapper::toDomain);
    }

    @Override
    public boolean existsById(UUID id) {
        return jpaRepository.existsById(id);
    }
}
