# TEST-1: Backend Unit Tests

## Task Information
- **Task ID**: TEST-1
- **Phase**: Phase 3 - Testing & QA
- **Effort Estimate**: 1 day
- **Priority**: High
- **Dependencies**: BE-7 (Backend complete)

## Description
Write comprehensive unit tests for the backend service layer and entity classes. Use JUnit 5 and Mockito to test business logic in isolation.

## Objectives
1. Test Task entity constraints
2. Test TaskService methods (all branches)
3. Test validation logic
4. Mock repository dependencies
5. Achieve >80% code coverage

## Acceptance Criteria
- [ ] Unit tests for Task entity validation
- [ ] Unit tests for all TaskService methods
- [ ] Edge cases covered (null inputs, validation failures)
- [ ] Repository mocked with Mockito
- [ ] All tests pass
- [ ] Code coverage >80%

## Definition of Done
- [ ] All tests written and passing
- [ ] Coverage target met
- [ ] Changes committed to version control

## Related Files
- `src/test/java/.../service/TaskServiceTest.java`
- `src/test/java/.../entity/TaskTest.java`
