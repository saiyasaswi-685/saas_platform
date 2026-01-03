-- ============================
-- Up Migration
-- ============================

-- Enable UUID extension (safe if already exists)
CREATE EXTENSION IF NOT EXISTS "uuid-ossp";

CREATE TABLE IF NOT EXISTS tasks (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    project_id UUID NOT NULL REFERENCES projects(id) ON DELETE CASCADE,
    tenant_id UUID NOT NULL REFERENCES tenants(id) ON DELETE CASCADE,
    title VARCHAR(255) NOT NULL,
    description TEXT,
    status VARCHAR(50) DEFAULT 'todo'
        CHECK (status IN ('todo', 'in_progress', 'completed')),
    priority VARCHAR(50) DEFAULT 'medium'
        CHECK (priority IN ('low', 'medium', 'high')),
    assigned_to UUID REFERENCES users(id),
    due_date DATE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- 🔥 SAFE index creation (no error on re-run)
CREATE INDEX IF NOT EXISTS idx_tasks_tenant_project
    ON tasks(tenant_id, project_id);

-- ============================
-- Down Migration (optional)
-- ============================

-- DROP INDEX IF EXISTS idx_tasks_tenant_project;
-- DROP TABLE IF EXISTS tasks;
