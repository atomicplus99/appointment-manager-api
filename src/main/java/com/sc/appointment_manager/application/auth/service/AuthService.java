package com.sc.appointment_manager.application.auth.service;

import com.sc.appointment_manager.application.auth.command.LoginCommand;
import com.sc.appointment_manager.application.auth.exception.InvalidRefreshTokenException;
import com.sc.appointment_manager.application.auth.port.in.LoginUseCase;
import com.sc.appointment_manager.application.auth.port.in.LogoutUseCase;
import com.sc.appointment_manager.application.auth.port.in.RefreshTokenUseCase;
import com.sc.appointment_manager.domain.user.User;
import com.sc.appointment_manager.domain.user.exception.UserNotFoundException;
import com.sc.appointment_manager.domain.user.port.UserRepository;
import com.sc.appointment_manager.infrastructure.security.JwtService;
import com.sc.appointment_manager.infrastructure.security.RefreshTokenService;
import com.sc.appointment_manager.interfaces.rest.auth.dto.AuthResponse;
import lombok.RequiredArgsConstructor;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.stereotype.Service;

@Service
@RequiredArgsConstructor
public class AuthService implements LoginUseCase, RefreshTokenUseCase, LogoutUseCase {

    private final AuthenticationManager authenticationManager;
    private final UserRepository userRepository;
    private final JwtService jwtService;
    private final RefreshTokenService refreshTokenService;

    @Override
    public AuthResponse login(LoginCommand command) {
        authenticationManager.authenticate(
                new UsernamePasswordAuthenticationToken(command.email(), command.password())
        );

        User user = userRepository.findByEmail(command.email())
                .orElseThrow(() -> new UserNotFoundException(command.email()));

        String accessToken = jwtService.generateAccessToken(user.getEmail(), user.getRole().name());
        String refreshToken = refreshTokenService.create(user.getEmail());

        return AuthResponse.of(accessToken, refreshToken, user.getEmail(), user.getRole().name());
    }

    @Override
    public AuthResponse refresh(String refreshToken) {
        String email = refreshTokenService.getEmail(refreshToken)
                .orElseThrow(InvalidRefreshTokenException::new);

        User user = userRepository.findByEmail(email)
                .orElseThrow(() -> new UserNotFoundException(email));

        refreshTokenService.delete(refreshToken);

        String newAccessToken = jwtService.generateAccessToken(user.getEmail(), user.getRole().name());
        String newRefreshToken = refreshTokenService.create(user.getEmail());

        return AuthResponse.of(newAccessToken, newRefreshToken, user.getEmail(), user.getRole().name());
    }

    @Override
    public void logout(String refreshToken) {
        refreshTokenService.delete(refreshToken);
    }
}
