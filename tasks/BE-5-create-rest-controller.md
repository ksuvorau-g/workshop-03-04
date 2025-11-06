# BE-5: Create REST Controller

## Task Information
- **Task ID**: BE-5
- **Phase**: Phase 1 - Backend Foundation
- **Effort Estimate**: 1 day
- **Priority**: High
- **Dependencies**: BE-4 (Task service layer created)

## Description

Implement the REST API controller that exposes HTTP endpoints for task management. The controller will handle HTTP requests, delegate business logic to the service layer, and return appropriate HTTP responses with correct status codes.

## Objectives

1. Create TaskController with RESTful endpoints
2. Implement all CRUD operations as HTTP endpoints
3. Use proper HTTP methods and status codes
4. Add request/response DTOs if needed
5. Implement global exception handling
6. Write integration tests for all endpoints

## Technical Details

### REST Endpoints

| Method | Endpoint | Description | Status Code |
|--------|----------|-------------|-------------|
| GET | /api/tasks | Get all tasks | 200 OK |
| GET | /api/tasks/{id} | Get task by ID | 200 OK / 404 Not Found |
| POST | /api/tasks | Create new task | 201 Created |
| PUT | /api/tasks/{id} | Update task | 200 OK / 404 Not Found |
| PATCH | /api/tasks/{id}/toggle | Toggle completion | 200 OK / 404 Not Found |
| DELETE | /api/tasks/{id} | Delete task | 204 No Content / 404 Not Found |

### Controller Structure
```java
@RestController
@RequestMapping("/api/tasks")
public class TaskController {
    
    private final TaskService taskService;
    
    public TaskController(TaskService taskService) {
        this.taskService = taskService;
    }
    
    @GetMapping
    public ResponseEntity<List<Task>> getAllTasks(
        @RequestParam(required = false) Boolean completed
    );
    
    @GetMapping("/{id}")
    public ResponseEntity<Task> getTaskById(@PathVariable Long id);
    
    @PostMapping
    public ResponseEntity<Task> createTask(@Valid @RequestBody CreateTaskRequest request);
    
    @PutMapping("/{id}")
    public ResponseEntity<Task> updateTask(
        @PathVariable Long id, 
        @Valid @RequestBody UpdateTaskRequest request
    );
    
    @PatchMapping("/{id}/toggle")
    public ResponseEntity<Task> toggleTaskCompletion(@PathVariable Long id);
    
    @DeleteMapping("/{id}")
    public ResponseEntity<Void> deleteTask(@PathVariable Long id);
}
```

### Request DTOs
```java
public class CreateTaskRequest {
    @NotBlank(message = "Description is required")
    @Size(min = 3, max = 500)
    private String description;
    // Getters and setters
}

public class UpdateTaskRequest {
    @NotBlank(message = "Description is required")
    @Size(min = 3, max = 500)
    private String description;
    // Getters and setters
}
```

## Acceptance Criteria

- [ ] TaskController class created with @RestController
- [ ] All REST endpoints implemented:
  - [ ] GET /api/tasks (with optional completed query param)
  - [ ] GET /api/tasks/{id}
  - [ ] POST /api/tasks
  - [ ] PUT /api/tasks/{id}
  - [ ] PATCH /api/tasks/{id}/toggle
  - [ ] DELETE /api/tasks/{id}
- [ ] Proper HTTP status codes returned for all scenarios
- [ ] Request validation using @Valid annotation
- [ ] Global exception handler created with @ControllerAdvice
- [ ] Error responses include meaningful messages
- [ ] Integration tests cover all endpoints
- [ ] API documentation comments added

## Testing Scenarios

### Test 1: Create Task - Success
```
POST /api/tasks
Body: {"description": "Buy groceries"}
Expected: 201 Created, returns created task with ID
```

### Test 2: Create Task - Validation Failure
```
POST /api/tasks
Body: {"description": "Hi"}  // Too short
Expected: 400 Bad Request, error message about length
```

### Test 3: Get All Tasks
```
GET /api/tasks
Expected: 200 OK, returns array of all tasks
```

### Test 4: Get Tasks Filtered by Status
```
GET /api/tasks?completed=true
Expected: 200 OK, returns only completed tasks
```

### Test 5: Get Task By ID - Success
```
GET /api/tasks/1
Expected: 200 OK, returns task with ID 1
```

### Test 6: Get Task By ID - Not Found
```
GET /api/tasks/999
Expected: 404 Not Found, error message
```

### Test 7: Update Task - Success
```
PUT /api/tasks/1
Body: {"description": "Updated description"}
Expected: 200 OK, returns updated task
```

### Test 8: Update Task - Not Found
```
PUT /api/tasks/999
Body: {"description": "Updated description"}
Expected: 404 Not Found
```

### Test 9: Toggle Task Completion
```
PATCH /api/tasks/1/toggle
Expected: 200 OK, returns task with toggled completion status
```

### Test 10: Delete Task - Success
```
DELETE /api/tasks/1
Expected: 204 No Content
```

### Test 11: Delete Task - Not Found
```
DELETE /api/tasks/999
Expected: 404 Not Found
```

## Definition of Done

- [ ] All acceptance criteria met
- [ ] Controller implemented with all endpoints
- [ ] Request DTOs created with validation
- [ ] Global exception handler implemented
- [ ] All integration tests pass
- [ ] Proper HTTP status codes verified
- [ ] Error responses tested
- [ ] Code reviewed
- [ ] Changes committed to version control

## Global Exception Handler

```java
@ControllerAdvice
public class GlobalExceptionHandler {
    
    @ExceptionHandler(TaskNotFoundException.class)
    public ResponseEntity<ErrorResponse> handleTaskNotFound(TaskNotFoundException ex) {
        ErrorResponse error = new ErrorResponse(
            HttpStatus.NOT_FOUND.value(),
            ex.getMessage(),
            LocalDateTime.now()
        );
        return new ResponseEntity<>(error, HttpStatus.NOT_FOUND);
    }
    
    @ExceptionHandler(InvalidTaskException.class)
    public ResponseEntity<ErrorResponse> handleInvalidTask(InvalidTaskException ex) {
        ErrorResponse error = new ErrorResponse(
            HttpStatus.BAD_REQUEST.value(),
            ex.getMessage(),
            LocalDateTime.now()
        );
        return new ResponseEntity<>(error, HttpStatus.BAD_REQUEST);
    }
    
    @ExceptionHandler(MethodArgumentNotValidException.class)
    public ResponseEntity<ErrorResponse> handleValidationErrors(
        MethodArgumentNotValidException ex
    ) {
        // Extract validation errors and return 400 Bad Request
    }
}
```

## Error Response DTO
```java
public class ErrorResponse {
    private int status;
    private String message;
    private LocalDateTime timestamp;
    
    // Constructors, getters, setters
}
```

## Notes

- Use @RequestParam for query parameters (filtering)
- Use @PathVariable for URL path variables (IDs)
- Use @RequestBody for request payloads
- Always validate input with @Valid
- Return appropriate ResponseEntity with status codes
- Consider using DTOs instead of exposing entities directly

## Related Files

- `src/main/java/.../controller/TaskController.java` - Controller
- `src/main/java/.../dto/CreateTaskRequest.java` - Request DTO
- `src/main/java/.../dto/UpdateTaskRequest.java` - Request DTO
- `src/main/java/.../dto/ErrorResponse.java` - Error response DTO
- `src/main/java/.../exception/GlobalExceptionHandler.java` - Exception handler
- `src/test/java/.../controller/TaskControllerTest.java` - Integration tests

## Integration Testing
Use Spring Boot's MockMvc for integration testing:
```java
@SpringBootTest
@AutoConfigureMockMvc
class TaskControllerTest {
    
    @Autowired
    private MockMvc mockMvc;
    
    @Test
    void shouldCreateTask() throws Exception {
        mockMvc.perform(post("/api/tasks")
            .contentType(MediaType.APPLICATION_JSON)
            .content("{\"description\":\"Test task\"}"))
            .andExpect(status().isCreated())
            .andExpect(jsonPath("$.description").value("Test task"));
    }
}
```

## References

- [Spring MVC Documentation](https://docs.spring.io/spring-framework/docs/current/reference/html/web.html)
- [REST API Best Practices](https://restfulapi.net/)
- [HTTP Status Codes](https://httpstatuses.com/)
