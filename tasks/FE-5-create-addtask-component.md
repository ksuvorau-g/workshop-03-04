# FE-5: Create AddTask Component

## Task Information
- **Task ID**: FE-5
- **Phase**: Phase 2 - Frontend Foundation
- **Effort Estimate**: 1 day
- **Priority**: High
- **Dependencies**: FE-2 (API service created)

## Description
Create the AddTask component that provides an input form for users to create new tasks. The component includes client-side validation, character counter, and success/error feedback.

## Objectives
1. Create AddTask component with input form
2. Add client-side validation (3-500 characters)
3. Implement character counter
4. Handle form submission
5. Show success/error messages
6. Clear input after successful creation

## Acceptance Criteria
- [ ] AddTask component created with form and input field
- [ ] Input validation enforces 3-500 character limit
- [ ] Character counter shows current/max characters
- [ ] Submit button disabled when input invalid
- [ ] Success message shown after task created
- [ ] Error message shown if creation fails
- [ ] Input cleared after successful creation
- [ ] Button disabled during API call

## Definition of Done
- [ ] Component implemented with all acceptance criteria
- [ ] Validation working correctly
- [ ] User feedback messages implemented
- [ ] Changes committed to version control

## Related Files
- `frontend/src/components/AddTask.js`
- `frontend/src/components/AddTask.css`
