# FE-4: Create TaskList Component

## Task Information
- **Task ID**: FE-4
- **Phase**: Phase 2 - Frontend Foundation
- **Effort Estimate**: 1 day
- **Priority**: High
- **Dependencies**: FE-3 (Task component created)

## Description
Create the TaskList component that fetches and displays all tasks. This component manages the task list state, handles loading and error states, and renders individual Task components.

## Objectives
1. Create TaskList functional component with state management
2. Fetch tasks from API on component mount
3. Handle loading, error, and empty states
4. Render list of Task components
5. Pass callback functions to Task components
6. Implement real-time updates after operations

## Acceptance Criteria
- [ ] TaskList component created with useState and useEffect hooks
- [ ] Fetches tasks on component mount
- [ ] Displays loading indicator while fetching
- [ ] Shows error message if API call fails
- [ ] Displays empty state message when no tasks
- [ ] Renders Task components for each task
- [ ] Passes onToggle, onEdit, onDelete callbacks to Task components
- [ ] Refreshes task list after operations

## Definition of Done
- [ ] Component implemented with all acceptance criteria
- [ ] Loading and error states handled
- [ ] Task list updates correctly after operations
- [ ] Changes committed to version control

## Related Files
- `frontend/src/components/TaskList.js`
- `frontend/src/components/TaskList.css`
