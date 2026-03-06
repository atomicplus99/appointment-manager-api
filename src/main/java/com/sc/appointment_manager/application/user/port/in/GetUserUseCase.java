package com.sc.appointment_manager.application.user.port.in;

import com.sc.appointment_manager.domain.user.User;

public interface GetUserUseCase {
    User findByEmail(String email);
}
