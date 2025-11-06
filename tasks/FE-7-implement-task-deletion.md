# FE-7: Implement Task Deletion

## Task Information
- **Task ID**: FE-7
- **Phase**: Phase 2 - Frontend Foundation
- **Effort Estimate**: 1 day
- **Priority**: Medium
- **Dependencies**: FE-3, FE-4 (Task and TaskList components)

## Description
Implement task deletion with confirmation dialog to prevent accidental deletions. When a user clicks delete, show a confirmation dialog, and if confirmed, delete the task via API and update the UI.

## Objectives
1. Add confirmation dialog before deletion
2. Call API to delete task when confirmed
3. Remove task from UI after successful deletion
4. Handle deletion errors
5. Show feedback messages

## Acceptance Criteria
- [ ] Confirmation dialog appears when delete button clicked
- [ ] Dialog has "Confirm" and "Cancel" buttons
- [ ] Clicking Cancel closes dialog without deletion
- [ ] Clicking Confirm calls API to delete task
- [ ] Task removed from UI after successful deletion
- [ ] Error message shown if deletion fails
- [ ] Dialog accessible with keyboard navigation

## Definition of Done
- [ ] Deletion functionality implemented
- [ ] Confirmation dialog working
- [ ] API integration complete
- [ ] Changes committed to version control

## Related Files
- `frontend/src/components/Task.js` or `TaskList.js`
- `frontend/src/components/ConfirmDialog.js` (optional separate component)
