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
import com.sc.appointment_manager.interfaces.rest.shared.CurrentUserProvider;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.Parameter;
import io.swagger.v3.oas.annotations.media.Content;
import io.swagger.v3.oas.annotations.responses.ApiResponse;
import io.swagger.v3.oas.annotations.responses.ApiResponses;
import io.swagger.v3.oas.annotations.security.SecurityRequirement;
import io.swagger.v3.oas.annotations.tags.Tag;
import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;
import org.springframework.data.domain.Pageable;
import org.springframework.data.web.PageableDefault;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.UUID;

@Tag(name = "Clientes", description = "Gestión de clientes asociados a un negocio")
@SecurityRequirement(name = "bearerAuth")
@RestController
@RequestMapping("/api/v1/clients")
@RequiredArgsConstructor
public class ClientController {

    private final CreateClientUseCase createClientUseCase;
    private final GetClientUseCase getClientUseCase;
    private final UpdateClientUseCase updateClientUseCase;
    private final DeactivateClientUseCase deactivateClientUseCase;
    private final CurrentUserProvider currentUserProvider;
    private final ClientRestMapper mapper;

    @Operation(summary = "Crear cliente", description = "Registra un nuevo cliente asociado a un negocio.")
    @ApiResponses({
            @ApiResponse(responseCode = "201", description = "Cliente creado correctamente"),
            @ApiResponse(responseCode = "400", description = "Datos de entrada inválidos", content = @Content),
            @ApiResponse(responseCode = "401", description = "No autenticado", content = @Content)
    })
    @PostMapping
    public ResponseEntity<ClientResponse> create(@Valid @RequestBody CreateClientRequest request) {
        return ResponseEntity.status(HttpStatus.CREATED).body(ClientResponse.from(
                createClientUseCase.createClient(
                        mapper.toCommand(request, currentUserProvider.getCurrentUserBusinessId()))));
    }

    @Operation(summary = "Obtener cliente por ID", description = "Devuelve los datos de un cliente activo.")
    @ApiResponses({
            @ApiResponse(responseCode = "200", description = "Cliente encontrado"),
            @ApiResponse(responseCode = "401", description = "No autenticado", content = @Content),
            @ApiResponse(responseCode = "404", description = "Cliente no encontrado o inactivo", content = @Content)
    })
    @GetMapping("/{id}")
    public ResponseEntity<ClientResponse> getById(
            @Parameter(description = "ID del cliente") @PathVariable UUID id) {
        return ResponseEntity.ok(ClientResponse.from(
                getClientUseCase.getById(id, currentUserProvider.getCurrentUserBusinessId())));
    }

    @Operation(summary = "Listar clientes", description = "Devuelve una lista paginada de clientes con filtros opcionales.")
    @ApiResponses({
            @ApiResponse(responseCode = "200", description = "Lista obtenida correctamente"),
            @ApiResponse(responseCode = "401", description = "No autenticado", content = @Content)
    })
    @GetMapping
    public ResponseEntity<PageResponse<ClientResponse>> getAll(
            @Parameter(description = "Filtrar por ID del negocio (ignorado para OWNER y STAFF)") @RequestParam(required = false) UUID businessId,
            @Parameter(description = "Filtrar por nombre (búsqueda parcial)") @RequestParam(required = false) String name,
            @Parameter(description = "Filtrar por email (búsqueda parcial)") @RequestParam(required = false) String email,
            @Parameter(description = "Filtrar por clientes marcados como problemáticos") @RequestParam(required = false) Boolean flagged,
            @Parameter(description = "Filtrar por estado activo/inactivo") @RequestParam(required = false) Boolean active,
            @PageableDefault(size = 20) Pageable pageable) {
        UUID callerBusinessId = currentUserProvider.getCurrentUserBusinessId();
        UUID effectiveBusinessId = callerBusinessId != null ? callerBusinessId : businessId;
        return ResponseEntity.ok(PageResponse.from(
                getClientUseCase
                        .getAll(mapper.toQuery(effectiveBusinessId, name, email, flagged, active), pageable)
                        .map(ClientResponse::from)
        ));
    }

    @Operation(summary = "Actualizar cliente", description = "Actualiza los datos de un cliente activo.")
    @ApiResponses({
            @ApiResponse(responseCode = "200", description = "Cliente actualizado correctamente"),
            @ApiResponse(responseCode = "400", description = "Datos de entrada inválidos", content = @Content),
            @ApiResponse(responseCode = "401", description = "No autenticado", content = @Content),
            @ApiResponse(responseCode = "404", description = "Cliente no encontrado o inactivo", content = @Content)
    })
    @PutMapping("/{id}")
    public ResponseEntity<ClientResponse> update(
            @Parameter(description = "ID del cliente") @PathVariable UUID id,
            @Valid @RequestBody UpdateClientRequest request) {
        return ResponseEntity.ok(ClientResponse.from(
                updateClientUseCase.updateClient(id, mapper.toCommand(request),
                        currentUserProvider.getCurrentUserBusinessId())));
    }

    @Operation(summary = "Desactivar cliente", description = "Desactiva un cliente. La operación es irreversible desde la API.")
    @ApiResponses({
            @ApiResponse(responseCode = "204", description = "Cliente desactivado correctamente"),
            @ApiResponse(responseCode = "401", description = "No autenticado", content = @Content),
            @ApiResponse(responseCode = "404", description = "Cliente no encontrado", content = @Content)
    })
    @DeleteMapping("/{id}")
    public ResponseEntity<Void> deactivate(
            @Parameter(description = "ID del cliente") @PathVariable UUID id) {
        deactivateClientUseCase.deactivateClient(id, currentUserProvider.getCurrentUserBusinessId());
        return ResponseEntity.noContent().build();
    }
}
