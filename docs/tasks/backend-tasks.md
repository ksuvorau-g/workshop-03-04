# Backend Development Tasks

**Phase**: 1 - Backend Foundation  
**Estimated Duration**: 3-4 days  
**Dependencies**: None (can start immediately)  
**Team**: Backend Developer(s)

---

## Overview

These tasks build the server-side foundation of the TODO application. The backend handles data storage, business logic, and provides API endpoints for the frontend to communicate with. All tasks should be completed in order as each builds on the previous one.

---

## Task BE-1: Set Up Spring Boot Project Structure

**Estimated Time**: 0.5 days (4 hours)  
**Priority**: Critical - Must be done first  
**Dependencies**: None

### Description
Verify and configure the Spring Boot project foundation to ensure the application can start successfully and is ready for development.

### What Needs to Be Done
1. Check that the pom.xml file contains all necessary dependencies:
   - Spring Boot Starter Web (for REST API)
   - Spring Boot Starter Data JPA (for database operations)
   - H2 Database (for data storage)
   - Spring Boot Starter Validation (for input validation)
   - Spring Boot Starter Test (for testing)

2. Configure the application.properties file with:
   - H2 database connection settings
   - JPA settings for automatic table creation
   - Server port configuration
   - Logging level settings

3. Verify the main application class exists and has proper annotations

4. Test that the application starts without errors

### Success Criteria
- [ ] Application starts successfully with no errors in console
- [ ] H2 database console is accessible (if enabled)
- [ ] Project builds successfully using Maven
- [ ] All dependencies download without issues

### Testing
Run the application and verify it starts. Check the console for any error messages.

---

## Task BE-2: Create Task Entity

**Estimated Time**: 0.5 days (4 hours)  
**Priority**: Critical  
**Dependencies**: BE-1 must be complete

### Description
Create the Task entity class that represents a TODO task in the database. This is the core data structure of the application.

### What Needs to Be Done
1. Create a Task class with these properties:
   - id: Unique identifier (long number, automatically generated)
   - description: Text describing the task (required, 3-500 characters)
   - completed: True/false flag indicating if task is done
   - createdAt: Date and time when task was created
   - updatedAt: Date and time when task was last modified

2. Add proper annotations to mark this as a database entity

3. Add validation rules to ensure data quality:
   - description must not be empty
   - description must be between 3 and 500 characters
   - description cannot be only whitespace

4. Add getter and setter methods for all properties

5. Configure automatic timestamp updates for createdAt and updatedAt

### Success Criteria
- [ ] Task entity class is created with all required fields
- [ ] Validation annotations are properly applied
- [ ] Database table is automatically created when application starts
- [ ] Test data can be saved to database

### Testing
Create a simple test that saves a task to the database and retrieves it to confirm the entity works correctly.

---

## Task BE-3: Create Task Repository

**Estimated Time**: 0.5 days (4 hours)  
**Priority**: Critical  
**Dependencies**: BE-2 must be complete

### Description
Create the repository interface that handles database operations for tasks. This provides methods to save, retrieve, update, and delete tasks.

### What Needs to Be Done
1. Create a TaskRepository interface that extends the standard repository interface

2. The interface will automatically provide these methods:
   - save: Add new task or update existing task
   - findById: Get a specific task by its ID
   - findAll: Get all tasks
   - deleteById: Remove a task

3. Add custom query methods if needed:
   - findByCompleted: Get all tasks with specific completion status
   - Method to get tasks sorted by creation date

4. Ensure all methods return appropriate data types

### Success Criteria
- [ ] Repository interface is created correctly
- [ ] Basic CRUD operations work (Create, Read, Update, Delete)
- [ ] Custom query methods return expected results
- [ ] Database operations complete without errors

### Testing
Write tests that use the repository to create, read, update, and delete tasks. Verify that custom query methods work as expected.

---

## Task BE-4: Create Task Service Layer

**Estimated Time**: 1 day (8 hours)  
**Priority**: Critical  
**Dependencies**: BE-3 must be complete

### Description
Create the service class that contains business logic for task operations. This sits between the API endpoints and the database, handling validation and business rules.

### What Needs to Be Done
1. Create a TaskService class with these methods:
   - createTask: Add a new task with validation
   - getAllTasks: Retrieve all tasks from database
   - getTaskById: Get a specific task by ID
   - updateTask: Modify an existing task
   - deleteTask: Remove a task
   - toggleTaskCompletion: Switch task between completed and pending

2. Implement business logic and validation:
   - Validate task description meets requirements (3-500 chars, not empty, not whitespace)
   - Check if task exists before updating or deleting
   - Update timestamps appropriately
   - Handle error cases (task not found, invalid data, etc.)

3. Ensure methods return appropriate responses:
   - Success: return the task data
   - Error: throw appropriate exceptions with helpful messages

4. Make the service easy to test by keeping methods focused

### Success Criteria
- [ ] All service methods are implemented
- [ ] Validation logic works correctly for all edge cases
- [ ] Error handling provides clear, helpful messages
- [ ] Unit tests pass for all methods with good coverage

### Testing
Write comprehensive unit tests covering:
- Normal operation (happy path)
- Invalid input (too short, too long, empty, whitespace)
- Error cases (task not found, null values)
- Edge cases (exactly 3 characters, exactly 500 characters)

---

## Task BE-5: Create REST Controller

**Estimated Time**: 1 day (8 hours)  
**Priority**: Critical  
**Dependencies**: BE-4 must be complete

### Description
Create the REST API controller that exposes HTTP endpoints for the frontend to interact with. This is how the user interface communicates with the server.

### What Needs to Be Done
1. Create a TaskController class with these API endpoints:
   - GET /api/tasks - Get all tasks (returns list of all tasks)
   - GET /api/tasks/{id} - Get specific task by ID
   - POST /api/tasks - Create new task (receives task data, returns created task)
   - PUT /api/tasks/{id} - Update existing task (receives task data, returns updated task)
   - DELETE /api/tasks/{id} - Delete task (returns nothing on success)
   - PATCH /api/tasks/{id}/toggle - Toggle task completion status

2. Map incoming data to proper formats using DTOs if needed

3. Return appropriate HTTP status codes:
   - 200 OK: Successful retrieval or update
   - 201 Created: Successful task creation
   - 204 No Content: Successful deletion
   - 400 Bad Request: Invalid input
   - 404 Not Found: Task doesn't exist
   - 500 Internal Server Error: Unexpected problems

4. Add error handling to catch exceptions and return helpful error messages

5. Format responses consistently (all responses use same structure)

### Success Criteria
- [ ] All API endpoints are implemented and accessible
- [ ] Endpoints return correct HTTP status codes
- [ ] Request and response data formats are consistent
- [ ] Error messages are clear and helpful
- [ ] Integration tests pass for all endpoints

### Testing
Write integration tests that:
- Call each endpoint with valid data
- Test error cases (invalid IDs, malformed requests)
- Verify response formats
- Check status codes
- Test the complete flow from request to database and back

---

## Task BE-6: Add CORS Configuration

**Estimated Time**: 0.5 days (4 hours)  
**Priority**: High  
**Dependencies**: BE-5 must be complete

### Description
Configure Cross-Origin Resource Sharing (CORS) to allow the frontend application to make requests to the backend API. Without this, web browsers will block the communication between frontend and backend.

### What Needs to Be Done
1. Create a CORS configuration class

2. Allow requests from the frontend origin (e.g., http://localhost:3000 for development)

3. Configure which HTTP methods are allowed (GET, POST, PUT, DELETE, PATCH)

4. Allow necessary headers for API communication

5. Set up different configurations for development and production environments

### Success Criteria
- [ ] Frontend can successfully make API calls without CORS errors
- [ ] All HTTP methods work from frontend
- [ ] Browser console shows no CORS-related errors
- [ ] Configuration works in both development and production

### Testing
- Use the frontend application (or a tool like Postman) to make requests from a different origin
- Verify browser console shows no CORS errors
- Test all HTTP methods work correctly

---

## Task BE-7: Add Input Sanitization and Security

**Estimated Time**: 0.5 days (4 hours)  
**Priority**: High  
**Dependencies**: BE-5 must be complete

### Description
Add security measures to protect against common web vulnerabilities like Cross-Site Scripting (XSS) and SQL Injection.

### What Needs to Be Done
1. Ensure all user input is validated before processing:
   - Check for required fields
   - Verify data types are correct
   - Validate length constraints
   - Reject dangerous characters if needed

2. Sanitize text input to remove or escape potentially harmful content:
   - Remove or escape HTML tags
   - Handle special characters safely
   - Prevent script injection

3. Ensure database queries use parameterized queries (Spring Data JPA does this automatically, but verify)

4. Add input validation at the controller level as a backup to service layer validation

5. Test for common security vulnerabilities

### Success Criteria
- [ ] All user input is validated and sanitized
- [ ] Application is protected against XSS attacks
- [ ] Application is protected against SQL injection
- [ ] Security tests pass
- [ ] No dangerous content can be stored in database

### Testing
- Try to submit malicious input (HTML tags, script tags, SQL commands)
- Verify harmful content is sanitized or rejected
- Use security scanning tools if available
- Test with very long input strings
- Test with special characters and Unicode

---

## Notes for Developers

### Best Practices
- Write tests alongside code (test-driven development)
- Keep methods small and focused on one task
- Use meaningful names for variables and methods
- Add comments only for complex logic that isn't self-explanatory
- Follow existing code style in the project
- Commit code frequently with clear commit messages

### Common Pitfalls to Avoid
- Don't skip validation - always check input data
- Don't hardcode values - use configuration files
- Don't ignore exceptions - handle them appropriately
- Don't forget to update timestamps when modifying tasks
- Don't expose internal errors to API consumers - provide user-friendly messages

### Resources
- Spring Boot documentation: https://spring.io/projects/spring-boot
- Spring Data JPA guide: https://spring.io/guides/gs/accessing-data-jpa/
- REST API best practices: Review existing examples in similar projects
- H2 database documentation: http://www.h2database.com/

---

**Task File Owner**: Backend Team Lead  
**Last Updated**: 2025-11-06  
**Status**: Ready for development
