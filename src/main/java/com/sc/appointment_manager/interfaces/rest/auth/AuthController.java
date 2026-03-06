package com.sc.appointment_manager.interfaces.rest.auth;

import com.sc.appointment_manager.application.auth.command.LoginCommand;
import com.sc.appointment_manager.application.auth.port.in.LoginUseCase;
import com.sc.appointment_manager.application.auth.port.in.LogoutUseCase;
import com.sc.appointment_manager.application.auth.port.in.RefreshTokenUseCase;
import com.sc.appointment_manager.interfaces.rest.auth.dto.AuthResponse;
import com.sc.appointment_manager.interfaces.rest.auth.dto.LoginRequest;
import com.sc.appointment_manager.interfaces.rest.auth.dto.RefreshRequest;
import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/api/v1/auth")
@RequiredArgsConstructor
public class AuthController {

    private final LoginUseCase loginUseCase;
    private final RefreshTokenUseCase refreshTokenUseCase;
    private final LogoutUseCase logoutUseCase;

    @PostMapping("/login")
    public ResponseEntity<AuthResponse> login(@Valid @RequestBody LoginRequest request) {
        return ResponseEntity.ok(loginUseCase.login(new LoginCommand(request.email(), request.password())));
    }

    @PostMapping("/refresh")
    public ResponseEntity<AuthResponse> refresh(@Valid @RequestBody RefreshRequest request) {
        return ResponseEntity.ok(refreshTokenUseCase.refresh(request.refreshToken()));
    }

    @PostMapping("/logout")
    public ResponseEntity<Void> logout(@Valid @RequestBody RefreshRequest request) {
        logoutUseCase.logout(request.refreshToken());
        return ResponseEntity.noContent().build();
    }
}
