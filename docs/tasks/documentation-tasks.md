# Documentation Tasks

**Phase**: 4 - Documentation & Deployment  
**Estimated Duration**: 1-2 days  
**Dependencies**: All development and testing tasks should be complete  
**Team**: Technical Writer or Developer(s)

---

## Overview

These tasks create the documentation needed for the TODO application to be used, maintained, and extended. Good documentation helps new developers understand the code, helps users understand how to use the application, and provides a reference for the API.

---

## Task DOC-1: API Documentation

**Estimated Time**: 0.5 days (4 hours)  
**Priority**: High  
**Dependencies**: Backend tasks must be complete

### Description
Create comprehensive documentation for all backend API endpoints. This helps frontend developers (and future API consumers) understand how to interact with the backend service.

### What Needs to Be Done

#### Document Each API Endpoint

For each endpoint, provide:
1. **Endpoint URL**: The full path (e.g., `/api/tasks`)
2. **HTTP Method**: GET, POST, PUT, DELETE, or PATCH
3. **Purpose**: What the endpoint does in plain language
4. **Request Format**: What data needs to be sent (if any)
5. **Request Example**: A real example with sample data
6. **Response Format**: What data is returned
7. **Response Example**: A real example of success response
8. **Status Codes**: All possible HTTP status codes and what they mean
9. **Error Responses**: Examples of error responses

#### Endpoints to Document

**GET /api/tasks**
- Purpose: Retrieve all tasks
- No request body needed
- Returns array of all tasks
- Example success response
- Possible status codes: 200, 500

**GET /api/tasks/{id}**
- Purpose: Retrieve a specific task by ID
- Path parameter: id (task identifier)
- Returns single task object
- Example success response
- Possible status codes: 200, 404, 500

**POST /api/tasks**
- Purpose: Create a new task
- Request body: task description
- Returns created task with generated ID
- Example request and response
- Possible status codes: 201, 400, 500

**PUT /api/tasks/{id}**
- Purpose: Update an existing task
- Path parameter: id
- Request body: updated task data
- Returns updated task
- Example request and response
- Possible status codes: 200, 400, 404, 500

**DELETE /api/tasks/{id}**
- Purpose: Delete a task
- Path parameter: id
- No response body
- Possible status codes: 204, 404, 500

**PATCH /api/tasks/{id}/toggle**
- Purpose: Toggle task completion status
- Path parameter: id
- No request body needed
- Returns updated task
- Possible status codes: 200, 404, 500

#### Additional Documentation

**Authentication**: Document that no authentication is required (single-user application)

**CORS**: Document which origins are allowed to call the API

**Rate Limiting**: Document if any rate limits apply (likely none for MVP)

**Data Validation Rules**:
- Task description must be 3-500 characters
- Description cannot be empty or whitespace only
- Other validation rules

**Error Response Format**: Document standard error response structure

### Format Options

Choose one of these formats:

**Option 1: Markdown File**
- Simple and easy to maintain
- Can be included in repository
- Example: `docs/api-reference.md`

**Option 2: Swagger/OpenAPI**
- Interactive documentation
- Can test API directly from docs
- Auto-generates from code annotations

**Option 3: Postman Collection**
- Provides ready-to-use API examples
- Easy to import and test
- Share with team

### Success Criteria
- [ ] All endpoints are documented
- [ ] Request and response formats are clear
- [ ] Examples are accurate and helpful
- [ ] Error responses are explained
- [ ] Documentation is easy to find and read
- [ ] Frontend team can use documentation to integrate successfully

### Notes
Keep documentation updated when API changes. Consider using tools that generate docs from code to keep them in sync.

---

## Task DOC-2: User Documentation

**Estimated Time**: 0.5 days (4 hours)  
**Priority**: Medium  
**Dependencies**: Frontend and backend must be complete

### Description
Create a simple user guide that explains how to use the TODO application. This helps new users get started quickly and answers common questions.

### What Needs to Be Done

#### Create User Guide

**Section 1: Getting Started**
1. What is this application?
   - Brief overview of purpose
   - Who it's for
   - What it does

2. Accessing the application:
   - URL to access (if deployed)
   - System requirements (modern browser)
   - No account needed (single-user)

**Section 2: Basic Operations**

1. **Adding Tasks**
   - How to add a new task
   - Character limit explanation (3-500 characters)
   - What happens after adding
   - Include screenshot

2. **Viewing Tasks**
   - How tasks are displayed
   - What information is shown
   - How list is organized
   - Include screenshot

3. **Completing Tasks**
   - How to mark task as complete
   - Visual changes (strikethrough)
   - How to mark as incomplete again
   - Include screenshot

4. **Editing Tasks**
   - How to edit a task description
   - Saving changes
   - Canceling edits
   - Include screenshot

5. **Deleting Tasks**
   - How to delete a task
   - Confirmation dialog
   - Cannot be undone
   - Include screenshot

6. **Filtering Tasks**
   - Three filter options: All, Active, Completed
   - How to switch between filters
   - Task counter explanation
   - Include screenshot

**Section 3: Tips and Best Practices**
1. Writing good task descriptions
2. Using the app on mobile devices
3. Keyboard shortcuts (if implemented)

**Section 4: Troubleshooting**

Common issues and solutions:
- "Can't add task" - check character count
- "Task disappeared" - check filter setting
- "Error message" - check internet connection
- "App not loading" - try refreshing browser

**Section 5: FAQ**
- Is my data saved?
- Can I access from multiple devices?
- Is there a mobile app?
- Can I share tasks with others?
- What happens if I close the browser?

### Format
Create as a simple Markdown file or web page with screenshots

Location: `docs/user-guide.md` or embedded in application

### Screenshots Needed
Capture screenshots showing:
- Main task list view
- Adding a new task
- Completed vs pending tasks
- Edit mode
- Delete confirmation
- Filter controls
- Empty state

### Success Criteria
- [ ] User guide covers all features
- [ ] Instructions are clear and step-by-step
- [ ] Screenshots are included and helpful
- [ ] Language is simple and non-technical
- [ ] New user can use application after reading guide
- [ ] Common questions are answered

### Notes
Write for a general audience who may not be technical. Use simple language and visual examples. Test guide with someone unfamiliar with the application.

---

## Task DOC-3: Developer Documentation

**Estimated Time**: 0.5 days (4 hours)  
**Priority**: High  
**Dependencies**: All development tasks should be complete

### Description
Create technical documentation to help developers understand, set up, and contribute to the project. This is essential for onboarding new team members and maintaining the codebase.

### What Needs to Be Done

#### Update README.md

The README should include:

**Section 1: Project Overview**
- What the application does
- Technology stack summary
- Key features list
- Link to user guide

**Section 2: Prerequisites**
Required software and versions:
- Java 21 (JDK)
- Maven 3.x or higher
- Node.js and npm (specific versions)
- Any IDE recommendations

**Section 3: Getting Started**

Backend setup:
```
1. Clone the repository
2. Navigate to project directory
3. Run Maven command to install dependencies
4. Run command to start backend server
5. Verify at http://localhost:8080
```

Frontend setup:
```
1. Navigate to frontend directory
2. Run npm install
3. Run npm start
4. Verify at http://localhost:3000
```

**Section 4: Project Structure**
```
Explain folder organization:
- src/ (backend code)
  - main/java/ (Java source code)
  - main/resources/ (config files)
  - test/ (test files)
- frontend/ (frontend code)
  - src/ (React components)
  - public/ (static assets)
- docs/ (documentation)
```

**Section 5: Running Tests**

How to run different test suites:
- Backend unit tests: `mvn test`
- Backend integration tests: `mvn verify`
- Frontend tests: `npm test`
- End-to-end tests: instruction for E2E test tool

**Section 6: Building for Production**

How to create production builds:
- Backend: `mvn clean package`
- Frontend: `npm run build`
- Output locations

**Section 7: Configuration**

Environment variables and configuration:
- Database configuration
- API URL configuration
- Port settings
- Other customizable settings

**Section 8: API Documentation**
Link to API documentation (from DOC-1)

**Section 9: Contributing**

Guidelines for contributors:
- Code style conventions
- Branch naming
- Commit message format
- Pull request process
- Testing requirements

**Section 10: Troubleshooting**

Common setup issues:
- Port already in use
- Dependencies not installing
- Database connection errors
- Build failures

#### Create Architecture Documentation

Create `docs/architecture.md` with:

1. **System Architecture**
   - High-level diagram showing components
   - Backend (Spring Boot)
   - Frontend (React)
   - Database (H2)
   - How they communicate (REST API)

2. **Backend Architecture**
   - Layers: Controller, Service, Repository, Entity
   - Explain responsibility of each layer
   - Data flow diagram

3. **Frontend Architecture**
   - Component hierarchy
   - State management approach
   - API communication layer

4. **Database Schema**
   - Task table structure
   - Field descriptions
   - Relationships (if any)

5. **Design Decisions**
   - Why this architecture?
   - Key technology choices
   - Trade-offs made

#### Create Contributing Guide

Create `docs/contributing.md` with:

1. **How to Contribute**
   - Fork repository
   - Create feature branch
   - Make changes
   - Test thoroughly
   - Submit pull request

2. **Code Style**
   - Java code conventions
   - JavaScript/React conventions
   - Formatting tools (if any)
   - Linting rules

3. **Testing Requirements**
   - Must add tests for new features
   - Tests must pass before merging
   - Coverage expectations

4. **Pull Request Guidelines**
   - Description requirements
   - Checklist before submitting
   - Review process

### Success Criteria
- [ ] README is complete and accurate
- [ ] Setup instructions work for new developers
- [ ] Project structure is explained
- [ ] Architecture documentation exists
- [ ] Contributing guidelines are clear
- [ ] New developer can set up and run project using documentation

### Notes
Keep documentation in sync with code changes. Consider adding these docs to version control. Update README when significant changes are made.

---

## Documentation Maintenance

### Keeping Documentation Updated
- Update docs when API changes
- Update docs when features added or removed
- Review docs periodically for accuracy
- Include documentation updates in definition of done for features

### Documentation Best Practices
- Use simple, clear language
- Include examples
- Add visual aids (screenshots, diagrams)
- Keep formatting consistent
- Use proper grammar and spelling
- Link related documents together
- Version documentation with code

### Tools to Consider
- **Markdown** - Simple, text-based, version-controlled
- **Swagger/OpenAPI** - For API documentation
- **JSDoc** - For JavaScript code comments
- **Javadoc** - For Java code comments
- **Draw.io** or **Mermaid** - For diagrams
- **Screenshot tools** - For user guide images

---

## Quality Checklist for Documentation

Before considering documentation complete, verify:
- [ ] All instructions have been tested and work
- [ ] Links are correct and not broken
- [ ] Screenshots are up-to-date and clear
- [ ] Spelling and grammar are correct
- [ ] Code examples are accurate
- [ ] Formatting is consistent
- [ ] Technical terms are explained
- [ ] Documentation is easy to find
- [ ] Someone unfamiliar can follow instructions successfully

---

**Task File Owner**: Documentation Team Lead  
**Last Updated**: 2025-11-06  
**Status**: Ready for documentation
