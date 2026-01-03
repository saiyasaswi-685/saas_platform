# Technical Specification

## 1. Project Structure

The project follows a monorepo-style structure isolated by Docker containers.

```text
saas-platform/
├── docker-compose.yml      # Orchestration for DB, Backend, Frontend
├── README.md               # Main entry point
├── docs/                   # Documentation (Research, PRD, Arch)
│
├── backend/                # Node.js Express Server
│   ├── src/
│   │   ├── controllers/    # Request handlers
│   │   ├── middleware/     # Auth & Error handling
│   │   ├── models/         # Database queries
│   │   └── routes/         # API endpoints
│   ├── migrations/         # SQL initialization files
│   ├── Dockerfile          # Backend container config
│   └── package.json        # Dependencies
│
└── frontend/               # React Application
    ├── public/
    ├── src/
    │   ├── components/     # Reusable UI widgets
    │   ├── pages/          # Main views (Dashboard, Login)
    │   └── context/        # Auth state management
    ├── Dockerfile          # Frontend container config
    └── package.json        # Dependencies