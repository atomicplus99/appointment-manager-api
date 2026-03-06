package com.sc.appointment_manager.infrastructure.security;

import lombok.RequiredArgsConstructor;
import org.springframework.data.redis.core.StringRedisTemplate;
import org.springframework.stereotype.Service;

import java.time.Duration;
import java.util.Optional;
import java.util.UUID;

@Service
@RequiredArgsConstructor
public class RefreshTokenService {

    private static final String KEY_PREFIX = "refresh:";

    private final StringRedisTemplate redisTemplate;
    private final JwtProperties properties;

    public String create(String email) {
        String token = UUID.randomUUID().toString();
        redisTemplate.opsForValue().set(
                KEY_PREFIX + token,
                email,
                Duration.ofMillis(properties.getRefreshExpirationMs())
        );
        return token;
    }

    public Optional<String> getEmail(String token) {
        return Optional.ofNullable(redisTemplate.opsForValue().get(KEY_PREFIX + token));
    }

    public void delete(String token) {
        redisTemplate.delete(KEY_PREFIX + token);
    }
}
