# BE-6: Add CORS Configuration

## Task Information
- **Task ID**: BE-6
- **Phase**: Phase 1 - Backend Foundation
- **Effort Estimate**: 0.5 days
- **Priority**: High
- **Dependencies**: BE-5 (REST controller created)

## Description

Configure Cross-Origin Resource Sharing (CORS) to allow the React frontend application to make API calls to the Spring Boot backend. Without proper CORS configuration, browsers will block frontend requests to the backend due to same-origin policy.

## Objectives

1. Create CORS configuration class
2. Allow frontend origin (React dev server)
3. Configure allowed HTTP methods
4. Set appropriate headers
5. Test CORS from frontend
6. Document CORS settings

## Technical Details

### CORS Configuration
```java
@Configuration
public class CorsConfig implements WebMvcConfigurer {
    
    @Override
    public void addCorsMappings(CorsRegistry registry) {
        registry.addMapping("/api/**")
            .allowedOrigins("http://localhost:3000") // React dev server
            .allowedMethods("GET", "POST", "PUT", "PATCH", "DELETE", "OPTIONS")
            .allowedHeaders("*")
            .allowCredentials(true)
            .maxAge(3600);
    }
}
```

### Alternative: Using @CrossOrigin Annotation
```java
@RestController
@RequestMapping("/api/tasks")
@CrossOrigin(origins = "http://localhost:3000")
public class TaskController {
    // Controller methods
}
```

### Environment-Specific Configuration
```properties
# application.properties
cors.allowed.origins=http://localhost:3000
```

```java
@Configuration
public class CorsConfig implements WebMvcConfigurer {
    
    @Value("${cors.allowed.origins}")
    private String allowedOrigins;
    
    @Override
    public void addCorsMappings(CorsRegistry registry) {
        registry.addMapping("/api/**")
            .allowedOrigins(allowedOrigins.split(","))
            .allowedMethods("GET", "POST", "PUT", "PATCH", "DELETE", "OPTIONS")
            .allowedHeaders("*")
            .allowCredentials(true);
    }
}
```

## Acceptance Criteria

- [ ] CORS configuration class created
- [ ] Configuration allows requests from React dev server (http://localhost:3000)
- [ ] All required HTTP methods allowed (GET, POST, PUT, PATCH, DELETE)
- [ ] Preflight requests (OPTIONS) handled correctly
- [ ] Configuration is environment-aware (dev vs production)
- [ ] Frontend can successfully make API calls without CORS errors
- [ ] CORS headers present in response
- [ ] Configuration documented

## Testing Scenarios

### Test 1: Preflight Request
```
OPTIONS /api/tasks
Origin: http://localhost:3000
Expected: 
  Status: 200 OK
  Headers include:
    Access-Control-Allow-Origin: http://localhost:3000
    Access-Control-Allow-Methods: GET, POST, PUT, PATCH, DELETE, OPTIONS
```

### Test 2: Actual Request with CORS
```
GET /api/tasks
Origin: http://localhost:3000
Expected:
  Status: 200 OK
  Header: Access-Control-Allow-Origin: http://localhost:3000
```

### Test 3: Frontend Integration
- Start both backend and frontend servers
- Make API call from React app
- Verify no CORS errors in browser console
- Verify request completes successfully

### Test 4: Disallowed Origin
```
GET /api/tasks
Origin: http://malicious-site.com
Expected: CORS error, no Access-Control-Allow-Origin header
```

## Definition of Done

- [ ] All acceptance criteria met
- [ ] CORS configuration implemented
- [ ] Configuration tested with actual frontend requests
- [ ] No CORS errors in browser console
- [ ] Preflight requests work correctly
- [ ] Configuration is environment-aware
- [ ] Documentation updated with CORS setup
- [ ] Changes committed to version control

## Common CORS Issues and Solutions

### Issue 1: CORS Error Despite Configuration
**Solution**: Ensure configuration is loaded before controllers. Use @Configuration and implement WebMvcConfigurer.

### Issue 2: Preflight Requests Failing
**Solution**: Make sure OPTIONS method is allowed and server responds to preflight requests.

### Issue 3: Credentials Not Sent
**Solution**: Set `allowCredentials(true)` and ensure frontend sends credentials.

### Issue 4: Multiple CORS Configurations Conflict
**Solution**: Use only one CORS configuration approach (either global config or @CrossOrigin, not both).

## Production Considerations

### Security Best Practices
1. **Restrict Origins**: Don't use "*" wildcard in production
2. **Environment Variables**: Use environment-specific allowed origins
3. **HTTPS Only**: In production, only allow HTTPS origins
4. **Minimal Methods**: Only allow necessary HTTP methods
5. **Audit Logs**: Log CORS-related requests for security monitoring

### Production Configuration Example
```properties
# application-prod.properties
cors.allowed.origins=https://yourdomain.com,https://www.yourdomain.com
```

## Notes

- React dev server runs on port 3000 by default
- Backend runs on port 8080 by default
- In production, frontend and backend may be served from same origin
- Consider using a reverse proxy (nginx) to avoid CORS issues in production
- Never use `allowedOrigins("*")` with `allowCredentials(true)` - it's a security risk

## Related Files

- `src/main/java/.../config/CorsConfig.java` - CORS configuration
- `src/main/resources/application.properties` - Environment configuration
- `src/main/resources/application-prod.properties` - Production configuration

## Testing with cURL

Test CORS preflight:
```bash
curl -X OPTIONS http://localhost:8080/api/tasks \
  -H "Origin: http://localhost:3000" \
  -H "Access-Control-Request-Method: POST" \
  -v
```

Test actual request with CORS:
```bash
curl -X GET http://localhost:8080/api/tasks \
  -H "Origin: http://localhost:3000" \
  -v
```

## Browser Testing

Open browser DevTools console and run:
```javascript
fetch('http://localhost:8080/api/tasks', {
  method: 'GET',
  headers: {
    'Content-Type': 'application/json'
  }
})
.then(response => response.json())
.then(data => console.log(data))
.catch(error => console.error('CORS Error:', error));
```

## References

- [Spring CORS Documentation](https://docs.spring.io/spring-framework/docs/current/reference/html/web.html#mvc-cors)
- [MDN CORS Guide](https://developer.mozilla.org/en-US/docs/Web/HTTP/CORS)
- [CORS Best Practices](https://www.w3.org/TR/cors/)
