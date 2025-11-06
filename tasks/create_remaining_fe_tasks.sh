#!/bin/bash

# Create FE-2
cat > FE-2-create-api-service.md << 'EOF'
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
EOF

# Create FE-3
cat > FE-3-create-task-component.md << 'EOF'
# FE-3: Create Task Component

## Task Information
- **Task ID**: FE-3
- **Phase**: Phase 2 - Frontend Foundation
- **Effort Estimate**: 1 day
- **Priority**: High
- **Dependencies**: FE-2 (API service created)

## Description

Create the Task component that displays a single TODO task. The component will show the task description, completion status with a checkbox, and action buttons for editing and deleting.

## Objectives

1. Create Task functional component
2. Display task description and status
3. Add checkbox for completion toggle
4. Add edit and delete buttons
5. Apply styling for completed vs pending tasks
6. Handle click events

## Technical Details

### Component Structure
```javascript
import React from 'react';
import './Task.css';

const Task = ({ task, onToggle, onEdit, onDelete }) => {
  const handleToggle = () => {
    onToggle(task.id);
  };

  const handleEdit = () => {
    onEdit(task);
  };

  const handleDelete = () => {
    onDelete(task.id);
  };

  return (
    <div className={`task ${task.completed ? 'completed' : ''}`}>
      <input
        type="checkbox"
        checked={task.completed}
        onChange={handleToggle}
        aria-label="Toggle task completion"
      />
      <span className="task-description">{task.description}</span>
      <div className="task-actions">
        <button onClick={handleEdit} className="btn-edit" aria-label="Edit task">
          ✏️ Edit
        </button>
        <button onClick={handleDelete} className="btn-delete" aria-label="Delete task">
          🗑️ Delete
        </button>
      </div>
    </div>
  );
};

export default Task;
```

### Styling (Task.css)
```css
.task {
  display: flex;
  align-items: center;
  padding: 12px 16px;
  margin-bottom: 8px;
  background: white;
  border: 1px solid #e0e0e0;
  border-radius: 8px;
  transition: all 0.2s ease;
}

.task:hover {
  box-shadow: 0 2px 8px rgba(0,0,0,0.1);
}

.task.completed .task-description {
  text-decoration: line-through;
  color: #999;
}

.task input[type="checkbox"] {
  margin-right: 12px;
  width: 20px;
  height: 20px;
  cursor: pointer;
}

.task-description {
  flex: 1;
  font-size: 16px;
}

.task-actions {
  display: flex;
  gap: 8px;
}

.task-actions button {
  padding: 6px 12px;
  border: none;
  border-radius: 4px;
  cursor: pointer;
  font-size: 14px;
  transition: background-color 0.2s;
}

.btn-edit {
  background-color: #4CAF50;
  color: white;
}

.btn-edit:hover {
  background-color: #45a049;
}

.btn-delete {
  background-color: #f44336;
  color: white;
}

.btn-delete:hover {
  background-color: #da190b;
}
```

## Acceptance Criteria

- [ ] Task component created as functional component
- [ ] Component accepts task object and callback props
- [ ] Checkbox displays and reflects task completion status
- [ ] Task description displayed
- [ ] Edit and delete buttons present
- [ ] Completed tasks visually distinguished (strikethrough)
- [ ] Hover effects implemented
- [ ] Component is responsive
- [ ] Accessibility attributes added (ARIA labels)

## Definition of Done

- [ ] All acceptance criteria met
- [ ] Component file created
- [ ] Styling implemented
- [ ] Props properly destructured
- [ ] Event handlers implemented
- [ ] Component tested with sample data
- [ ] Changes committed to version control

## Related Files

- `frontend/src/components/Task.js`
- `frontend/src/components/Task.css`

## References

- [React Components](https://react.dev/learn/your-first-component)
- [Handling Events](https://react.dev/learn/responding-to-events)
EOF

echo "Created frontend task files"
