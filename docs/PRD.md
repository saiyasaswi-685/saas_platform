# Product Requirements Document (PRD)

## 1. User Personas

### 1.1 Super Admin
* **Role:** System-level Administrator.
* **Responsibilities:** Manage the overall SaaS platform, view all registered tenants, manage subscription plans, and handle system-wide settings.
* **Pain Points:** Lack of visibility into how many organizations are using the platform and which ones are active.

### 1.2 Tenant Admin
* **Role:** Organization Administrator (e.g., a CEO or Team Lead of a company using our SaaS).
* **Responsibilities:** Manage their specific company's users, assign roles, and oversee all projects within their organization.
* **Pain Points:** Difficulty in onboarding new team members and ensuring data doesn't leak to other companies.

### 1.3 End User
* **Role:** Regular Team Member.
* **Responsibilities:** Execute tasks, update task status, and collaborate on projects assigned to them.
* **Pain Points:** Unclear priorities and lack of a centralized view of what needs to be done today.

## 2. Functional Requirements

### Authentication & Authorization
* **FR-001:** The system shall allow a new organization to register as a tenant with a unique subdomain.
* **FR-002:** The system shall allow users to log in using email, password, and tenant subdomain.
* **FR-003:** The system shall use JWT (JSON Web Tokens) for secure, stateless authentication with a 24-hour expiry.
* **FR-004:** The system shall enforce Role-Based Access Control (RBAC) preventing 'Users' from deleting projects.

### Tenant Management
* **FR-005:** The system shall isolate data so that User A in Tenant A cannot see data belonging to Tenant B.
* **FR-006:** The Super Admin shall be able to view a list of all tenants and their subscription status.
* **FR-007:** The system shall restrict the number of users a tenant can add based on their subscription plan (Free: 5, Pro: 25, Enterprise: 100).

### User Management
* **FR-008:** Tenant Admins shall be able to create new user accounts for their specific tenant.
* **FR-009:** The system shall ensure email addresses are unique *within* a tenant (but the same email can exist in different tenants).
* **FR-010:** Tenant Admins shall be able to deactivate or delete users within their organization.

### Project Management
* **FR-011:** Tenant Admins and Users shall be able to create new projects with a name, description, and status.
* **FR-012:** The system shall restrict the number of projects based on the subscription plan.
* **FR-013:** Users shall be able to view a list of projects associated with their tenant.

### Task Management
* **FR-014:** Users shall be able to create tasks within a project and assign them to other users in the same tenant.
* **FR-015:** Users shall be able to update the status of a task (Todo -> In Progress -> Completed).
* **FR-016:** The system shall allow filtering tasks by priority (Low, Medium, High).

## 3. Non-Functional Requirements

* **NFR-001 (Performance):** API response time should be under 200ms for 90% of standard requests.
* **NFR-002 (Security):** All user passwords must be hashed using `bcrypt` before storage.
* **NFR-003 (Scalability):** The system must support at least 100 concurrent users without degradation.
* **NFR-004 (Availability):** The application should be containerized via Docker to ensure 99% uptime and easy deployment.
* **NFR-005 (Usability):** The frontend interface must be responsive and usable on both desktop and mobile devices.