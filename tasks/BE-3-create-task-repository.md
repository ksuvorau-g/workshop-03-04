# BE-3: Create Task Repository

## Task Information
- **Task ID**: BE-3
- **Phase**: Phase 1 - Backend Foundation
- **Effort Estimate**: 0.5 days
- **Priority**: High
- **Dependencies**: BE-2 (Task entity created)

## Description

Create the Spring Data JPA repository interface for the Task entity. This repository will provide all standard CRUD operations and custom query methods needed for task management.

## Objectives

1. Create TaskRepository interface extending JpaRepository
2. Add custom query methods for filtering tasks
3. Verify repository methods work with H2 database
4. Test basic CRUD operations

## Technical Details

### Repository Interface
```java
@Repository
public interface TaskRepository extends JpaRepository<Task, Long> {
    
    // Find all completed tasks
    List<Task> findByCompleted(Boolean completed);
    
    // Find all tasks ordered by creation date (newest first)
    List<Task> findAllByOrderByCreatedAtDesc();
    
    // Find completed tasks ordered by creation date
    List<Task> findByCompletedOrderByCreatedAtDesc(Boolean completed);
}
```

### Standard Methods Provided by JpaRepository
- `save(Task task)` - Create or update a task
- `findById(Long id)` - Find task by ID
- `findAll()` - Get all tasks
- `deleteById(Long id)` - Delete task by ID
- `existsById(Long id)` - Check if task exists
- `count()` - Count all tasks

## Acceptance Criteria

- [ ] TaskRepository interface created extending JpaRepository<Task, Long>
- [ ] Interface annotated with @Repository
- [ ] Custom query method `findByCompleted()` defined for filtering
- [ ] Custom query method for ordering by creation date defined
- [ ] Repository can perform all CRUD operations
- [ ] Custom query methods return correct results
- [ ] Repository properly integrated with Spring context

## Testing Steps

1. Create a simple test class or use application startup to test
2. Test save operation - create and persist a task
3. Test findById - retrieve the saved task
4. Test findAll - verify all tasks are returned
5. Test findByCompleted - filter by completion status
6. Test delete operation
7. Verify operations in H2 console

## Test Scenarios

### Test 1: Save and Retrieve
```java
Task task = new Task();
task.setDescription("Test task");
task.setCompleted(false);
Task saved = repository.save(task);
Optional<Task> found = repository.findById(saved.getId());
// Verify: found.isPresent() == true
```

### Test 2: Filter by Completion Status
```java
// Create completed and pending tasks
Task completed = new Task("Completed task", true);
Task pending = new Task("Pending task", false);
repository.save(completed);
repository.save(pending);

List<Task> completedTasks = repository.findByCompleted(true);
// Verify: completedTasks.size() == 1
```

### Test 3: Order by Creation Date
```java
// Create multiple tasks
List<Task> tasks = repository.findAllByOrderByCreatedAtDesc();
// Verify: tasks are in reverse chronological order
```

## Definition of Done

- [ ] All acceptance criteria met
- [ ] Repository interface created and properly annotated
- [ ] Custom query methods defined
- [ ] Basic CRUD operations tested and working
- [ ] Custom queries tested and returning correct results
- [ ] No errors in application logs
- [ ] Changes committed to version control

## Notes

- Spring Data JPA automatically implements the repository interface
- No need to write implementation code for standard or derived query methods
- Query method names must follow Spring Data naming conventions
- Consider adding @Transactional annotations at service layer, not repository

## Related Files

- `src/main/java/.../repository/TaskRepository.java` - Repository interface
- `src/main/java/.../entity/Task.java` - Task entity (dependency)

## Common Pitfalls

- Not using proper method naming conventions for derived queries
- Forgetting @Repository annotation
- Incorrect generic types in JpaRepository<Task, Long>

## References

- [Spring Data JPA Repository Documentation](https://docs.spring.io/spring-data/jpa/docs/current/reference/html/#repositories)
- [Query Methods](https://docs.spring.io/spring-data/jpa/docs/current/reference/html/#repositories.query-methods)
