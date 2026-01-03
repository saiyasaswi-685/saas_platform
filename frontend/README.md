# SaaS Platform (Multi-Tenant)

A scalable, multi-tenant Project Management SaaS platform built with Node.js, React, and PostgreSQL. It features complete data isolation, role-based access control, and subscription management.

**Target Audience:** Small to medium-sized businesses (SMBs) requiring isolated project management workspaces for their internal teams.

## 🚀 Features
* **Multi-Tenancy:** Complete data isolation using `tenant_id` at the database level.
* **Authentication:** JWT-based secure auth with Role-Based Access Control (RBAC).
* **User Roles:** Support for Super Admin, Tenant Admin, and Standard Users.
* **Project Management:** Create, update, and delete projects within your organization.
* **Task Tracking:** Kanban-style workflow (Todo -> In Progress -> Completed).
* **Subscription Limits:** Enforced limits on users/projects based on Free/Pro plans.
* **Audit Logging:** Tracks critical actions for security and compliance.
* **Responsive UI:** Built with React Bootstrap for a clean user experience.

## 🛠️ Technology Stack
* **Frontend:** React 18, React Router v6, Axios, Bootstrap 5.
* **Backend:** Node.js, Express.js.
* **Database:** PostgreSQL 15.
* **Containerization:** Docker & Docker Compose.
* **Security:** Bcrypt (hashing), JWT (tokens), CORS.

## 🏗️ Architecture
The application follows a standard MVC architecture with tenant isolation at the service layer.
![Architecture Diagram](docs/architecture_diagram.png)

* **Client:** React SPA communicating via REST API.
* **Server:** Express API handling logic, validation, and tenant isolation.
* **Database:** Single shared database with row-level tenancy (using `tenant_id` column).

## ⚙️ Installation & Setup

### Prerequisites
* Docker & Docker Compose
* Node.js (optional, for local dev outside Docker)

### Quick Start (Docker)
1.  **Clone the repository:**
    ```bash
    git clone <YOUR_REPO_URL>
    cd saas-platform
    ```

2.  **Start the application:**
    ```bash
    docker-compose up --build -d
    ```

3.  **Run Database Migrations:**
    ```bash
    docker-compose exec backend npm run migrate
    ```

4.  **Seed Initial Data:**
    ```bash
    docker-compose exec backend npm run seed
    ```
    *(Note: Use `npm run seed:submission` to load evaluation credentials)*

5.  **Access the App:**
    * **Frontend:** http://localhost:3000
    * **Backend:** http://localhost:5000

## 🔑 Environment Variables
The application uses the following environment variables. See `.env.example` for reference.

| Variable | Description | Default/Example |
| :--- | :--- | :--- |
| `PORT` | Backend API Port | `5000` |
| `DATABASE_URL` | Postgres Connection String | `postgres://user:pass@db:5432/saas_db` |
| `JWT_SECRET` | Secret key for signing tokens | `supersecretkey` |
| `FRONTEND_URL` | URL for CORS configuration | `http://localhost:3000` |

## 📹 Demo Video
https://youtu.be/HpQsTMFf6gg

## 📚 API Documentation
See `docs/API.md` for full endpoint details and examples.