# TODO App - Quick Task Reference

This document provides a quick reference for all implementation tasks. For detailed information, see [IMPLEMENTATION_PLAN.md](IMPLEMENTATION_PLAN.md).

## Task Status Overview

### Phase 1: Backend Foundation (7 tasks)
- [ ] 1.1: Create TODO Entity and Repository
- [ ] 1.2: Create DTOs (Data Transfer Objects)
- [ ] 1.3: Implement Service Layer
- [ ] 1.4: Implement REST Controller
- [ ] 1.5: Global Exception Handler
- [ ] 1.6: Application Configuration
- [ ] 1.7: Create Main Application Class

### Phase 2: Backend Testing (3 tasks)
- [ ] 2.1: Unit Tests for Service Layer
- [ ] 2.2: Integration Tests for REST API
- [ ] 2.3: Repository Tests

### Phase 3: Frontend Setup (8 tasks)
- [ ] 3.1: Initialize React Application
- [ ] 3.2: Create API Service Layer
- [ ] 3.3: Create Main App Component
- [ ] 3.4: Create TodoList Component
- [ ] 3.5: Create TodoItem Component
- [ ] 3.6: Create TodoForm Component
- [ ] 3.7: Create Header Component
- [ ] 3.8: Application Styling

### Phase 4: Integration & Testing (3 tasks)
- [ ] 4.1: Frontend-Backend Integration
- [ ] 4.2: End-to-End Testing
- [ ] 4.3: Frontend Unit Tests

### Phase 5: Documentation & Deployment (4 tasks)
- [ ] 5.1: API Documentation
- [ ] 5.2: User Documentation
- [ ] 5.3: Developer Documentation
- [ ] 5.4: Deployment Configuration

---

## Quick Start Commands

### Backend (Java/Spring Boot)
```bash
# Build
mvn clean install

# Run
mvn spring-boot:run

# Test
mvn test

# Access H2 Console (once configured)
http://localhost:8080/h2-console
```

### Frontend (React)
```bash
# Install dependencies
cd frontend
npm install

# Run development server
npm start

# Build for production
npm run build

# Run tests
npm test
```

---

## API Endpoints Summary

| Method | Endpoint | Description |
|--------|----------|-------------|
| GET | /api/todos | Get all TODOs |
| GET | /api/todos/{id} | Get TODO by ID |
| POST | /api/todos | Create new TODO |
| PUT | /api/todos/{id} | Update TODO |
| DELETE | /api/todos/{id} | Delete TODO |
| PATCH | /api/todos/{id}/complete | Toggle completion |

---

## File Structure Overview

```
workshop-03-04/
├── src/main/java/com/workshop/todo/
│   ├── TodoApplication.java (Main)
│   ├── model/
│   │   ├── Todo.java (Entity)
│   │   └── dto/ (DTOs)
│   ├── repository/
│   │   └── TodoRepository.java
│   ├── service/
│   │   ├── TodoService.java
│   │   └── TodoServiceImpl.java
│   ├── controller/
│   │   └── TodoController.java
│   ├── config/
│   │   └── CorsConfig.java
│   └── exception/
│       ├── GlobalExceptionHandler.java
│       ├── TodoNotFoundException.java
│       └── ErrorResponse.java
├── src/main/resources/
│   └── application.properties
├── src/test/java/com/workshop/todo/
│   ├── service/TodoServiceTest.java
│   ├── controller/TodoControllerIntegrationTest.java
│   └── repository/TodoRepositoryTest.java
└── frontend/src/
    ├── components/
    │   ├── TodoList.jsx
    │   ├── TodoItem.jsx
    │   ├── TodoForm.jsx
    │   └── Header.jsx
    ├── services/
    │   └── todoService.js
    ├── styles/
    │   └── *.css
    ├── App.jsx
    └── index.jsx
```

---

## Priority Order

**Must Have (MVP)**:
1. Backend entity, repository, service (Tasks 1.1-1.3)
2. REST API endpoints (Task 1.4)
3. Basic React setup and components (Tasks 3.1-3.7)
4. Frontend-Backend integration (Task 4.1)

**Should Have**:
5. Error handling (Task 1.5)
6. Backend tests (Phase 2)
7. Frontend styling (Task 3.8)
8. Integration testing (Task 4.2)

**Nice to Have**:
9. Frontend unit tests (Task 4.3)
10. Documentation (Phase 5)
11. Deployment configuration (Task 5.4)

---

## Key Dependencies

- Java 21
- Maven 3.x
- Node.js 18+ (for frontend)
- npm or yarn

---

## Notes for Developers

1. Start with backend - it's the foundation
2. Test each component as you build it
3. Use H2 console to verify database operations
4. Enable CORS early for smooth frontend integration
5. Keep components small and focused
6. Follow existing code patterns in AGENTS.md
7. Run tests frequently to catch issues early

---

**For detailed implementation instructions, task breakdown, and acceptance criteria, see [IMPLEMENTATION_PLAN.md](IMPLEMENTATION_PLAN.md)**
