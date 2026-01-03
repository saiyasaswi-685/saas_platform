# Research & Technology Analysis

## 1. Multi-Tenancy Architecture Analysis

For this project, we analyzed three common approaches to database multi-tenancy.

### Option A: Shared Database, Shared Schema (Selected)
In this model, all tenants share the same database and the same tables. Every table has a `tenant_id` column to associate records with a specific tenant.
* **Pros:** Lowest infrastructure cost (one DB to manage). Easiest to maintain (schema changes run once). Centralized analytics are simple.
* **Cons:** Strict code-level security required (forgetting a `WHERE` clause leaks data). Backup/restore for a single tenant is difficult.

### Option B: Shared Database, Separate Schemas
One database instance, but each tenant gets their own "Schema" (namespace) within PostgreSQL.
* **Pros:** Good data isolation at the database level. manageable cost.
* **Cons:** Schema migration complexity increases with tenant count. High memory overhead for the database connection pool.

### Option C: Separate Databases
Each tenant has a completely separate physical database instance.
* **Pros:** Highest isolation and security. No "noisy neighbor" performance issues.
* **Cons:** Extremely high cost and operational complexity. Hard to aggregate data across tenants.

### Justification for Selected Approach (Option A)
We have chosen **Shared Database with Shared Schema**.
**Reasoning:**
1.  **Simplicity:** For a task management SaaS, the data structure is uniform across all tenants.
2.  **Performance:** Row Level Security (RLS) concepts and proper indexing on `tenant_id` provide excellent performance without the overhead of managing thousands of schemas.
3.  **Docker Constraints:** Running a single Postgres container in Docker is far more stable for development than trying to orchestrate dynamic schema creation on the fly.

## 2. Technology Stack Justification

### Backend: Node.js with Express
* **Why:** Node.js is excellent for I/O-heavy applications like task management. The event-driven architecture handles concurrent API requests efficiently.
* **Alternatives:** Python (Django) was considered but Node.js offers better JSON handling which is native to our API requirements.

### Frontend: React.js
* **Why:** Component-based architecture allows us to reuse UI elements (like Task Cards) easily. The Virtual DOM ensures a snappy user experience for the interactive Dashboard.
* **Alternatives:** Angular (too boilerplate-heavy) or Vue.js.

### Database: PostgreSQL
* **Why:** It is the industry standard for relational data. It supports robust foreign key constraints (crucial for data integrity) and JSONB columns if we need flexibility later.
* **Alternatives:** MongoDB (NoSQL) was rejected because this system requires strict relationships (Tenants -> Users -> Projects -> Tasks).

### Containerization: Docker
* **Why:** Mandatory for this assignment, but also ensures the "works on my machine" problem is eliminated. It allows us to spin up the DB, Backend, and Frontend with a single command.

## 3. Security Considerations

To ensure a secure multi-tenant environment, we implement the following:

1.  **Logical Data Isolation:** Every database query involving tenant data MUST include `WHERE tenant_id = ?`. This is enforced at the Controller level.
2.  **JWT Authentication:** We use stateless JSON Web Tokens. The token payload includes the `tenantId`, ensuring the user carries their identity with them. Tokens expire in 24 hours.
3.  **Password Security:** All passwords are hashed using `bcrypt` before storage. We never store plain-text passwords.
4.  **Role-Based Access Control (RBAC):** Middleware checks `req.user.role` before processing requests. For example, only `tenant_admin` can add users.
5.  **API Rate Limiting:** (Planned) To prevent one tenant from spamming the API and degrading performance for others.