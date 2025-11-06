# FE-2: Create API Service Layer

## Task Information
- **Task ID**: FE-2
- **Phase**: Phase 2 - Frontend Foundation  
- **Effort Estimate**: 0.5 days
- **Priority**: High
- **Dependencies**: FE-1 (React project setup), BE-5 (REST API available)

## Description

Create a service layer that handles all HTTP communication with the backend API. This service will abstract API calls and provide clean methods for components to create, read, update, and delete tasks.

## Objectives

1. Create taskService.js with API methods
2. Configure HTTP client (axios or fetch)
3. Handle API errors gracefully
4. Add request/response interceptors if needed
5. Test all API methods

## Technical Details

### Service Implementation (Using Fetch API)
```javascript
const API_BASE_URL = process.env.REACT_APP_API_BASE_URL || 'http://localhost:8080/api';

const taskService = {
  // Get all tasks
  async getAllTasks(completed = null) {
    const url = completed !== null 
      ? `${API_BASE_URL}/tasks?completed=${completed}`
      : `${API_BASE_URL}/tasks`;
    
    const response = await fetch(url);
    if (!response.ok) {
      throw new Error('Failed to fetch tasks');
    }
    return response.json();
  },

  // Get task by ID
  async getTaskById(id) {
    const response = await fetch(`${API_BASE_URL}/tasks/${id}`);
    if (!response.ok) {
      throw new Error(`Task not found: ${id}`);
    }
    return response.json();
  },

  // Create new task
  async createTask(description) {
    const response = await fetch(`${API_BASE_URL}/tasks`, {
      method: 'POST',
      headers: {
        'Content-Type': 'application/json',
      },
      body: JSON.stringify({ description }),
    });
    
    if (!response.ok) {
      const error = await response.json();
      throw new Error(error.message || 'Failed to create task');
    }
    return response.json();
  },

  // Update task
  async updateTask(id, description) {
    const response = await fetch(`${API_BASE_URL}/tasks/${id}`, {
      method: 'PUT',
      headers: {
        'Content-Type': 'application/json',
      },
      body: JSON.stringify({ description }),
    });
    
    if (!response.ok) {
      throw new Error('Failed to update task');
    }
    return response.json();
  },

  // Toggle task completion
  async toggleTask(id) {
    const response = await fetch(`${API_BASE_URL}/tasks/${id}/toggle`, {
      method: 'PATCH',
    });
    
    if (!response.ok) {
      throw new Error('Failed to toggle task');
    }
    return response.json();
  },

  // Delete task
  async deleteTask(id) {
    const response = await fetch(`${API_BASE_URL}/tasks/${id}`, {
      method: 'DELETE',
    });
    
    if (!response.ok) {
      throw new Error('Failed to delete task');
    }
    return true;
  },
};

export default taskService;
```

## Acceptance Criteria

- [ ] taskService.js created in src/services/
- [ ] All CRUD methods implemented
- [ ] Methods use async/await for cleaner code
- [ ] Error handling for failed requests
- [ ] Proper HTTP methods used (GET, POST, PUT, PATCH, DELETE)
- [ ] Content-Type headers set correctly
- [ ] Service can be imported and used in components
- [ ] All methods tested with mock or actual backend

## Testing Steps

1. Import service in a component or test file
2. Test getAllTasks() with backend running
3. Test createTask() with valid data
4. Test error scenarios (backend down, invalid data)
5. Verify proper error messages returned

## Definition of Done

- [ ] All acceptance criteria met
- [ ] Service file created with all methods
- [ ] Error handling implemented
- [ ] Methods tested with backend API
- [ ] Code follows ES6+ best practices
- [ ] Changes committed to version control

## Related Files

- `frontend/src/services/taskService.js` - API service

## References

- [Fetch API Documentation](https://developer.mozilla.org/en-US/docs/Web/API/Fetch_API)
- [Async/Await Guide](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Statements/async_function)
