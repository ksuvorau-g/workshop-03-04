# TEST-1: Backend Unit Tests

## Task Information
- **ID**: TEST-1
- **Phase**: Phase 3 - Testing & Quality Assurance
- **Estimated Effort**: 1 day (8 hours)
- **Assigned To**: Backend Developer / QA Engineer
- **Status**: Not Started
- **Dependencies**: BE-5 (REST controller must be complete)
- **Priority**: P0 (Must Have)

## Objective
Create comprehensive unit tests for the backend application, covering the Task entity, service layer, and controller layer to achieve >80% code coverage.

## Description
This task involves writing unit tests for all backend components developed in Phase 1. Tests will verify business logic, validation rules, error handling, and edge cases. The focus is on isolated unit tests using mocking for dependencies, ensuring each component works correctly in isolation before integration testing.

## Acceptance Criteria
- [ ] Unit tests written for Task entity validation
- [ ] Unit tests written for TaskService (all business logic methods)
- [ ] Unit tests written for TaskController (all endpoints)
- [ ] Test coverage >80% for backend code
- [ ] All tests pass consistently
- [ ] Tests follow naming conventions and best practices
- [ ] Mock objects used appropriately for dependencies
- [ ] Edge cases and error scenarios covered
- [ ] Tests are fast (no database connections in unit tests for service/controller)

## Technical Details

### Testing Framework Stack
- **JUnit 5** (Jupiter) - Testing framework
- **Mockito** - Mocking framework
- **AssertJ** (optional) - Fluent assertions
- **MockMvc** - For controller testing
- **Spring Boot Test** - Test utilities

### Entity Tests (TaskTest.java)
Already covered in BE-2, but ensure:
- Validation constraints tested
- Default values tested
- Edge cases (min/max length, null values)

### Service Layer Tests (TaskServiceTest.java)
```java
package com.example.todo.service;

import com.example.todo.entity.Task;
import com.example.todo.repository.TaskRepository;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.junit.jupiter.MockitoExtension;

import java.util.Arrays;
import java.util.List;
import java.util.Optional;

import static org.junit.jupiter.api.Assertions.*;
import static org.mockito.ArgumentMatchers.any;
import static org.mockito.ArgumentMatchers.anyLong;
import static org.mockito.Mockito.*;

@ExtendWith(MockitoExtension.class)
class TaskServiceTest {
    
    @Mock
    private TaskRepository taskRepository;
    
    @InjectMocks
    private TaskService taskService;
    
    private Task testTask;
    
    @BeforeEach
    void setUp() {
        testTask = new Task("Test task");
        testTask.setId(1L);
    }
    
    @Test
    void testCreateTask_Success() {
        when(taskRepository.save(any(Task.class))).thenReturn(testTask);
        
        Task created = taskService.createTask("Test task");
        
        assertNotNull(created);
        assertEquals("Test task", created.getDescription());
        assertFalse(created.getCompleted());
        verify(taskRepository, times(1)).save(any(Task.class));
    }
    
    @Test
    void testCreateTask_EmptyDescription_ThrowsException() {
        assertThrows(IllegalArgumentException.class, () -> {
            taskService.createTask("");
        });
        verify(taskRepository, never()).save(any(Task.class));
    }
    
    @Test
    void testCreateTask_DescriptionTooShort_ThrowsException() {
        assertThrows(IllegalArgumentException.class, () -> {
            taskService.createTask("ab");
        });
        verify(taskRepository, never()).save(any(Task.class));
    }
    
    @Test
    void testCreateTask_DescriptionTooLong_ThrowsException() {
        String longDesc = "a".repeat(501);
        assertThrows(IllegalArgumentException.class, () -> {
            taskService.createTask(longDesc);
        });
        verify(taskRepository, never()).save(any(Task.class));
    }
    
    @Test
    void testGetAllTasks_Success() {
        List<Task> tasks = Arrays.asList(testTask, new Task("Task 2"));
        when(taskRepository.findAllByOrderByCreatedAtDesc()).thenReturn(tasks);
        
        List<Task> result = taskService.getAllTasks();
        
        assertEquals(2, result.size());
        verify(taskRepository, times(1)).findAllByOrderByCreatedAtDesc();
    }
    
    @Test
    void testGetTaskById_Found() {
        when(taskRepository.findById(1L)).thenReturn(Optional.of(testTask));
        
        Optional<Task> result = taskService.getTaskById(1L);
        
        assertTrue(result.isPresent());
        assertEquals(testTask.getId(), result.get().getId());
        verify(taskRepository, times(1)).findById(1L);
    }
    
    @Test
    void testGetTaskById_NotFound() {
        when(taskRepository.findById(anyLong())).thenReturn(Optional.empty());
        
        Optional<Task> result = taskService.getTaskById(999L);
        
        assertFalse(result.isPresent());
    }
    
    @Test
    void testUpdateTask_Success() {
        Task updatedTask = new Task("Updated description");
        updatedTask.setId(1L);
        
        when(taskRepository.findById(1L)).thenReturn(Optional.of(testTask));
        when(taskRepository.save(any(Task.class))).thenReturn(updatedTask);
        
        Task result = taskService.updateTask(1L, "Updated description", false);
        
        assertNotNull(result);
        assertEquals("Updated description", result.getDescription());
        verify(taskRepository, times(1)).save(any(Task.class));
    }
    
    @Test
    void testUpdateTask_NotFound_ThrowsException() {
        when(taskRepository.findById(anyLong())).thenReturn(Optional.empty());
        
        assertThrows(RuntimeException.class, () -> {
            taskService.updateTask(999L, "New description", false);
        });
        verify(taskRepository, never()).save(any(Task.class));
    }
    
    @Test
    void testToggleTaskCompletion_Success() {
        when(taskRepository.findById(1L)).thenReturn(Optional.of(testTask));
        when(taskRepository.save(any(Task.class))).thenReturn(testTask);
        
        Task result = taskService.toggleTaskCompletion(1L);
        
        assertTrue(result.getCompleted());
        verify(taskRepository, times(1)).save(any(Task.class));
    }
    
    @Test
    void testDeleteTask_Success() {
        when(taskRepository.existsById(1L)).thenReturn(true);
        doNothing().when(taskRepository).deleteById(1L);
        
        taskService.deleteTask(1L);
        
        verify(taskRepository, times(1)).deleteById(1L);
    }
    
    @Test
    void testDeleteTask_NotFound_ThrowsException() {
        when(taskRepository.existsById(anyLong())).thenReturn(false);
        
        assertThrows(RuntimeException.class, () -> {
            taskService.deleteTask(999L);
        });
        verify(taskRepository, never()).deleteById(anyLong());
    }
    
    @Test
    void testGetTasksByStatus_Active() {
        List<Task> activeTasks = Arrays.asList(testTask);
        when(taskRepository.findByCompletedOrderByCreatedAtDesc(false))
            .thenReturn(activeTasks);
        
        List<Task> result = taskService.getTasksByStatus(false);
        
        assertEquals(1, result.size());
        verify(taskRepository, times(1)).findByCompletedOrderByCreatedAtDesc(false);
    }
}
```

### Controller Layer Tests (TaskControllerTest.java)
```java
package com.example.todo.controller;

import com.example.todo.entity.Task;
import com.example.todo.service.TaskService;
import com.fasterxml.jackson.databind.ObjectMapper;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.autoconfigure.web.servlet.WebMvcTest;
import org.springframework.boot.test.mock.mockito.MockBean;
import org.springframework.http.MediaType;
import org.springframework.test.web.servlet.MockMvc;

import java.util.Arrays;
import java.util.Optional;

import static org.mockito.ArgumentMatchers.*;
import static org.mockito.Mockito.*;
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.*;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.*;

@WebMvcTest(TaskController.class)
class TaskControllerTest {
    
    @Autowired
    private MockMvc mockMvc;
    
    @MockBean
    private TaskService taskService;
    
    @Autowired
    private ObjectMapper objectMapper;
    
    private Task testTask;
    
    @BeforeEach
    void setUp() {
        testTask = new Task("Test task");
        testTask.setId(1L);
    }
    
    @Test
    void testGetAllTasks_Success() throws Exception {
        when(taskService.getAllTasks()).thenReturn(Arrays.asList(testTask));
        
        mockMvc.perform(get("/api/tasks"))
            .andExpect(status().isOk())
            .andExpect(jsonPath("$[0].description").value("Test task"));
    }
    
    @Test
    void testGetTaskById_Found() throws Exception {
        when(taskService.getTaskById(1L)).thenReturn(Optional.of(testTask));
        
        mockMvc.perform(get("/api/tasks/1"))
            .andExpect(status().isOk())
            .andExpect(jsonPath("$.description").value("Test task"));
    }
    
    @Test
    void testGetTaskById_NotFound() throws Exception {
        when(taskService.getTaskById(anyLong())).thenReturn(Optional.empty());
        
        mockMvc.perform(get("/api/tasks/999"))
            .andExpect(status().isNotFound());
    }
    
    @Test
    void testCreateTask_Success() throws Exception {
        when(taskService.createTask(anyString())).thenReturn(testTask);
        
        mockMvc.perform(post("/api/tasks")
                .contentType(MediaType.APPLICATION_JSON)
                .content("{\"description\":\"Test task\"}"))
            .andExpect(status().isCreated())
            .andExpect(jsonPath("$.description").value("Test task"));
    }
    
    @Test
    void testCreateTask_InvalidDescription() throws Exception {
        mockMvc.perform(post("/api/tasks")
                .contentType(MediaType.APPLICATION_JSON)
                .content("{\"description\":\"\"}"))
            .andExpect(status().isBadRequest());
    }
    
    @Test
    void testUpdateTask_Success() throws Exception {
        when(taskService.updateTask(eq(1L), anyString(), anyBoolean()))
            .thenReturn(testTask);
        
        mockMvc.perform(put("/api/tasks/1")
                .contentType(MediaType.APPLICATION_JSON)
                .content("{\"description\":\"Updated\",\"completed\":false}"))
            .andExpect(status().isOk());
    }
    
    @Test
    void testDeleteTask_Success() throws Exception {
        doNothing().when(taskService).deleteTask(1L);
        
        mockMvc.perform(delete("/api/tasks/1"))
            .andExpect(status().isNoContent());
    }
}
```

## Steps to Complete

1. **Review Existing Tests**
   - Check BE-2 and BE-3 for existing entity and repository tests
   - Identify gaps in coverage

2. **Write Service Layer Tests**
   - Create TaskServiceTest.java
   - Test all public methods
   - Test validation logic
   - Test error scenarios
   - Use Mockito to mock repository

3. **Write Controller Layer Tests**
   - Create TaskControllerTest.java
   - Test all endpoints (GET, POST, PUT, DELETE)
   - Test request validation
   - Test error responses
   - Use MockMvc for HTTP testing

4. **Run Tests**
   - Execute `mvn test`
   - Verify all tests pass
   - Check for flaky tests

5. **Generate Coverage Report**
   - Run `mvn test jacoco:report`
   - Check coverage in `target/site/jacoco/index.html`
   - Ensure >80% coverage

6. **Fix Failing Tests**
   - Debug and fix any failing tests
   - Ensure tests are deterministic

## Testing Requirements

### Test Execution
```bash
# Run all tests
mvn test

# Run specific test class
mvn test -Dtest=TaskServiceTest

# Run with coverage
mvn test jacoco:report
```

### Coverage Requirements
- **Overall**: >80%
- **Service Layer**: >90%
- **Controller Layer**: >80%
- **Entity Layer**: >70%

## Definition of Done
- [ ] All service methods have unit tests
- [ ] All controller endpoints have unit tests
- [ ] Edge cases and error scenarios covered
- [ ] Code coverage >80%
- [ ] All tests pass consistently
- [ ] No flaky tests
- [ ] Tests follow naming conventions (testMethodName_Scenario_ExpectedResult)
- [ ] Tests are fast (<5 seconds total)
- [ ] Coverage report generated
- [ ] Code committed and reviewed

## Common Issues and Solutions

### Issue: Tests failing intermittently
**Solution**: Check for timing issues, shared state, or dependencies on external resources

### Issue: MockMvc tests return 404
**Solution**: Verify @WebMvcTest includes the correct controller class

### Issue: Mockito mocks not working
**Solution**: Ensure @ExtendWith(MockitoExtension.class) is present and mocks are injected correctly

### Issue: Coverage report shows low coverage
**Solution**: Add tests for untested branches, ensure Jacoco plugin is configured correctly

## Notes / Additional Context

- Unit tests should be fast and isolated
- Use mocks to eliminate external dependencies
- Follow AAA pattern: Arrange, Act, Assert
- One assertion per test when possible
- Use descriptive test names
- Group related tests with @Nested classes if needed
- Test both happy path and error scenarios
- Don't test framework code, only your business logic

## Related Files

### Files to Create
- `/src/test/java/com/example/todo/service/TaskServiceTest.java`
- `/src/test/java/com/example/todo/controller/TaskControllerTest.java`

### Files Already Tested (from previous tasks)
- `/src/test/java/com/example/todo/entity/TaskTest.java` (BE-2)
- `/src/test/java/com/example/todo/repository/TaskRepositoryTest.java` (BE-3)

### Reference Files
- [Requirements Analysis](../docs/requirements/ba-analyze-raw-requirement.md)
- [Implementation Plan](../docs/implementation-plan.md)
- [JUnit 5 Documentation](https://junit.org/junit5/docs/current/user-guide/)
- [Mockito Documentation](https://javadoc.io/doc/org.mockito/mockito-core/latest/org/mockito/Mockito.html)

## Next Steps
After completing this task, proceed to:
- **TEST-2**: Backend integration tests
- **TEST-3**: Frontend unit tests (can run in parallel)
