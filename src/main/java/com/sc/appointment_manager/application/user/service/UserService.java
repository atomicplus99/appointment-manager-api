package com.sc.appointment_manager.application.user.service;

import com.sc.appointment_manager.application.user.port.in.GetUserUseCase;
import com.sc.appointment_manager.domain.user.User;
import com.sc.appointment_manager.domain.user.exception.UserNotFoundException;
import com.sc.appointment_manager.domain.user.port.UserRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

@Service
@RequiredArgsConstructor
public class UserService implements GetUserUseCase {

    private final UserRepository userRepository;

    @Override
    public User findByEmail(String email) {
        return userRepository.findByEmail(email)
                .orElseThrow(() -> new UserNotFoundException(email));
    }
}
