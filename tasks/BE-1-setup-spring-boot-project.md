# BE-1: Set up Spring Boot Project Structure

## Task Information
- **Task ID**: BE-1
- **Phase**: Phase 1 - Backend Foundation
- **Effort Estimate**: 0.5 days
- **Priority**: High (Foundational)
- **Dependencies**: None

## Description

Verify and configure the Spring Boot project structure to ensure it's ready for development. This includes checking Maven dependencies, configuring application properties for H2 database and JPA, and ensuring the main application class exists and can start successfully.

## Objectives

1. Verify pom.xml has all necessary dependencies
2. Configure application.properties with H2 database settings
3. Ensure JPA/Hibernate configuration is correct
4. Verify main application class exists
5. Test that the application starts without errors

## Technical Details

### Required Dependencies (pom.xml)
- Spring Boot Starter Web
- Spring Boot Starter Data JPA
- H2 Database
- Spring Boot Starter Validation
- Spring Boot Starter Test
- Lombok (optional, for reducing boilerplate)

### Application Properties Configuration
```properties
# H2 Database Configuration
spring.datasource.url=jdbc:h2:mem:tododb
spring.datasource.driverClassName=org.h2.Driver
spring.datasource.username=sa
spring.datasource.password=

# JPA Configuration
spring.jpa.database-platform=org.hibernate.dialect.H2Dialect
spring.jpa.hibernate.ddl-auto=update
spring.jpa.show-sql=true

# H2 Console (for development)
spring.h2.console.enabled=true
spring.h2.console.path=/h2-console

# Server Configuration
server.port=8080
```

## Acceptance Criteria

- [ ] pom.xml contains all required Spring Boot dependencies
- [ ] application.properties or application.yml is configured with H2 database settings
- [ ] JPA/Hibernate is configured to auto-create tables
- [ ] H2 console is enabled for development
- [ ] Main application class exists with @SpringBootApplication annotation
- [ ] Application starts successfully without errors
- [ ] Application logs show successful H2 database initialization
- [ ] H2 console is accessible at http://localhost:8080/h2-console

## Testing Steps

1. Run `mvn clean install` - should complete successfully
2. Run `mvn spring-boot:run` - application should start
3. Check console output for errors
4. Access H2 console at http://localhost:8080/h2-console
5. Verify database connection works

## Definition of Done

- [ ] All acceptance criteria met
- [ ] Application starts without errors
- [ ] H2 database connects successfully
- [ ] Configuration documented in code comments
- [ ] Changes committed to version control

## Notes

- Use Spring Boot version 3.2.0 or compatible
- Ensure Java 21 is configured as the target version
- H2 is for development only; production will use a different database

## Related Files

- `pom.xml` - Maven dependencies
- `src/main/resources/application.properties` - Configuration
- `src/main/java/.../Application.java` - Main application class

## References

- [Spring Boot Documentation](https://docs.spring.io/spring-boot/docs/current/reference/html/)
- [H2 Database Documentation](https://www.h2database.com/html/main.html)
