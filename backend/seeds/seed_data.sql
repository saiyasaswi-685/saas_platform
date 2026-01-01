-- 1. Create Super Admin (No Tenant ID)
INSERT INTO users (id, tenant_id, email, password_hash, full_name, role, is_active)
VALUES
(
    '11111111-1111-1111-1111-111111111111',
    NULL,
    'superadmin@system.com',
    '$2b$10$EpWxTiX.z.6d.DqN.DqN.DqN.DqN.DqN.DqN.DqN', -- Hash for 'Admin@123' (Conceptual placeholder)
    'System Super Admin',
    'super_admin',
    true
) ON CONFLICT DO NOTHING;

-- 2. Create Demo Tenant
INSERT INTO tenants (id, name, subdomain, status, subscription_plan, max_users, max_projects)
VALUES
(
    '22222222-2222-2222-2222-222222222222',
    'Demo Company',
    'demo',
    'active',
    'pro',
    25,
    15
) ON CONFLICT DO NOTHING;

-- 3. Create Tenant Admin for Demo Company
INSERT INTO users (id, tenant_id, email, password_hash, full_name, role, is_active)
VALUES
(
    '33333333-3333-3333-3333-333333333333',
    '22222222-2222-2222-2222-222222222222', -- Links to Demo Tenant
    'admin@demo.com',
    '$2b$10$EpWxTiX.z.6d.DqN.DqN.DqN.DqN.DqN.DqN.DqN', -- Hash for 'Demo@123' (Conceptual placeholder)
    'Demo Admin',
    'tenant_admin',
    true
) ON CONFLICT DO NOTHING;

-- 4. Create Regular Users for Demo Company
INSERT INTO users (id, tenant_id, email, password_hash, full_name, role)
VALUES
(uuid_generate_v4(), '22222222-2222-2222-2222-222222222222', 'user1@demo.com', '$2b$10$EpWxTiX.z.6d.DqN.DqN.DqN.DqN.DqN.DqN.DqN', 'User One', 'user'),
(uuid_generate_v4(), '22222222-2222-2222-2222-222222222222', 'user2@demo.com', '$2b$10$EpWxTiX.z.6d.DqN.DqN.DqN.DqN.DqN.DqN.DqN', 'User Two', 'user');

-- 5. Create Sample Projects
INSERT INTO projects (id, tenant_id, name, description, status, created_by)
VALUES
('44444444-4444-4444-4444-444444444444', '22222222-2222-2222-2222-222222222222', 'Website Redesign', 'Complete overhaul of corporate site', 'active', '33333333-3333-3333-3333-333333333333'),
('55555555-5555-5555-5555-555555555555', '22222222-2222-2222-2222-222222222222', 'Mobile App Launch', 'Q4 Release for iOS and Android', 'active', '33333333-3333-3333-3333-333333333333');

-- 6. Create Sample Tasks
INSERT INTO tasks (id, project_id, tenant_id, title, status, priority, assigned_to)
VALUES
(uuid_generate_v4(), '44444444-4444-4444-4444-444444444444', '22222222-2222-2222-2222-222222222222', 'Design Home Page', 'todo', 'high', '33333333-3333-3333-3333-333333333333'),
(uuid_generate_v4(), '44444444-4444-4444-4444-444444444444', '22222222-2222-2222-2222-222222222222', 'Setup React Repo', 'completed', 'medium', NULL),
(uuid_generate_v4(), '55555555-5555-5555-5555-555555555555', '22222222-2222-2222-2222-222222222222', 'API Integration', 'in_progress', 'high', '33333333-3333-3333-3333-333333333333'),
(uuid_generate_v4(), '55555555-5555-5555-5555-555555555555', '22222222-2222-2222-2222-222222222222', 'Unit Testing', 'todo', 'low', NULL),
(uuid_generate_v4(), '55555555-5555-5555-5555-555555555555', '22222222-2222-2222-2222-222222222222', 'Deploy to Staging', 'todo', 'medium', NULL);