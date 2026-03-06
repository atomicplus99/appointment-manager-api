package com.sc.appointment_manager.interfaces.rest.shared;

import com.sc.appointment_manager.application.user.port.in.GetUserUseCase;
import com.sc.appointment_manager.domain.user.User;
import lombok.RequiredArgsConstructor;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.stereotype.Component;

import java.util.UUID;

@Component
@RequiredArgsConstructor
public class CurrentUserProvider {

    private final GetUserUseCase getUserUseCase;

    public User getCurrentUser() {
        String email = ((UserDetails) SecurityContextHolder.getContext()
                .getAuthentication().getPrincipal()).getUsername();
        return getUserUseCase.findByEmail(email);
    }

    public UUID getCurrentUserBusinessId() {
        return getCurrentUser().getBusinessId();
    }

    public boolean currentUserHasRole(String role) {
        return SecurityContextHolder.getContext().getAuthentication()
                .getAuthorities().stream()
                .anyMatch(a -> a.getAuthority().equals("ROLE_" + role));
    }

    public boolean isAdmin() {
        return currentUserHasRole("ADMIN");
    }
}
