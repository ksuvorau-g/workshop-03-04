# BE-1: Set up Spring Boot Project Structure

## Task Information
- **ID**: BE-1
- **Phase**: Phase 1 - Backend Foundation
- **Estimated Effort**: 0.5 days (4 hours)
- **Assigned To**: Backend Developer
- **Status**: Not Started
- **Dependencies**: None (first task)
- **Priority**: P0 (Must Have)

## Objective
Verify and configure the Spring Boot project structure, ensuring all necessary dependencies are present and the application can start successfully with H2 database configuration.

## Description
This task establishes the foundation for the backend application. Since the project already has a `pom.xml`, we need to verify that all required Spring Boot dependencies are present, configure the application properties for H2 database and JPA, and ensure the main application class is properly set up. The goal is to have a running Spring Boot application that can connect to an in-memory H2 database.

## Acceptance Criteria
- [ ] `pom.xml` contains all required dependencies:
  - Spring Boot Starter Web
  - Spring Boot Starter Data JPA
  - H2 Database
  - Spring Boot Starter Test
  - Spring Boot Starter Validation
- [ ] `application.properties` or `application.yml` is configured with:
  - H2 database connection settings
  - JPA/Hibernate configuration
  - Server port (default 8080)
  - Logging levels
- [ ] Main application class exists with `@SpringBootApplication` annotation
- [ ] Application starts successfully without errors
- [ ] H2 console is accessible (optional, for debugging)
- [ ] Application responds to health check endpoint (if using Spring Boot Actuator)

## Technical Details

### Required Dependencies (pom.xml)
```xml
<dependencies>
    <!-- Spring Boot Web -->
    <dependency>
        <groupId>org.springframework.boot</groupId>
        <artifactId>spring-boot-starter-web</artifactId>
    </dependency>
    
    <!-- Spring Data JPA -->
    <dependency>
        <groupId>org.springframework.boot</groupId>
        <artifactId>spring-boot-starter-data-jpa</artifactId>
    </dependency>
    
    <!-- H2 Database -->
    <dependency>
        <groupId>com.h2database</groupId>
        <artifactId>h2</artifactId>
        <scope>runtime</scope>
    </dependency>
    
    <!-- Validation -->
    <dependency>
        <groupId>org.springframework.boot</groupId>
        <artifactId>spring-boot-starter-validation</artifactId>
    </dependency>
    
    <!-- Test Dependencies -->
    <dependency>
        <groupId>org.springframework.boot</groupId>
        <artifactId>spring-boot-starter-test</artifactId>
        <scope>test</scope>
    </dependency>
</dependencies>
```

### Application Configuration (application.properties)
```properties
# Server Configuration
server.port=8080

# H2 Database Configuration
spring.datasource.url=jdbc:h2:mem:tododb
spring.datasource.driverClassName=org.h2.Driver
spring.datasource.username=sa
spring.datasource.password=

# JPA/Hibernate Configuration
spring.jpa.database-platform=org.hibernate.dialect.H2Dialect
spring.jpa.hibernate.ddl-auto=create-drop
spring.jpa.show-sql=true
spring.jpa.properties.hibernate.format_sql=true

# H2 Console (optional, for debugging)
spring.h2.console.enabled=true
spring.h2.console.path=/h2-console

# Logging
logging.level.org.springframework.web=INFO
logging.level.org.hibernate=INFO
```

### Main Application Class
```java
package com.example.todo;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;

@SpringBootApplication
public class TodoApplication {
    public static void main(String[] args) {
        SpringApplication.run(TodoApplication.class, args);
    }
}
```

## Steps to Complete

1. **Verify Existing Structure**
   - Check if `pom.xml` exists in the project root
   - Review current dependencies
   - Check for existing `src/main/java` and `src/main/resources` directories

2. **Update Dependencies**
   - Add missing dependencies to `pom.xml`
   - Verify Spring Boot version (should be 3.2.0 or compatible with Java 21)
   - Run `mvn dependency:resolve` to download dependencies

3. **Create/Update Application Configuration**
   - Create `src/main/resources/application.properties`
   - Add H2 database configuration
   - Add JPA/Hibernate settings
   - Configure server port

4. **Verify/Create Main Application Class**
   - Check for existing main application class
   - Create if not present: `src/main/java/com/example/todo/TodoApplication.java`
   - Add `@SpringBootApplication` annotation
   - Implement main method

5. **Test Application Startup**
   - Run `mvn clean install` to build the project
   - Start the application: `mvn spring-boot:run`
   - Verify application starts without errors
   - Check logs for successful database initialization
   - Test H2 console access at `http://localhost:8080/h2-console` (if enabled)

6. **Create Basic Test**
   - Create a basic context load test to verify Spring configuration
   - Location: `src/test/java/com/example/todo/TodoApplicationTests.java`

## Testing Requirements

### Manual Testing
- [ ] Run `mvn clean install` - build succeeds
- [ ] Run `mvn spring-boot:run` - application starts
- [ ] Application logs show "Started TodoApplication in X seconds"
- [ ] No exceptions or errors in console
- [ ] H2 console accessible at http://localhost:8080/h2-console (if enabled)
- [ ] Application can be stopped without errors (Ctrl+C)

### Automated Testing
```java
@SpringBootTest
class TodoApplicationTests {
    @Test
    void contextLoads() {
        // Verifies Spring context loads successfully
    }
}
```

## Definition of Done
- [ ] All required dependencies present in pom.xml
- [ ] Application.properties properly configured for H2 and JPA
- [ ] Main application class created with correct annotations
- [ ] `mvn clean install` completes successfully
- [ ] Application starts without errors
- [ ] Context load test passes
- [ ] Code committed to feature branch
- [ ] Documentation updated (if needed)

## Common Issues and Solutions

### Issue: Application fails to start with "Cannot determine embedded database driver class"
**Solution**: Verify H2 dependency is present in pom.xml with `<scope>runtime</scope>`

### Issue: Port 8080 already in use
**Solution**: Change port in application.properties: `server.port=8081` or stop the conflicting process

### Issue: Maven build fails
**Solution**: Ensure Java 21 is installed and JAVA_HOME is set correctly. Run `mvn -version` to verify.

### Issue: H2 console not accessible
**Solution**: Verify `spring.h2.console.enabled=true` in application.properties

## Notes / Additional Context

- This is the first task in the project, establishing the foundation for all backend work
- The project structure should follow standard Spring Boot conventions
- Use H2 in-memory database for development; production will use a different database
- Keep configuration externalized in application.properties for easy environment-specific changes
- Consider using profiles (dev, prod) for different environments in the future

## Related Files

### Files to Create/Modify
- `/pom.xml` - Add/verify dependencies
- `/src/main/resources/application.properties` - Database and JPA configuration
- `/src/main/java/com/example/todo/TodoApplication.java` - Main application class
- `/src/test/java/com/example/todo/TodoApplicationTests.java` - Basic context test

### Reference Files
- [Requirements Analysis](../docs/requirements/ba-analyze-raw-requirement.md) - Non-functional requirements
- [Implementation Plan](../docs/implementation-plan.md) - Phase 1 overview
- [Spring Boot Documentation](https://docs.spring.io/spring-boot/docs/current/reference/html/) - Official reference

## Next Steps
After completing this task, proceed to:
- **BE-2**: Create Task entity
- **BE-3**: Create Task repository (can start in parallel with BE-2)
