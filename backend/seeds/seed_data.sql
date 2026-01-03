-- =====================================
-- CLEAN SEED FILE (ALWAYS WORKS)
-- =====================================

-- 🔥 STEP 0: CLEAR OLD DATA (IMPORTANT)
TRUNCATE TABLE tasks CASCADE;
TRUNCATE TABLE projects CASCADE;
TRUNCATE TABLE users CASCADE;
TRUNCATE TABLE tenants CASCADE;

-- =====================================
-- 1. Super Admin
-- =====================================
INSERT INTO users (id, tenant_id, email, password_hash, full_name, role, is_active)
VALUES (
  '11111111-1111-1111-1111-111111111111',
  NULL,
  'superadmin@system.com',
  '$2b$10$n7f3kP8FMbDMpewnNDFIA.sQNLSwt8jSngQ/1A/lce7FKKVH405Ve',
  'System Super Admin',
  'super_admin',
  true
);

-- =====================================
-- 2. Demo Tenant
-- =====================================
INSERT INTO tenants (id, name, subdomain, status, subscription_plan, max_users, max_projects)
VALUES (
  '22222222-2222-2222-2222-222222222222',
  'Demo Company',
  'demo',
  'active',
  'pro',
  25,
  15
);

-- =====================================
-- 3. Tenant Admin
-- =====================================
INSERT INTO users (id, tenant_id, email, password_hash, full_name, role, is_active)
VALUES (
  '33333333-3333-3333-3333-333333333333',
  '22222222-2222-2222-2222-222222222222',
  'admin@demo.com',
  '$2b$10$n7f3kP8FMbDMpewnNDFIA.sQNLSwt8jSngQ/1A/lce7FKKVH405Ve',
  'Demo Admin',
  'tenant_admin',
  true
);

-- =====================================
-- 4. Regular Users
-- =====================================
INSERT INTO users (id, tenant_id, email, password_hash, full_name, role)
VALUES
(uuid_generate_v4(), '22222222-2222-2222-2222-222222222222', 'user1@demo.com', '$2b$10$hash', 'User One', 'user'),
(uuid_generate_v4(), '22222222-2222-2222-2222-222222222222', 'user2@demo.com', '$2b$10$hash', 'User Two', 'user');

-- =====================================
-- 5. Projects
-- =====================================
INSERT INTO projects (id, tenant_id, name, description, status, created_by)
VALUES
('44444444-4444-4444-4444-444444444444', '22222222-2222-2222-2222-222222222222', 'Website Redesign', 'Demo', 'active', '33333333-3333-3333-3333-333333333333'),
('55555555-5555-5555-5555-555555555555', '22222222-2222-2222-2222-222222222222', 'Mobile App Launch', 'Demo', 'active', '33333333-3333-3333-3333-333333333333');

-- =====================================
-- 6. Tasks
-- =====================================
INSERT INTO tasks (id, project_id, tenant_id, title, status, priority)
VALUES
(uuid_generate_v4(), '44444444-4444-4444-4444-444444444444', '22222222-2222-2222-2222-222222222222', 'Task 1', 'todo', 'high'),
(uuid_generate_v4(), '55555555-5555-5555-5555-555555555555', '22222222-2222-2222-2222-222222222222', 'Task 2', 'todo', 'medium');
