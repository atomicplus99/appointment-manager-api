package com.sc.appointment_manager.interfaces.rest.business;

import com.sc.appointment_manager.application.business.port.in.CreateBusinessUseCase;
import com.sc.appointment_manager.application.business.port.in.DeactivateBusinessUseCase;
import com.sc.appointment_manager.application.business.port.in.GetBusinessUseCase;
import com.sc.appointment_manager.application.business.port.in.UpdateBusinessOwnerUseCase;
import com.sc.appointment_manager.application.business.port.in.UpdateBusinessUseCase;
import com.sc.appointment_manager.domain.business.BusinessType;
import com.sc.appointment_manager.interfaces.rest.shared.CurrentUserProvider;
import com.sc.appointment_manager.interfaces.rest.business.dto.BusinessResponse;
import com.sc.appointment_manager.interfaces.rest.business.dto.CreateBusinessRequest;
import com.sc.appointment_manager.interfaces.rest.business.dto.UpdateBusinessOwnerRequest;
import com.sc.appointment_manager.interfaces.rest.business.dto.UpdateBusinessRequest;
import com.sc.appointment_manager.interfaces.rest.business.mapper.BusinessRestMapper;
import com.sc.appointment_manager.interfaces.rest.shared.dto.PageResponse;
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

@Tag(name = "Negocios", description = "Gestión de negocios registrados en la plataforma")
@SecurityRequirement(name = "bearerAuth")
@RestController
@RequestMapping("/api/v1/businesses")
@RequiredArgsConstructor
public class BusinessController {

    private final CreateBusinessUseCase createBusinessUseCase;
    private final GetBusinessUseCase getBusinessUseCase;
    private final UpdateBusinessUseCase updateBusinessUseCase;
    private final UpdateBusinessOwnerUseCase updateBusinessOwnerUseCase;
    private final DeactivateBusinessUseCase deactivateBusinessUseCase;
    private final CurrentUserProvider currentUserProvider;
    private final BusinessRestMapper mapper;

    @Operation(summary = "Crear negocio", description = "Registra un nuevo negocio en la plataforma. Solo accesible por ADMIN.")
    @ApiResponses({
            @ApiResponse(responseCode = "201", description = "Negocio creado correctamente"),
            @ApiResponse(responseCode = "400", description = "Datos de entrada inválidos", content = @Content),
            @ApiResponse(responseCode = "401", description = "No autenticado", content = @Content),
            @ApiResponse(responseCode = "403", description = "Sin permisos suficientes", content = @Content)
    })
    @PostMapping
    public ResponseEntity<BusinessResponse> create(@Valid @RequestBody CreateBusinessRequest request) {
        BusinessResponse response = BusinessResponse.from(
                createBusinessUseCase.createBusiness(mapper.toCommand(request))
        );
        return ResponseEntity.status(HttpStatus.CREATED).body(response);
    }

    @Operation(summary = "Obtener negocio por ID", description = "Devuelve los datos de un negocio activo.")
    @ApiResponses({
            @ApiResponse(responseCode = "200", description = "Negocio encontrado"),
            @ApiResponse(responseCode = "401", description = "No autenticado", content = @Content),
            @ApiResponse(responseCode = "404", description = "Negocio no encontrado o inactivo", content = @Content)
    })
    @GetMapping("/{id}")
    public ResponseEntity<BusinessResponse> getById(
            @Parameter(description = "ID del negocio") @PathVariable UUID id) {
        return ResponseEntity.ok(BusinessResponse.from(
                getBusinessUseCase.getById(id, currentUserProvider.getCurrentUserBusinessId())));
    }

    @Operation(summary = "Listar negocios", description = "Devuelve una lista paginada de negocios con filtros opcionales.")
    @ApiResponses({
            @ApiResponse(responseCode = "200", description = "Lista obtenida correctamente"),
            @ApiResponse(responseCode = "401", description = "No autenticado", content = @Content)
    })
    @GetMapping
    public ResponseEntity<PageResponse<BusinessResponse>> getAll(
            @Parameter(description = "Filtrar por nombre (búsqueda parcial)") @RequestParam(required = false) String name,
            @Parameter(description = "Filtrar por tipo de negocio") @RequestParam(required = false) BusinessType type,
            @Parameter(description = "Filtrar por estado activo/inactivo") @RequestParam(required = false) Boolean active,
            @Parameter(description = "Filtrar por admisión sin cita") @RequestParam(required = false) Boolean walkInsAllowed,
            @Parameter(description = "Filtrar por zona horaria") @RequestParam(required = false) String timezone,
            @PageableDefault(size = 20) Pageable pageable) {
        return ResponseEntity.ok(PageResponse.from(
                getBusinessUseCase
                        .getAll(mapper.toQuery(name, type, active, walkInsAllowed, timezone,
                                currentUserProvider.getCurrentUserBusinessId()), pageable)
                        .map(BusinessResponse::from)
        ));
    }

    @Operation(summary = "Actualizar negocio completo (ADMIN)", description = "Actualiza todos los campos del negocio. Solo accesible por ADMIN.")
    @ApiResponses({
            @ApiResponse(responseCode = "200", description = "Negocio actualizado correctamente"),
            @ApiResponse(responseCode = "400", description = "Datos de entrada inválidos", content = @Content),
            @ApiResponse(responseCode = "401", description = "No autenticado", content = @Content),
            @ApiResponse(responseCode = "403", description = "Sin permisos suficientes", content = @Content),
            @ApiResponse(responseCode = "404", description = "Negocio no encontrado o inactivo", content = @Content)
    })
    @PutMapping("/{id}")
    public ResponseEntity<BusinessResponse> update(
            @Parameter(description = "ID del negocio") @PathVariable UUID id,
            @Valid @RequestBody UpdateBusinessRequest request) {
        return ResponseEntity.ok(BusinessResponse.from(
                updateBusinessUseCase.updateBusiness(id, mapper.toCommand(request))
        ));
    }

    @Operation(summary = "Actualizar negocio propio (OWNER)", description = "Permite al propietario actualizar nombre, teléfono, email, dirección, admisión sin cita y horas de cancelación de su propio negocio.")
    @ApiResponses({
            @ApiResponse(responseCode = "200", description = "Negocio actualizado correctamente"),
            @ApiResponse(responseCode = "400", description = "Datos de entrada inválidos", content = @Content),
            @ApiResponse(responseCode = "401", description = "No autenticado", content = @Content),
            @ApiResponse(responseCode = "403", description = "Sin permisos o el negocio no le pertenece", content = @Content),
            @ApiResponse(responseCode = "404", description = "Negocio no encontrado o inactivo", content = @Content)
    })
    @PatchMapping("/{id}")
    public ResponseEntity<BusinessResponse> updateByOwner(
            @Parameter(description = "ID del negocio") @PathVariable UUID id,
            @Valid @RequestBody UpdateBusinessOwnerRequest request) {
        return ResponseEntity.ok(BusinessResponse.from(
                updateBusinessOwnerUseCase.updateBusinessByOwner(id, mapper.toOwnerCommand(request),
                        currentUserProvider.getCurrentUserBusinessId())
        ));
    }

    @Operation(summary = "Desactivar negocio", description = "Desactiva un negocio. ADMIN puede desactivar cualquiera; OWNER solo el suyo.")
    @ApiResponses({
            @ApiResponse(responseCode = "204", description = "Negocio desactivado correctamente"),
            @ApiResponse(responseCode = "401", description = "No autenticado", content = @Content),
            @ApiResponse(responseCode = "403", description = "Sin permisos o el negocio no le pertenece", content = @Content),
            @ApiResponse(responseCode = "404", description = "Negocio no encontrado", content = @Content)
    })
    @DeleteMapping("/{id}")
    public ResponseEntity<Void> deactivate(
            @Parameter(description = "ID del negocio") @PathVariable UUID id) {
        deactivateBusinessUseCase.deactivateBusiness(id, currentUserProvider.getCurrentUserBusinessId());
        return ResponseEntity.noContent().build();
    }
}
