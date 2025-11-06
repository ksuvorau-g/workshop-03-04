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
