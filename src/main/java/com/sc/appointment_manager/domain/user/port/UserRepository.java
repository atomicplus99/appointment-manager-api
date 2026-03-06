package com.sc.appointment_manager.domain.user.port;

import com.sc.appointment_manager.domain.user.User;

import java.util.Optional;
import java.util.UUID;

public interface UserRepository {

    Optional<User> findById(UUID id);

    Optional<User> findByEmail(String email);

    User save(User user);

    boolean existsById(UUID id);
}
