# System Architecture Design

## 1. High-Level Architecture

The system follows a standard 3-tier architecture containerized with Docker.

**[Client Layer]**
* **Browser/Mobile:** React Application (Frontend)
* **Communication:** HTTP/REST over Port 3000

    ⬇️ *JSON Requests*

**[Application Layer]**
* **Server:** Node.js + Express (Backend)
* **Auth:** JWT Middleware & Role-Based Access Control
* **Logic:** Multi-tenancy isolation via `tenant_id`
* **Port:** 5000

    ⬇️ *SQL Queries*

**[Data Layer]**
* **Database:** PostgreSQL 15
* **Storage:** Persistent Docker Volume
* **Port:** 5432

## 2. Database Schema (ERD)

The database uses a shared-schema approach where the `tenants` table is the root of the hierarchy.

* **Tenants** `(id, name, subdomain, subscription_plan...)`
    * One Tenant has many **Users**
    * One Tenant has many **Projects**

* **Users** `(id, tenant_id, email, role...)`
    * Belongs to one Tenant
    * Can create many Projects
    * Can be assigned many Tasks

* **Projects** `(id, tenant_id, name, status...)`
    * Belongs to one Tenant
    * Contains many Tasks

* **Tasks** `(id, tenant_id, project_id, title, status...)`
    * Belongs to one Project (and thus one Tenant)
    * Assigned to one User

## 3. API Architecture Strategy

The API is organized by resource modules. All endpoints (except login/register) require a valid JWT in the `Authorization` header.

* **Auth Module:** `/api/auth` (Login, Register, Get Me)
* **Tenant Module:** `/api/tenants` (Management, Subscription)
* **User Module:** `/api/tenants/:id/users` (Add/Remove team members)
* **Project Module:** `/api/projects` (CRUD operations)
* **Task Module:** `/api/projects/:id/tasks` (Task tracking)