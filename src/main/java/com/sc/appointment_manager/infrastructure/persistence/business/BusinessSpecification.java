package com.sc.appointment_manager.infrastructure.persistence.business;

import com.sc.appointment_manager.domain.business.query.BusinessFilterQuery;
import jakarta.persistence.criteria.Predicate;
import org.springframework.data.jpa.domain.Specification;

import java.util.ArrayList;
import java.util.List;

public class BusinessSpecification {

    private BusinessSpecification() {}

    public static Specification<BusinessJpaEntity> withFilter(BusinessFilterQuery filter) {
        return (root, query, cb) -> {
            List<Predicate> predicates = new ArrayList<>();

            if (filter.name() != null && !filter.name().isBlank()) {
                predicates.add(cb.like(cb.lower(root.get("name")),
                        "%" + filter.name().toLowerCase() + "%"));
            }

            if (filter.type() != null) {
                predicates.add(cb.equal(root.get("type"), filter.type()));
            }

            if (filter.active() != null) {
                predicates.add(cb.equal(root.get("active"), filter.active()));
            }

            if (filter.walkInsAllowed() != null) {
                predicates.add(cb.equal(root.get("walkInsAllowed"), filter.walkInsAllowed()));
            }

            if (filter.timezone() != null && !filter.timezone().isBlank()) {
                predicates.add(cb.equal(root.get("timezone"), filter.timezone()));
            }

            return cb.and(predicates.toArray(new Predicate[0]));
        };
    }
}
