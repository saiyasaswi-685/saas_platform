-- ============================
-- Up Migration
-- ============================

-- Enable UUID extension (safe if already exists)
CREATE EXTENSION IF NOT EXISTS "uuid-ossp";

CREATE TABLE IF NOT EXISTS projects (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    tenant_id UUID NOT NULL REFERENCES tenants(id) ON DELETE CASCADE,
    name VARCHAR(255) NOT NULL,
    description TEXT,
    status VARCHAR(50) DEFAULT 'active'
        CHECK (status IN ('active', 'archived', 'completed')),
    created_by UUID REFERENCES users(id),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- 🔥 SAFE index creation (no error on re-run)
CREATE INDEX IF NOT EXISTS idx_projects_tenant_id
    ON projects(tenant_id);

-- ============================
-- Down Migration (optional)
-- ============================

-- DROP INDEX IF EXISTS idx_projects_tenant_id;
-- DROP TABLE IF EXISTS projects;
