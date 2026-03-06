package com.sc.appointment_manager.infrastructure.persistence.client;

import com.sc.appointment_manager.domain.client.query.ClientFilterQuery;
import jakarta.persistence.criteria.Predicate;
import org.springframework.data.jpa.domain.Specification;

import java.util.ArrayList;
import java.util.List;

public class ClientSpecification {

    private ClientSpecification() {}

    public static Specification<ClientJpaEntity> withFilter(ClientFilterQuery filter) {
        return (root, query, cb) -> {
            List<Predicate> predicates = new ArrayList<>();

            if (filter.businessId() != null) {
                predicates.add(cb.equal(root.get("businessId"), filter.businessId()));
            }

            if (filter.name() != null && !filter.name().isBlank()) {
                predicates.add(cb.like(cb.lower(root.get("name")),
                        "%" + filter.name().toLowerCase() + "%"));
            }

            if (filter.email() != null && !filter.email().isBlank()) {
                predicates.add(cb.like(cb.lower(root.get("email")),
                        "%" + filter.email().toLowerCase() + "%"));
            }

            if (filter.flagged() != null) {
                predicates.add(cb.equal(root.get("flagged"), filter.flagged()));
            }

            if (filter.active() != null) {
                predicates.add(cb.equal(root.get("active"), filter.active()));
            }

            return cb.and(predicates.toArray(new Predicate[0]));
        };
    }
}
