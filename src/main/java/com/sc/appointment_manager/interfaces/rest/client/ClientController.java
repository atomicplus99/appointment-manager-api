package com.sc.appointment_manager.interfaces.rest.client;

import com.sc.appointment_manager.application.client.port.in.CreateClientUseCase;
import com.sc.appointment_manager.application.client.port.in.DeactivateClientUseCase;
import com.sc.appointment_manager.application.client.port.in.GetClientUseCase;
import com.sc.appointment_manager.application.client.port.in.UpdateClientUseCase;
import com.sc.appointment_manager.interfaces.rest.client.dto.ClientResponse;
import com.sc.appointment_manager.interfaces.rest.client.dto.CreateClientRequest;
import com.sc.appointment_manager.interfaces.rest.client.dto.UpdateClientRequest;
import com.sc.appointment_manager.interfaces.rest.client.mapper.ClientRestMapper;
import com.sc.appointment_manager.interfaces.rest.shared.dto.PageResponse;
import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;
import org.springframework.data.domain.Pageable;
import org.springframework.data.web.PageableDefault;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.UUID;

@RestController
@RequestMapping("/api/v1/clients")
@RequiredArgsConstructor
public class ClientController {

    private final CreateClientUseCase createClientUseCase;
    private final GetClientUseCase getClientUseCase;
    private final UpdateClientUseCase updateClientUseCase;
    private final DeactivateClientUseCase deactivateClientUseCase;
    private final ClientRestMapper mapper;

    @PostMapping
    public ResponseEntity<ClientResponse> create(@Valid @RequestBody CreateClientRequest request) {
        return ResponseEntity.status(HttpStatus.CREATED)
                .body(ClientResponse.from(createClientUseCase.createClient(mapper.toCommand(request))));
    }

    @GetMapping("/{id}")
    public ResponseEntity<ClientResponse> getById(@PathVariable UUID id) {
        return ResponseEntity.ok(ClientResponse.from(getClientUseCase.getById(id)));
    }

    @GetMapping
    public ResponseEntity<PageResponse<ClientResponse>> getAll(
            @RequestParam(required = false) UUID businessId,
            @RequestParam(required = false) String name,
            @RequestParam(required = false) String email,
            @RequestParam(required = false) Boolean flagged,
            @RequestParam(required = false) Boolean active,
            @PageableDefault(size = 20) Pageable pageable) {
        return ResponseEntity.ok(PageResponse.from(
                getClientUseCase
                        .getAll(mapper.toQuery(businessId, name, email, flagged, active), pageable)
                        .map(ClientResponse::from)
        ));
    }

    @PutMapping("/{id}")
    public ResponseEntity<ClientResponse> update(
            @PathVariable UUID id,
            @Valid @RequestBody UpdateClientRequest request) {
        return ResponseEntity.ok(
                ClientResponse.from(updateClientUseCase.updateClient(id, mapper.toCommand(request))));
    }

    @DeleteMapping("/{id}")
    public ResponseEntity<Void> deactivate(@PathVariable UUID id) {
        deactivateClientUseCase.deactivateClient(id);
        return ResponseEntity.noContent().build();
    }
}
