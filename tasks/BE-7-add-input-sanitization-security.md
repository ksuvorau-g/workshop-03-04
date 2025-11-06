# BE-7: Add Input Sanitization and Security

## Task Information
- **Task ID**: BE-7
- **Phase**: Phase 1 - Backend Foundation
- **Effort Estimate**: 0.5 days
- **Priority**: High
- **Dependencies**: BE-5 (REST controller created)

## Description

Implement input sanitization and security measures to protect the application from common vulnerabilities such as XSS (Cross-Site Scripting), SQL Injection, and other malicious inputs. This includes validating and sanitizing user inputs, implementing security headers, and following security best practices.

## Objectives

1. Add HTML sanitization for task descriptions
2. Ensure SQL injection protection (verify JPA handles this)
3. Implement security headers
4. Add input validation at multiple layers
5. Implement rate limiting (optional for MVP)
6. Document security measures

## Technical Details

### Input Sanitization

```java
@Service
public class InputSanitizationService {
    
    private final PolicyFactory policy;
    
    public InputSanitizationService() {
        // Use OWASP Java HTML Sanitizer
        this.policy = Sanitizers.FORMATTING.and(Sanitizers.LINKS);
    }
    
    public String sanitizeInput(String input) {
        if (input == null) {
            return null;
        }
        // Remove HTML tags and potentially dangerous content
        return policy.sanitize(input.trim());
    }
    
    public String sanitizeDescription(String description) {
        String sanitized = sanitizeInput(description);
        // Additional validation
        if (sanitized == null || sanitized.isBlank()) {
            throw new InvalidTaskException("Description cannot be empty");
        }
        return sanitized;
    }
}
```

### Security Headers Configuration

```java
@Configuration
@EnableWebSecurity
public class SecurityConfig {
    
    @Bean
    public SecurityFilterChain filterChain(HttpSecurity http) throws Exception {
        http
            .headers(headers -> headers
                .contentSecurityPolicy(csp -> csp
                    .policyDirectives("default-src 'self'"))
                .xssProtection(xss -> xss.headerValue(XXssProtectionHeaderWriter.HeaderValue.ENABLED_MODE_BLOCK))
                .contentTypeOptions(Customizer.withDefaults())
                .frameOptions(frame -> frame.deny())
            )
            .csrf(csrf -> csrf.disable()) // Disable for REST API
            .cors(Customizer.withDefaults())
            .authorizeHttpRequests(auth -> auth
                .anyRequest().permitAll() // No auth required for MVP
            );
        
        return http.build();
    }
}
```

### Enhanced Validation

```java
public class CreateTaskRequest {
    
    @NotBlank(message = "Description is required")
    @Size(min = 3, max = 500, message = "Description must be between 3 and 500 characters")
    @Pattern(regexp = "^[\\s\\S]*$", message = "Description contains invalid characters")
    private String description;
    
    // Getter and setter
}
```

### Updated Service Layer

```java
@Service
public class TaskService {
    
    private final TaskRepository taskRepository;
    private final InputSanitizationService sanitizationService;
    
    public TaskService(TaskRepository taskRepository, 
                      InputSanitizationService sanitizationService) {
        this.taskRepository = taskRepository;
        this.sanitizationService = sanitizationService;
    }
    
    public Task createTask(String description) {
        // Sanitize input before processing
        String sanitizedDescription = sanitizationService.sanitizeDescription(description);
        
        Task task = new Task();
        task.setDescription(sanitizedDescription);
        task.setCompleted(false);
        
        return taskRepository.save(task);
    }
    
    // Other methods similarly updated
}
```

## Acceptance Criteria

- [ ] Input sanitization service created
- [ ] HTML tags and scripts removed from task descriptions
- [ ] SQL injection protection verified (JPA parameterized queries)
- [ ] Security headers configured (XSS, CSP, etc.)
- [ ] CSRF protection configured appropriately for REST API
- [ ] Input validation at both controller and service layers
- [ ] XSS attempts blocked and sanitized
- [ ] Security tests pass
- [ ] Security measures documented

## Security Testing Scenarios

### Test 1: XSS Attempt - Script Tag
```json
POST /api/tasks
Body: {"description": "<script>alert('XSS')</script>Buy groceries"}
Expected: Task created with sanitized description (script tag removed)
```

### Test 2: XSS Attempt - Event Handler
```json
POST /api/tasks
Body: {"description": "<img src=x onerror='alert(1)'>Task"}
Expected: Dangerous attributes removed or entire tag stripped
```

### Test 3: SQL Injection Attempt
```json
POST /api/tasks
Body: {"description": "'; DROP TABLE tasks; --"}
Expected: Treated as literal string, no SQL executed
```

### Test 4: Long Input Attack
```json
POST /api/tasks
Body: {"description": "A" * 10000}
Expected: 400 Bad Request (exceeds 500 char limit)
```

### Test 5: Unicode and Special Characters
```json
POST /api/tasks
Body: {"description": "Buy groceries 🛒 & milk"}
Expected: Task created successfully with unicode preserved
```

### Test 6: Null and Empty Inputs
```json
POST /api/tasks
Body: {"description": null}
Expected: 400 Bad Request
```

```json
POST /api/tasks
Body: {"description": "   "}
Expected: 400 Bad Request (whitespace only)
```

## Definition of Done

- [ ] All acceptance criteria met
- [ ] Input sanitization service implemented
- [ ] Security headers configured
- [ ] All security tests pass
- [ ] XSS and SQL injection attempts blocked
- [ ] No security vulnerabilities in code scan
- [ ] Security measures documented
- [ ] Code reviewed with security focus
- [ ] Changes committed to version control

## Dependencies to Add

Add to `pom.xml`:
```xml
<!-- OWASP Java HTML Sanitizer -->
<dependency>
    <groupId>com.googlecode.owasp-java-html-sanitizer</groupId>
    <artifactId>owasp-java-html-sanitizer</artifactId>
    <version>20220608.1</version>
</dependency>

<!-- Spring Security (for headers) -->
<dependency>
    <groupId>org.springframework.boot</groupId>
    <artifactId>spring-boot-starter-security</artifactId>
</dependency>
```

## Security Best Practices Checklist

- [ ] Input validation on all user inputs
- [ ] Output encoding when rendering user content
- [ ] Parameterized queries (JPA handles this)
- [ ] Security headers configured
- [ ] HTTPS enforced in production
- [ ] Sensitive data not logged
- [ ] Error messages don't reveal system details
- [ ] Dependencies regularly updated
- [ ] Security scanning in CI/CD pipeline

## Common Vulnerabilities to Address

### 1. Cross-Site Scripting (XSS)
**Risk**: Malicious scripts executed in user's browser
**Mitigation**: Sanitize all user inputs, set CSP headers

### 2. SQL Injection
**Risk**: Unauthorized database access or manipulation
**Mitigation**: Use JPA/Hibernate (automatic parameterization)

### 3. Sensitive Data Exposure
**Risk**: Leaking system information in error messages
**Mitigation**: Generic error messages to users, detailed logs for developers

### 4. Missing Security Headers
**Risk**: Various browser-based attacks
**Mitigation**: Configure security headers (XSS, CSP, X-Frame-Options)

### 5. Excessive Data Exposure
**Risk**: API returns more data than necessary
**Mitigation**: Use DTOs to control exposed fields

## Notes

- Spring Data JPA uses parameterized queries by default (SQL injection protected)
- Don't disable CSRF for same-origin web applications
- For REST APIs consumed by separate frontends, CSRF can be disabled
- Always sanitize before storing, not just before displaying
- Log security-related events for monitoring
- Consider rate limiting for production (Spring Security, Bucket4j)

## Related Files

- `src/main/java/.../service/InputSanitizationService.java` - Sanitization
- `src/main/java/.../config/SecurityConfig.java` - Security configuration
- `src/main/java/.../service/TaskService.java` - Updated with sanitization
- `src/test/java/.../security/SecurityTest.java` - Security tests
- `pom.xml` - Security dependencies

## Testing Security Headers

```bash
curl -I http://localhost:8080/api/tasks
```

Expected headers:
```
X-Content-Type-Options: nosniff
X-XSS-Protection: 1; mode=block
X-Frame-Options: DENY
Content-Security-Policy: default-src 'self'
```

## References

- [OWASP Top 10](https://owasp.org/www-project-top-ten/)
- [OWASP Java HTML Sanitizer](https://github.com/OWASP/java-html-sanitizer)
- [Spring Security Documentation](https://docs.spring.io/spring-security/reference/)
- [Input Validation Cheat Sheet](https://cheatsheetseries.owasp.org/cheatsheets/Input_Validation_Cheat_Sheet.html)
