# BE-4: Create Task Service Layer

## Task Information
- **Task ID**: BE-4
- **Phase**: Phase 1 - Backend Foundation
- **Effort Estimate**: 1 day
- **Priority**: High
- **Dependencies**: BE-3 (Task repository created)

## Description

Implement the service layer that contains business logic for task management. The service will handle all CRUD operations, input validation, error handling, and business rules enforcement. This layer sits between the REST controller and the repository.

## Objectives

1. Create TaskService class with business logic methods
2. Implement all CRUD operations (create, read, update, delete)
3. Add task completion toggle functionality
4. Implement input validation and business rules
5. Handle error scenarios (task not found, validation failures)
6. Write comprehensive unit tests

## Technical Details

### Service Methods
```java
@Service
public class TaskService {
    
    private final TaskRepository taskRepository;
    
    // Constructor injection
    public TaskService(TaskRepository taskRepository) {
        this.taskRepository = taskRepository;
    }
    
    // Create a new task
    public Task createTask(String description);
    
    // Get all tasks
    public List<Task> getAllTasks();
    
    // Get all tasks ordered by creation date
    public List<Task> getAllTasksSorted();
    
    // Get tasks filtered by completion status
    public List<Task> getTasksByStatus(Boolean completed);
    
    // Get single task by ID
    public Task getTaskById(Long id);
    
    // Update task description
    public Task updateTask(Long id, String description);
    
    // Toggle task completion status
    public Task toggleTaskCompletion(Long id);
    
    // Delete task
    public void deleteTask(Long id);
}
```

### Business Rules
- Description must be 3-500 characters
- Description cannot be only whitespace
- Task ID must exist for update/delete operations
- UpdatedAt timestamp updated on every modification

## Acceptance Criteria

- [ ] TaskService class created and annotated with @Service
- [ ] All required methods implemented:
  - [ ] createTask()
  - [ ] getAllTasks()
  - [ ] getTasksByStatus()
  - [ ] getTaskById()
  - [ ] updateTask()
  - [ ] toggleTaskCompletion()
  - [ ] deleteTask()
- [ ] Input validation performed before database operations
- [ ] Throws appropriate exceptions for invalid operations
- [ ] Custom exception class for TaskNotFoundException created
- [ ] UpdatedAt timestamp automatically updated on changes
- [ ] Unit tests cover all methods and edge cases
- [ ] Test coverage >80%

## Testing Scenarios

### Test 1: Create Task - Success
```java
String description = "Buy groceries";
Task task = service.createTask(description);
// Verify: task is not null, has ID, description matches, completed is false
```

### Test 2: Create Task - Validation Failure
```java
String shortDescription = "Hi";  // Only 2 characters
// Should throw ValidationException
```

### Test 3: Get Task By ID - Not Found
```java
Long nonExistentId = 999L;
// Should throw TaskNotFoundException
```

### Test 4: Update Task
```java
Task task = service.createTask("Original description");
Task updated = service.updateTask(task.getId(), "Updated description");
// Verify: description changed, updatedAt is newer than createdAt
```

### Test 5: Toggle Completion
```java
Task task = service.createTask("Test task");
// Initially: completed == false
Task toggled = service.toggleTaskCompletion(task.getId());
// Verify: completed == true
Task toggledAgain = service.toggleTaskCompletion(task.getId());
// Verify: completed == false
```

### Test 6: Filter By Status
```java
service.createTask("Task 1");  // completed = false
Task task2 = service.createTask("Task 2");
service.toggleTaskCompletion(task2.getId());  // completed = true

List<Task> completed = service.getTasksByStatus(true);
List<Task> pending = service.getTasksByStatus(false);
// Verify: completed.size() == 1, pending.size() == 1
```

### Test 7: Delete Task
```java
Task task = service.createTask("To be deleted");
service.deleteTask(task.getId());
// Verify: getTaskById throws TaskNotFoundException
```

## Definition of Done

- [ ] All acceptance criteria met
- [ ] Service class implemented with all methods
- [ ] Business logic correctly handles all scenarios
- [ ] Custom exceptions created and used appropriately
- [ ] Unit tests written for all methods
- [ ] All unit tests pass
- [ ] Code coverage >80%
- [ ] Code reviewed and follows best practices
- [ ] Changes committed to version control

## Error Handling

### Custom Exceptions
```java
@ResponseStatus(HttpStatus.NOT_FOUND)
public class TaskNotFoundException extends RuntimeException {
    public TaskNotFoundException(Long id) {
        super("Task not found with id: " + id);
    }
}

@ResponseStatus(HttpStatus.BAD_REQUEST)
public class InvalidTaskException extends RuntimeException {
    public InvalidTaskException(String message) {
        super(message);
    }
}
```

## Notes

- Use constructor injection instead of @Autowired for better testability
- Annotate service methods with @Transactional if needed
- Consider using Optional<Task> for getTaskById and handle gracefully
- Validate input at service layer even if controller does validation
- Log important operations for debugging

## Related Files

- `src/main/java/.../service/TaskService.java` - Service implementation
- `src/main/java/.../repository/TaskRepository.java` - Repository (dependency)
- `src/main/java/.../entity/Task.java` - Task entity (dependency)
- `src/main/java/.../exception/TaskNotFoundException.java` - Custom exception
- `src/test/java/.../service/TaskServiceTest.java` - Unit tests

## Validation Helper
```java
private void validateDescription(String description) {
    if (description == null || description.isBlank()) {
        throw new InvalidTaskException("Description cannot be empty");
    }
    if (description.length() < 3) {
        throw new InvalidTaskException("Description must be at least 3 characters");
    }
    if (description.length() > 500) {
        throw new InvalidTaskException("Description cannot exceed 500 characters");
    }
}
```

## References

- [Spring Service Layer Best Practices](https://docs.spring.io/spring-framework/docs/current/reference/html/core.html)
- [Unit Testing with JUnit 5](https://junit.org/junit5/docs/current/user-guide/)
- [Mockito for Mocking](https://site.mockito.org/)
