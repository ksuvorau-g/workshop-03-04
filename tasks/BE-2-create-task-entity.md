# BE-2: Create Task Entity

## Task Information
- **ID**: BE-2
- **Phase**: Phase 1 - Backend Foundation
- **Estimated Effort**: 0.5 days (4 hours)
- **Assigned To**: Backend Developer
- **Status**: Not Started
- **Dependencies**: BE-1 (Spring Boot project setup)
- **Priority**: P0 (Must Have)

## Objective
Create the JPA entity class for the Task domain model with all required fields, validation annotations, and proper database mapping.

## Description
This task involves creating the core Task entity that represents a TODO item in the system. The entity will be mapped to a database table using JPA annotations and will include all necessary fields as defined in the requirements: ID, description, completion status, created date, and updated date. The entity will also include validation annotations to ensure data integrity.

## Acceptance Criteria
- [ ] Task entity class created in the correct package (`com.example.todo.entity` or similar)
- [ ] Entity includes all required fields:
  - `id` (Long) - primary key, auto-generated
  - `description` (String) - task description, validated for length
  - `completed` (Boolean) - completion status, defaults to false
  - `createdAt` (LocalDateTime) - timestamp of creation, auto-populated
  - `updatedAt` (LocalDateTime) - timestamp of last update, auto-populated on changes
- [ ] Appropriate JPA annotations applied (@Entity, @Table, @Id, @GeneratedValue, @Column)
- [ ] Validation annotations applied (@NotBlank, @Size, etc.)
- [ ] Lifecycle callbacks for timestamp management (@PrePersist, @PreUpdate)
- [ ] Getters, setters, constructors, equals, and hashCode methods implemented
- [ ] Entity can be persisted to H2 database successfully
- [ ] Basic unit test verifies entity constraints

## Technical Details

### Entity Class Implementation
```java
package com.example.todo.entity;

import jakarta.persistence.*;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.Size;
import java.time.LocalDateTime;
import java.util.Objects;

@Entity
@Table(name = "tasks")
public class Task {
    
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;
    
    @NotBlank(message = "Task description cannot be empty")
    @Size(min = 3, max = 500, message = "Task description must be between 3 and 500 characters")
    @Column(nullable = false, length = 500)
    private String description;
    
    @Column(nullable = false)
    private Boolean completed = false;
    
    @Column(nullable = false, updatable = false)
    private LocalDateTime createdAt;
    
    @Column(nullable = false)
    private LocalDateTime updatedAt;
    
    // Constructors
    public Task() {
    }
    
    public Task(String description) {
        this.description = description;
        this.completed = false;
    }
    
    // Lifecycle callbacks
    @PrePersist
    protected void onCreate() {
        createdAt = LocalDateTime.now();
        updatedAt = LocalDateTime.now();
    }
    
    @PreUpdate
    protected void onUpdate() {
        updatedAt = LocalDateTime.now();
    }
    
    // Getters and Setters
    public Long getId() {
        return id;
    }
    
    public void setId(Long id) {
        this.id = id;
    }
    
    public String getDescription() {
        return description;
    }
    
    public void setDescription(String description) {
        this.description = description;
    }
    
    public Boolean getCompleted() {
        return completed;
    }
    
    public void setCompleted(Boolean completed) {
        this.completed = completed;
    }
    
    public LocalDateTime getCreatedAt() {
        return createdAt;
    }
    
    public LocalDateTime getUpdatedAt() {
        return updatedAt;
    }
    
    // equals and hashCode
    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        Task task = (Task) o;
        return Objects.equals(id, task.id);
    }
    
    @Override
    public int hashCode() {
        return Objects.hash(id);
    }
    
    // toString
    @Override
    public String toString() {
        return "Task{" +
                "id=" + id +
                ", description='" + description + '\'' +
                ", completed=" + completed +
                ", createdAt=" + createdAt +
                ", updatedAt=" + updatedAt +
                '}';
    }
}
```

### Alternative: Using Lombok
If Lombok is available, the entity can be simplified:
```java
package com.example.todo.entity;

import jakarta.persistence.*;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.Size;
import lombok.*;
import java.time.LocalDateTime;

@Entity
@Table(name = "tasks")
@Data
@NoArgsConstructor
@AllArgsConstructor
public class Task {
    
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;
    
    @NotBlank(message = "Task description cannot be empty")
    @Size(min = 3, max = 500, message = "Task description must be between 3 and 500 characters")
    @Column(nullable = false, length = 500)
    private String description;
    
    @Column(nullable = false)
    private Boolean completed = false;
    
    @Column(nullable = false, updatable = false)
    private LocalDateTime createdAt;
    
    @Column(nullable = false)
    private LocalDateTime updatedAt;
    
    @PrePersist
    protected void onCreate() {
        createdAt = LocalDateTime.now();
        updatedAt = LocalDateTime.now();
    }
    
    @PreUpdate
    protected void onUpdate() {
        updatedAt = LocalDateTime.now();
    }
}
```

## Steps to Complete

1. **Create Package Structure**
   - Create package: `src/main/java/com/example/todo/entity`

2. **Create Task Entity Class**
   - Create `Task.java` in the entity package
   - Add `@Entity` and `@Table` annotations

3. **Define Fields**
   - Add `id` field with `@Id` and `@GeneratedValue`
   - Add `description` field with validation annotations
   - Add `completed` field with default value
   - Add `createdAt` and `updatedAt` fields
   - Use appropriate column constraints

4. **Implement Validation**
   - Add `@NotBlank` to description
   - Add `@Size(min = 3, max = 500)` to description
   - Ensure proper error messages

5. **Add Lifecycle Callbacks**
   - Implement `@PrePersist` method to set timestamps on creation
   - Implement `@PreUpdate` method to update updatedAt timestamp

6. **Generate/Implement Utility Methods**
   - Add constructors (no-arg and parameterized)
   - Add getters and setters for all fields
   - Implement equals and hashCode (using id)
   - Implement toString for debugging

7. **Test Entity**
   - Create unit test to verify entity creation
   - Test validation constraints
   - Test timestamp auto-population

## Testing Requirements

### Unit Test Example
```java
package com.example.todo.entity;

import jakarta.validation.ConstraintViolation;
import jakarta.validation.Validation;
import jakarta.validation.Validator;
import jakarta.validation.ValidatorFactory;
import org.junit.jupiter.api.BeforeAll;
import org.junit.jupiter.api.Test;
import java.util.Set;

import static org.junit.jupiter.api.Assertions.*;

class TaskTest {
    
    private static Validator validator;
    
    @BeforeAll
    static void setUp() {
        ValidatorFactory factory = Validation.buildDefaultValidatorFactory();
        validator = factory.getValidator();
    }
    
    @Test
    void testValidTask() {
        Task task = new Task("Complete project documentation");
        Set<ConstraintViolation<Task>> violations = validator.validate(task);
        assertTrue(violations.isEmpty());
    }
    
    @Test
    void testDescriptionTooShort() {
        Task task = new Task("ab");
        Set<ConstraintViolation<Task>> violations = validator.validate(task);
        assertFalse(violations.isEmpty());
    }
    
    @Test
    void testDescriptionTooLong() {
        String longDescription = "a".repeat(501);
        Task task = new Task(longDescription);
        Set<ConstraintViolation<Task>> violations = validator.validate(task);
        assertFalse(violations.isEmpty());
    }
    
    @Test
    void testDescriptionBlank() {
        Task task = new Task("   ");
        Set<ConstraintViolation<Task>> violations = validator.validate(task);
        assertFalse(violations.isEmpty());
    }
    
    @Test
    void testDefaultCompletedIsFalse() {
        Task task = new Task("Test task");
        assertFalse(task.getCompleted());
    }
}
```

### Integration Test (Optional for this task)
```java
@DataJpaTest
class TaskEntityIntegrationTest {
    
    @Autowired
    private TestEntityManager entityManager;
    
    @Test
    void testPersistTask() {
        Task task = new Task("Test task");
        Task saved = entityManager.persistAndFlush(task);
        
        assertNotNull(saved.getId());
        assertNotNull(saved.getCreatedAt());
        assertNotNull(saved.getUpdatedAt());
        assertEquals("Test task", saved.getDescription());
        assertFalse(saved.getCompleted());
    }
}
```

## Definition of Done
- [ ] Task entity class created with all required fields
- [ ] All JPA annotations properly applied
- [ ] Validation annotations configured
- [ ] Lifecycle callbacks implemented for timestamps
- [ ] Getters, setters, and utility methods implemented
- [ ] Unit tests written and passing
- [ ] Entity can be persisted to database (verified in integration test or BE-3)
- [ ] Code follows Java and Spring Boot best practices
- [ ] Code committed to feature branch
- [ ] Code reviewed and approved

## Common Issues and Solutions

### Issue: "createdAt" and "updatedAt" are null after persist
**Solution**: Ensure `@PrePersist` and `@PreUpdate` methods are present and not private

### Issue: Validation not working
**Solution**: Make sure spring-boot-starter-validation dependency is in pom.xml

### Issue: equals/hashCode causing issues with collections
**Solution**: Base equals and hashCode on id only, not on mutable fields

### Issue: Hibernate creates table with wrong column names
**Solution**: Use `@Column(name = "column_name")` to explicitly specify column names if needed

## Notes / Additional Context

- The Task entity is the core domain model for the entire application
- Follow JPA best practices for entity design
- Consider immutability where appropriate (e.g., createdAt should not have a setter)
- The timestamps are managed automatically by JPA lifecycle callbacks
- Validation happens at multiple levels: entity (Bean Validation), service layer, and database constraints
- For production, consider adding auditing fields (createdBy, updatedBy) when user auth is added

## Related Files

### Files to Create
- `/src/main/java/com/example/todo/entity/Task.java` - Main entity class
- `/src/test/java/com/example/todo/entity/TaskTest.java` - Unit tests

### Reference Files
- [Requirements Analysis](../docs/requirements/ba-analyze-raw-requirement.md) - Task properties specification
- [Implementation Plan](../docs/implementation-plan.md) - Phase 1 overview
- [JPA Documentation](https://jakarta.ee/specifications/persistence/3.1/) - JPA specification

## Next Steps
After completing this task, proceed to:
- **BE-3**: Create Task repository (uses this entity)
- **BE-4**: Create Task service layer (uses this entity and repository)
