# BE-2: Create Task Entity

## Task Information
- **Task ID**: BE-2
- **Phase**: Phase 1 - Backend Foundation
- **Effort Estimate**: 0.5 days
- **Priority**: High
- **Dependencies**: BE-1 (Spring Boot project setup)

## Description

Create the JPA Task entity that represents a TODO task in the database. This entity will include all required fields (id, description, completed status, timestamps) and appropriate validation annotations to enforce business rules.

## Objectives

1. Create Task entity class with JPA annotations
2. Define all required fields with proper data types
3. Add validation constraints
4. Implement getters/setters (or use Lombok)
5. Add timestamps for created and updated dates
6. Test entity persistence to H2 database

## Technical Details

### Task Entity Fields
- **id**: Long (Primary Key, Auto-generated)
- **description**: String (Required, 3-500 characters)
- **completed**: Boolean (Default: false)
- **createdAt**: LocalDateTime (Auto-set on creation)
- **updatedAt**: LocalDateTime (Auto-set on update)

### Validation Rules
- Description: Not null, not blank, min 3 chars, max 500 chars
- Description: Cannot be only whitespace
- Completed: Not null

### Example Structure
```java
@Entity
@Table(name = "tasks")
public class Task {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;
    
    @NotBlank(message = "Description cannot be empty")
    @Size(min = 3, max = 500, message = "Description must be between 3 and 500 characters")
    private String description;
    
    @NotNull
    private Boolean completed = false;
    
    @CreatedDate
    private LocalDateTime createdAt;
    
    @LastModifiedDate
    private LocalDateTime updatedAt;
    
    // Constructors, getters, setters
}
```

## Acceptance Criteria

- [ ] Task entity class exists with @Entity annotation
- [ ] All required fields are defined with correct data types
- [ ] Validation annotations are applied (e.g., @NotBlank, @Size)
- [ ] Default value for 'completed' is false
- [ ] Timestamps (createdAt, updatedAt) are auto-managed
- [ ] Entity can be persisted to H2 database
- [ ] Database table 'tasks' is auto-created on application startup
- [ ] Field constraints are enforced at database level

## Testing Steps

1. Start the application with BE-1 configuration
2. Check H2 console to verify 'tasks' table was created
3. Verify table schema matches entity definition
4. Test validation by attempting to create invalid Task instances
5. Verify default values are set correctly

## Definition of Done

- [ ] All acceptance criteria met
- [ ] Entity class created and annotated correctly
- [ ] Validation annotations tested
- [ ] Database table verified in H2 console
- [ ] Code follows Java naming conventions
- [ ] Changes committed to version control

## Notes

- Use `@EntityListeners(AuditingEntityListener.class)` if using Spring Data JPA auditing for timestamps
- Enable JPA auditing in main application class with `@EnableJpaAuditing`
- Consider using Lombok's `@Data` annotation to reduce boilerplate
- Ensure proper equals() and hashCode() implementation if needed

## Related Files

- `src/main/java/.../entity/Task.java` - Entity class
- `src/main/java/.../Application.java` - May need @EnableJpaAuditing

## Validation Examples

Valid task:
```java
Task task = new Task();
task.setDescription("Buy groceries");
task.setCompleted(false);
// Should save successfully
```

Invalid task (too short):
```java
Task task = new Task();
task.setDescription("Hi");  // Only 2 characters
// Should fail validation
```

## References

- [Spring Data JPA Documentation](https://docs.spring.io/spring-data/jpa/docs/current/reference/html/)
- [Jakarta Bean Validation](https://beanvalidation.org/)
