package com.sc.appointment_manager.interfaces.rest.auth;

import com.sc.appointment_manager.application.auth.command.LoginCommand;
import com.sc.appointment_manager.application.auth.port.in.LoginUseCase;
import com.sc.appointment_manager.application.auth.port.in.LogoutUseCase;
import com.sc.appointment_manager.application.auth.port.in.RefreshTokenUseCase;
import com.sc.appointment_manager.interfaces.rest.auth.dto.AuthResponse;
import com.sc.appointment_manager.interfaces.rest.auth.dto.LoginRequest;
import com.sc.appointment_manager.interfaces.rest.auth.dto.RefreshRequest;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.media.Content;
import io.swagger.v3.oas.annotations.responses.ApiResponse;
import io.swagger.v3.oas.annotations.responses.ApiResponses;
import io.swagger.v3.oas.annotations.tags.Tag;
import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

@Tag(name = "Autenticación", description = "Inicio de sesión, renovación y cierre de sesión")
@RestController
@RequestMapping("/api/v1/auth")
@RequiredArgsConstructor
public class AuthController {

    private final LoginUseCase loginUseCase;
    private final RefreshTokenUseCase refreshTokenUseCase;
    private final LogoutUseCase logoutUseCase;

    @Operation(summary = "Iniciar sesión", description = "Autentica al usuario y devuelve un token de acceso y un token de refresco.")
    @ApiResponses({
            @ApiResponse(responseCode = "200", description = "Sesión iniciada correctamente"),
            @ApiResponse(responseCode = "400", description = "Datos de entrada inválidos", content = @Content),
            @ApiResponse(responseCode = "401", description = "Credenciales incorrectas o usuario inactivo", content = @Content)
    })
    @PostMapping("/login")
    public ResponseEntity<AuthResponse> login(@Valid @RequestBody LoginRequest request) {
        return ResponseEntity.ok(loginUseCase.login(new LoginCommand(request.email(), request.password())));
    }

    @Operation(summary = "Renovar token de acceso", description = "Genera un nuevo token de acceso a partir de un token de refresco válido.")
    @ApiResponses({
            @ApiResponse(responseCode = "200", description = "Token renovado correctamente"),
            @ApiResponse(responseCode = "401", description = "Token de refresco inválido o expirado", content = @Content)
    })
    @PostMapping("/refresh")
    public ResponseEntity<AuthResponse> refresh(@Valid @RequestBody RefreshRequest request) {
        return ResponseEntity.ok(refreshTokenUseCase.refresh(request.refreshToken()));
    }

    @Operation(summary = "Cerrar sesión", description = "Invalida el token de refresco del usuario.")
    @ApiResponses({
            @ApiResponse(responseCode = "204", description = "Sesión cerrada correctamente"),
            @ApiResponse(responseCode = "401", description = "Token de refresco inválido", content = @Content)
    })
    @PostMapping("/logout")
    public ResponseEntity<Void> logout(@Valid @RequestBody RefreshRequest request) {
        logoutUseCase.logout(request.refreshToken());
        return ResponseEntity.noContent().build();
    }
}
