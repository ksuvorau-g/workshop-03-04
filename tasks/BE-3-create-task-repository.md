# BE-3: Create Task Repository

## Task Information
- **ID**: BE-3
- **Phase**: Phase 1 - Backend Foundation
- **Estimated Effort**: 0.5 days (4 hours)
- **Assigned To**: Backend Developer
- **Status**: Not Started
- **Dependencies**: BE-2 (Task entity must exist)
- **Priority**: P0 (Must Have)

## Objective
Create the Spring Data JPA repository interface for the Task entity, providing standard CRUD operations and custom query methods for filtering tasks.

## Description
This task involves creating a repository interface that extends JpaRepository to provide database access for Task entities. The repository will include standard CRUD operations out-of-the-box and custom query methods for finding tasks by completion status, which is needed for the filtering feature.

## Acceptance Criteria
- [ ] TaskRepository interface created extending JpaRepository<Task, Long>
- [ ] Custom query method for finding tasks by completion status exists
- [ ] Custom query method for counting tasks by completion status exists (optional but useful)
- [ ] Repository can perform all basic CRUD operations (Create, Read, Update, Delete)
- [ ] Integration test verifies repository operations work correctly
- [ ] Repository follows Spring Data JPA naming conventions

## Technical Details

### Repository Interface Implementation
```java
package com.example.todo.repository;

import com.example.todo.entity.Task;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;
import java.util.List;

@Repository
public interface TaskRepository extends JpaRepository<Task, Long> {
    
    /**
     * Find all tasks by completion status.
     * Used for filtering tasks (Active/Completed).
     *
     * @param completed the completion status to filter by
     * @return list of tasks matching the status
     */
    List<Task> findByCompleted(Boolean completed);
    
    /**
     * Count tasks by completion status.
     * Useful for displaying task counts in the UI.
     *
     * @param completed the completion status to count
     * @return number of tasks with the given status
     */
    Long countByCompleted(Boolean completed);
    
    /**
     * Find tasks ordered by creation date descending (newest first).
     * This is the default sort order for the application.
     *
     * @return list of all tasks sorted by creation date (newest first)
     */
    List<Task> findAllByOrderByCreatedAtDesc();
    
    /**
     * Find tasks by completion status ordered by creation date descending.
     * Combines filtering and sorting.
     *
     * @param completed the completion status to filter by
     * @return list of filtered tasks sorted by creation date (newest first)
     */
    List<Task> findByCompletedOrderByCreatedAtDesc(Boolean completed);
}
```

### Alternative: Using @Query Annotation
For more complex queries, you can use @Query:
```java
package com.example.todo.repository;

import com.example.todo.entity.Task;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;
import java.util.List;

@Repository
public interface TaskRepository extends JpaRepository<Task, Long> {
    
    List<Task> findByCompleted(Boolean completed);
    
    @Query("SELECT COUNT(t) FROM Task t WHERE t.completed = :completed")
    Long countByCompletedStatus(@Param("completed") Boolean completed);
    
    @Query("SELECT t FROM Task t ORDER BY t.createdAt DESC")
    List<Task> findAllSortedByCreatedDate();
}
```

## Steps to Complete

1. **Create Package Structure**
   - Create package: `src/main/java/com/example/todo/repository`

2. **Create Repository Interface**
   - Create `TaskRepository.java` interface
   - Add `@Repository` annotation (optional but recommended for clarity)
   - Extend `JpaRepository<Task, Long>`

3. **Define Custom Query Methods**
   - Add `findByCompleted(Boolean completed)` method
   - Add `countByCompleted(Boolean completed)` method
   - Add `findAllByOrderByCreatedAtDesc()` method
   - Add `findByCompletedOrderByCreatedAtDesc(Boolean completed)` method

4. **Add JavaDoc Comments**
   - Document each method's purpose
   - Explain parameters and return values
   - Note any special behavior

5. **Create Integration Tests**
   - Set up test data
   - Test all query methods
   - Verify results are correct

## Testing Requirements

### Integration Test
```java
package com.example.todo.repository;

import com.example.todo.entity.Task;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.autoconfigure.orm.jpa.DataJpaTest;
import org.springframework.boot.test.autoconfigure.orm.jpa.TestEntityManager;

import java.util.List;
import java.util.Optional;

import static org.junit.jupiter.api.Assertions.*;

@DataJpaTest
class TaskRepositoryTest {
    
    @Autowired
    private TaskRepository taskRepository;
    
    @Autowired
    private TestEntityManager entityManager;
    
    @BeforeEach
    void setUp() {
        // Clear database before each test
        taskRepository.deleteAll();
    }
    
    @Test
    void testSaveTask() {
        Task task = new Task("Test task");
        Task saved = taskRepository.save(task);
        
        assertNotNull(saved.getId());
        assertEquals("Test task", saved.getDescription());
        assertFalse(saved.getCompleted());
    }
    
    @Test
    void testFindById() {
        Task task = new Task("Test task");
        Task saved = taskRepository.save(task);
        
        Optional<Task> found = taskRepository.findById(saved.getId());
        
        assertTrue(found.isPresent());
        assertEquals(saved.getId(), found.get().getId());
    }
    
    @Test
    void testFindAll() {
        taskRepository.save(new Task("Task 1"));
        taskRepository.save(new Task("Task 2"));
        taskRepository.save(new Task("Task 3"));
        
        List<Task> tasks = taskRepository.findAll();
        
        assertEquals(3, tasks.size());
    }
    
    @Test
    void testFindByCompleted() {
        Task task1 = new Task("Task 1");
        task1.setCompleted(false);
        taskRepository.save(task1);
        
        Task task2 = new Task("Task 2");
        task2.setCompleted(true);
        taskRepository.save(task2);
        
        Task task3 = new Task("Task 3");
        task3.setCompleted(false);
        taskRepository.save(task3);
        
        List<Task> activeTasks = taskRepository.findByCompleted(false);
        List<Task> completedTasks = taskRepository.findByCompleted(true);
        
        assertEquals(2, activeTasks.size());
        assertEquals(1, completedTasks.size());
    }
    
    @Test
    void testCountByCompleted() {
        Task task1 = new Task("Task 1");
        task1.setCompleted(false);
        taskRepository.save(task1);
        
        Task task2 = new Task("Task 2");
        task2.setCompleted(true);
        taskRepository.save(task2);
        
        Task task3 = new Task("Task 3");
        task3.setCompleted(false);
        taskRepository.save(task3);
        
        Long activeCount = taskRepository.countByCompleted(false);
        Long completedCount = taskRepository.countByCompleted(true);
        
        assertEquals(2L, activeCount);
        assertEquals(1L, completedCount);
    }
    
    @Test
    void testFindAllByOrderByCreatedAtDesc() throws InterruptedException {
        Task task1 = new Task("First task");
        taskRepository.save(task1);
        
        Thread.sleep(10); // Ensure different timestamps
        
        Task task2 = new Task("Second task");
        taskRepository.save(task2);
        
        Thread.sleep(10);
        
        Task task3 = new Task("Third task");
        taskRepository.save(task3);
        
        List<Task> tasks = taskRepository.findAllByOrderByCreatedAtDesc();
        
        assertEquals(3, tasks.size());
        assertEquals("Third task", tasks.get(0).getDescription()); // Newest first
        assertEquals("First task", tasks.get(2).getDescription()); // Oldest last
    }
    
    @Test
    void testUpdateTask() {
        Task task = new Task("Original description");
        Task saved = taskRepository.save(task);
        
        saved.setDescription("Updated description");
        saved.setCompleted(true);
        Task updated = taskRepository.save(saved);
        
        assertEquals("Updated description", updated.getDescription());
        assertTrue(updated.getCompleted());
        assertNotNull(updated.getUpdatedAt());
    }
    
    @Test
    void testDeleteTask() {
        Task task = new Task("Task to delete");
        Task saved = taskRepository.save(task);
        Long id = saved.getId();
        
        taskRepository.deleteById(id);
        
        Optional<Task> found = taskRepository.findById(id);
        assertFalse(found.isPresent());
    }
}
```

## Definition of Done
- [ ] TaskRepository interface created and properly annotated
- [ ] Extends JpaRepository<Task, Long>
- [ ] Custom query methods implemented
- [ ] JavaDoc comments added for all methods
- [ ] Integration tests written and passing (at least 8 tests)
- [ ] All CRUD operations tested
- [ ] Custom query methods tested
- [ ] Code follows Spring Data JPA conventions
- [ ] Code committed to feature branch
- [ ] Code reviewed and approved

## Common Issues and Solutions

### Issue: Repository methods not recognized by IDE
**Solution**: Ensure Spring Data JPA dependency is in pom.xml and Maven dependencies are reloaded

### Issue: Query methods return empty results
**Solution**: Check method naming follows Spring Data naming conventions, or use @Query with JPQL

### Issue: Tests fail with "No qualifying bean of type 'TaskRepository'"
**Solution**: Use @DataJpaTest annotation for repository tests, not @SpringBootTest

### Issue: Timestamp ordering not working as expected
**Solution**: Add small delays between saves in tests, or use explicit timestamps for testing

## Notes / Additional Context

- Spring Data JPA automatically implements the repository interface at runtime
- No need to write implementation classes - Spring Data generates them
- Method names follow conventions: `findBy`, `countBy`, `deleteBy`, `OrderBy`, etc.
- For complex queries, use @Query annotation with JPQL or native SQL
- Repository beans are automatically discovered by component scanning
- Use @Transactional in service layer, not in repository layer
- Integration tests use @DataJpaTest which sets up an in-memory database automatically

### Spring Data Query Method Naming Conventions
- `findBy...` - Returns entities matching criteria
- `countBy...` - Returns count of entities matching criteria
- `deleteBy...` - Deletes entities matching criteria
- `...OrderBy...Desc/Asc` - Sorts results
- `...And...` / `...Or...` - Combines conditions

## Related Files

### Files to Create
- `/src/main/java/com/example/todo/repository/TaskRepository.java` - Repository interface
- `/src/test/java/com/example/todo/repository/TaskRepositoryTest.java` - Integration tests

### Files to Reference
- `/src/main/java/com/example/todo/entity/Task.java` - Entity being persisted

### Reference Documentation
- [Spring Data JPA Documentation](https://docs.spring.io/spring-data/jpa/docs/current/reference/html/)
- [Query Methods Documentation](https://docs.spring.io/spring-data/jpa/docs/current/reference/html/#jpa.query-methods)
- [Requirements Analysis](../docs/requirements/ba-analyze-raw-requirement.md)

## Next Steps
After completing this task, proceed to:
- **BE-4**: Create Task service layer (uses this repository)
- Begin unit tests for future service layer
