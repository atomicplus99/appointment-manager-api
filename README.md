# Appointment Manager API

A production-ready, multi-tenant REST API for appointment scheduling and management.
Built with Java 21 and Spring Boot 3, following Hexagonal Architecture principles.

Designed to serve any booking-based business — barbershops, clinics, spas, salons,
veterinary offices, tutoring centers, automotive shops, and more — from a single codebase.

---

## What Problem This Solves

Appointment-based businesses lose revenue every day to no-shows, double bookings,
and manual scheduling done over WhatsApp or phone calls with no tracking, no reminders,
and no history.

This API provides the backend infrastructure for a complete scheduling platform:
a business registers, configures their staff and services, and clients can book
appointments — with automated confirmations, reminders, conflict detection, and a
waitlist system that recovers lost slots the moment they open up.

---

## Key Features

**Booking & Availability**
- Real-time slot availability computed from staff schedules, buffer times, and existing bookings
- Interval-based conflict detection with a database-level index — no double bookings
- Service buffer time support (cleanup, room turnover, equipment prep)
- Preferred staff selection — clients can request a specific professional

**No-Show Management**
- Confirmation token flow — clients must confirm attendance or the slot is auto-released
- Automated reminder chain: booking confirmation → T-24h → T-1h → no-show detection
- No-show counter and client flagging after repeated offenses
- Waitlist notifications triggered immediately when a slot is released

**Staff & Schedule Management**
- Per-staff weekly schedules with day-of-week granularity
- Unavailability blocking (vacation, sick leave, one-off blocks)
- When a staff member is marked absent, all affected clients are notified automatically
  and offered reschedule or reassignment options

**Multi-Tenant by Design**
- A single deployment serves unlimited businesses
- All data is scoped by `business_id` — complete isolation between tenants
- Per-business configuration: timezone, cancellation policy, walk-in rules
- Per-business notification templates — customizable messages per channel and event

**Extensibility**
- `metadata JSONB` column on appointments for business-specific fields without schema changes
- Works out of the box for 80% of booking businesses
- Additive extensions for group sessions, resource booking, and recurring appointments

---

## Architecture

This project is built on **Hexagonal Architecture** (Ports and Adapters), which means
the business domain is completely decoupled from frameworks, databases, and external services.

```
┌─────────────────────────────────────────────────────────────┐
│  interfaces/        REST Controllers, DTOs, Mappers          │
├─────────────────────────────────────────────────────────────┤
│  application/       Use Cases — orchestrate the domain       │
├─────────────────────────────────────────────────────────────┤
│  domain/            Business Rules — pure Java, zero deps    │
├─────────────────────────────────────────────────────────────┤
│  infrastructure/    JPA, Redis, Email, WhatsApp, Scheduler   │
└─────────────────────────────────────────────────────────────┘
```

**Dependency rule:** `interfaces → application → domain ← infrastructure`

The domain layer has no dependency on Spring, Hibernate, or any external library.
This means business rules are unit-tested in milliseconds without spinning up a
Spring context or a database — and infrastructure can be swapped freely.

Each domain module follows the same pattern:

```
domain/appointment/
├── Appointment.java                  ← Domain entity (plain Java)
├── AppointmentStatus.java            ← Enum: SCHEDULED, CONFIRMED, COMPLETED...
├── AppointmentService.java           ← Domain service: conflict detection, rules
└── port/
    └── AppointmentRepository.java    ← Outbound port (interface)

infrastructure/persistence/appointment/
├── AppointmentJpaEntity.java         ← JPA entity (@Entity, @Table)
├── AppointmentJpaRepository.java     ← Spring Data interface
├── AppointmentMapper.java            ← Domain entity ↔ JPA entity
└── AppointmentRepositoryAdapter.java ← Implements the domain port
```

---

## Tech Stack

| Concern              | Technology                          |
|----------------------|-------------------------------------|
| Language             | Java 21                             |
| Framework            | Spring Boot 3.x                     |
| Architecture         | Hexagonal (Ports and Adapters)      |
| ORM                  | Spring Data JPA + Hibernate         |
| Database             | PostgreSQL 16                       |
| Schema Migration     | Flyway                              |
| Cache                | Redis 7                             |
| Auth                 | Spring Security + JWT               |
| Job Scheduling       | Quartz Scheduler                    |
| API Documentation    | SpringDoc OpenAPI (Swagger UI)      |
| Validation           | Jakarta Bean Validation 3.0         |
| Testing              | JUnit 5 + Testcontainers            |
| Build Tool           | Gradle                              |
| Containerization     | Docker + Docker Compose             |
| CI/CD                | GitHub Actions                      |
| Email                | Resend                              |
| WhatsApp / SMS       | Twilio                              |

---

## Data Model

```
businesses ──< services
           ──< staff ──< working_hours
                     ──< staff_unavailability
                     ──< staff_services >── services
           ──< appointments >── clients (users)
                           >── staff
                           >── services
                           ──< notifications
appointments ──< ratings
waitlist >── clients
         >── businesses
```

### Appointment Lifecycle

```
SCHEDULED ──► CONFIRMED ──► COMPLETED
                        ──► NO_SHOW
          ──► CANCELLED (at any point before completion)
          ──► AUTO_CANCELLED (no confirmation received)
```

---

## API Overview

```
POST   /api/v1/auth/register
POST   /api/v1/auth/login
POST   /api/v1/auth/refresh

GET    /api/v1/businesses/:id
POST   /api/v1/businesses

GET    /api/v1/businesses/:id/services
POST   /api/v1/businesses/:id/services

GET    /api/v1/businesses/:id/staff
POST   /api/v1/businesses/:id/staff
PUT    /api/v1/businesses/:id/staff/:id/unavailability

GET    /api/v1/businesses/:id/availability?date=&serviceId=&staffId=

POST   /api/v1/appointments
GET    /api/v1/appointments/:id
PATCH  /api/v1/appointments/:id/confirm
PATCH  /api/v1/appointments/:id/cancel
PATCH  /api/v1/appointments/:id/reschedule
PATCH  /api/v1/appointments/:id/complete
PATCH  /api/v1/appointments/:id/no-show

POST   /api/v1/appointments/:id/rating
POST   /api/v1/waitlist
```

Full interactive documentation available at `/swagger-ui.html` when running locally.

---

## Getting Started

### Prerequisites
- Docker and Docker Compose
- Java 21
- Gradle

### 1. Clone the repository
```bash
git clone https://github.com/your-username/appointment-manager.git
cd appointment-manager
```

### 2. Start the infrastructure
```bash
docker compose up -d
```

This starts PostgreSQL on port `5432` and Redis on port `6379`.
Flyway migrations run automatically on application startup.

### 3. Run the application
```bash
./gradlew bootRun --args='--spring.profiles.active=local'
```

### 4. Verify it's running
```
http://localhost:8080/swagger-ui.html
```

---

## Environment Profiles

| Profile | Purpose                              |
|---------|--------------------------------------|
| `local` | Local development with Docker Compose|
| `prod`  | Production with external services    |

Production requires the following environment variables:

```
DATABASE_URL
DATABASE_USERNAME
DATABASE_PASSWORD
REDIS_HOST
REDIS_PORT
REDIS_PASSWORD
JWT_SECRET
RESEND_API_KEY
TWILIO_ACCOUNT_SID
TWILIO_AUTH_TOKEN
TWILIO_WHATSAPP_FROM
```

---

## Project Structure

```
src/main/java/com/appointments/
├── domain/           # Business rules — no framework dependencies
├── application/      # Use cases — orchestration layer
├── infrastructure/   # JPA, Redis, email, WhatsApp, Quartz adapters
└── interfaces/       # REST controllers, DTOs, exception handling

src/main/resources/
├── db/migration/     # Flyway SQL migration files
├── application.yml
├── application-local.yml
└── application-prod.yml
```

---

## Business Applicability

The same API, without code changes, supports:

| Vertical        | Staff          | Services                  |
|-----------------|----------------|---------------------------|
| Barbershop      | Barbers        | Haircut, beard, shave      |
| Medical clinic  | Doctors        | Consultation, exam         |
| Dental clinic   | Dentists       | Cleaning, extraction       |
| Psychology      | Therapists     | Individual, couples session|
| Spa / Salon     | Therapists     | Massage, facial, body wrap |
| Physiotherapy   | Physiotherapists| Session, evaluation       |
| Tattoo studio   | Artists        | Session, piercing          |
| Personal trainer| Trainers       | 1-on-1 training session    |
| Veterinary      | Vets           | Consultation, vaccination  |
| Tutoring        | Tutors         | Subject sessions           |
| Car repair      | Mechanics      | Oil change, diagnostics    |

Business-specific data (insurance codes, pet details, vehicle plates, etc.)
is handled through the `metadata JSONB` column on appointments —
no schema changes required per business type.

---

## Deployment

The application is containerized and deployable to any platform that runs Docker.

**Free tier stack (zero cost):**
- App: Render or Railway
- Database: Supabase (PostgreSQL)
- Cache: Upstash (Redis)
- Email: Resend
- CI/CD: GitHub Actions

**Production stack:**
- App: AWS ECS Fargate
- Database: AWS RDS PostgreSQL (Multi-AZ)
- Cache: AWS ElastiCache or Upstash
- CDN/Gateway: AWS CloudFront + Application Load Balancer

---

## License

MIT
