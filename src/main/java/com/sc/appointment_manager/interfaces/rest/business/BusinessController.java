package com.sc.appointment_manager.interfaces.rest.business;

import com.sc.appointment_manager.application.business.port.in.CreateBusinessUseCase;
import com.sc.appointment_manager.application.business.port.in.DeactivateBusinessUseCase;
import com.sc.appointment_manager.application.business.port.in.GetBusinessUseCase;
import com.sc.appointment_manager.application.business.port.in.UpdateBusinessUseCase;
import com.sc.appointment_manager.domain.business.BusinessType;
import com.sc.appointment_manager.interfaces.rest.business.dto.BusinessResponse;
import com.sc.appointment_manager.interfaces.rest.business.dto.CreateBusinessRequest;
import com.sc.appointment_manager.interfaces.rest.business.dto.UpdateBusinessRequest;
import com.sc.appointment_manager.interfaces.rest.business.mapper.BusinessRestMapper;
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
@RequestMapping("/api/v1/businesses")
@RequiredArgsConstructor
public class BusinessController {

    private final CreateBusinessUseCase createBusinessUseCase;
    private final GetBusinessUseCase getBusinessUseCase;
    private final UpdateBusinessUseCase updateBusinessUseCase;
    private final DeactivateBusinessUseCase deactivateBusinessUseCase;
    private final BusinessRestMapper mapper;

    @PostMapping
    public ResponseEntity<BusinessResponse> create(@Valid @RequestBody CreateBusinessRequest request) {
        BusinessResponse response = BusinessResponse.from(
                createBusinessUseCase.createBusiness(mapper.toCommand(request))
        );
        return ResponseEntity.status(HttpStatus.CREATED).body(response);
    }

    @GetMapping("/{id}")
    public ResponseEntity<BusinessResponse> getById(@PathVariable UUID id) {
        return ResponseEntity.ok(BusinessResponse.from(getBusinessUseCase.getById(id)));
    }

    @GetMapping
    public ResponseEntity<PageResponse<BusinessResponse>> getAll(
            @RequestParam(required = false) String name,
            @RequestParam(required = false) BusinessType type,
            @RequestParam(required = false) Boolean active,
            @RequestParam(required = false) Boolean walkInsAllowed,
            @RequestParam(required = false) String timezone,
            @PageableDefault(size = 20) Pageable pageable) {
        return ResponseEntity.ok(PageResponse.from(
                getBusinessUseCase
                        .getAll(mapper.toQuery(name, type, active, walkInsAllowed, timezone), pageable)
                        .map(BusinessResponse::from)
        ));
    }

    @PutMapping("/{id}")
    public ResponseEntity<BusinessResponse> update(
            @PathVariable UUID id,
            @Valid @RequestBody UpdateBusinessRequest request) {
        BusinessResponse response = BusinessResponse.from(
                updateBusinessUseCase.updateBusiness(id, mapper.toCommand(request))
        );
        return ResponseEntity.ok(response);
    }

    @DeleteMapping("/{id}")
    public ResponseEntity<Void> deactivate(@PathVariable UUID id) {
        deactivateBusinessUseCase.deactivateBusiness(id);
        return ResponseEntity.noContent().build();
    }
}
