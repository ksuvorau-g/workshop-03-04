# FE-1: Set up React Project Structure

## Task Information
- **ID**: FE-1
- **Phase**: Phase 2 - Frontend Foundation
- **Estimated Effort**: 0.5 days (4 hours)
- **Assigned To**: Frontend Developer
- **Status**: Not Started
- **Dependencies**: None (can start in parallel with backend after project kickoff)
- **Priority**: P0 (Must Have)

## Objective
Set up the React project structure, verify dependencies, configure the development environment, and establish the base component architecture.

## Description
This task establishes the foundation for the frontend application. If a React project doesn't exist yet, we'll create one. We'll then verify all necessary dependencies, set up the project structure with appropriate folders for components, services, and styles, configure the API base URL, and ensure the development server starts successfully.

## Acceptance Criteria
- [ ] React project exists with proper structure
- [ ] `package.json` contains all required dependencies:
  - React (v18+)
  - React DOM
  - React Scripts or Vite
  - HTTP client (axios or fetch API wrapper)
  - CSS framework or styling solution (optional)
- [ ] Project structure includes:
  - `/src/components` - React components
  - `/src/services` - API service layer
  - `/src/styles` - CSS/styling files
  - `/src/utils` - Utility functions
- [ ] Environment configuration for API base URL
- [ ] Development server starts successfully
- [ ] Hot reload works for rapid development
- [ ] Basic App component renders without errors

## Technical Details

### Creating React Project (if needed)
```bash
# Using Create React App
npx create-react-app frontend
cd frontend

# OR using Vite (faster, modern alternative)
npm create vite@latest frontend -- --template react
cd frontend
npm install
```

### Required Dependencies (package.json)
```json
{
  "name": "todo-frontend",
  "version": "1.0.0",
  "dependencies": {
    "react": "^18.2.0",
    "react-dom": "^18.2.0",
    "axios": "^1.6.0"
  },
  "devDependencies": {
    "react-scripts": "5.0.1",
    "@testing-library/react": "^13.4.0",
    "@testing-library/jest-dom": "^5.17.0",
    "@testing-library/user-event": "^13.5.0"
  },
  "scripts": {
    "start": "react-scripts start",
    "build": "react-scripts build",
    "test": "react-scripts test",
    "eject": "react-scripts eject"
  }
}
```

### Recommended Project Structure
```
frontend/
├── public/
│   ├── index.html
│   └── favicon.ico
├── src/
│   ├── components/
│   │   ├── Task.jsx
│   │   ├── TaskList.jsx
│   │   ├── AddTask.jsx
│   │   └── FilterButtons.jsx
│   ├── services/
│   │   └── taskService.js
│   ├── styles/
│   │   ├── App.css
│   │   ├── Task.css
│   │   └── index.css
│   ├── utils/
│   │   └── constants.js
│   ├── App.jsx
│   ├── App.test.js
│   ├── index.js
│   └── index.css
├── .env
├── .env.example
├── .gitignore
├── package.json
└── README.md
```

### Environment Configuration (.env)
```env
REACT_APP_API_BASE_URL=http://localhost:8080/api
```

### Environment Configuration (.env.example)
```env
# Copy this file to .env and configure for your environment
REACT_APP_API_BASE_URL=http://localhost:8080/api
```

### Constants File (src/utils/constants.js)
```javascript
export const API_BASE_URL = process.env.REACT_APP_API_BASE_URL || 'http://localhost:8080/api';

export const FILTER_OPTIONS = {
  ALL: 'all',
  ACTIVE: 'active',
  COMPLETED: 'completed'
};

export const VALIDATION = {
  DESCRIPTION_MIN_LENGTH: 3,
  DESCRIPTION_MAX_LENGTH: 500
};
```

### Updated App Component (src/App.jsx)
```javascript
import React from 'react';
import './styles/App.css';

function App() {
  return (
    <div className="App">
      <header className="App-header">
        <h1>TODO Management</h1>
      </header>
      <main className="App-main">
        <p>TODO app is ready for development!</p>
      </main>
    </div>
  );
}

export default App;
```

### Basic Styling (src/styles/App.css)
```css
.App {
  max-width: 800px;
  margin: 0 auto;
  padding: 20px;
  font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', 'Roboto', sans-serif;
}

.App-header {
  text-align: center;
  margin-bottom: 30px;
}

.App-header h1 {
  color: #333;
  font-size: 2.5rem;
  margin: 0;
}

.App-main {
  background-color: #f9f9f9;
  border-radius: 8px;
  padding: 20px;
  min-height: 400px;
}
```

## Steps to Complete

1. **Verify/Create React Project**
   - Check if `frontend` directory exists
   - If not, create React project using Create React App or Vite
   - Navigate to frontend directory

2. **Install/Verify Dependencies**
   - Check `package.json` for required dependencies
   - Run `npm install` to install dependencies
   - Add axios if not present: `npm install axios`

3. **Create Directory Structure**
   - Create `src/components` directory
   - Create `src/services` directory
   - Create `src/styles` directory
   - Create `src/utils` directory

4. **Set Up Environment Configuration**
   - Create `.env` file with API base URL
   - Create `.env.example` as a template
   - Add `.env` to `.gitignore` if not already there

5. **Create Constants File**
   - Create `src/utils/constants.js`
   - Define API_BASE_URL, filter options, validation constants

6. **Update App Component**
   - Modify `src/App.jsx` with basic structure
   - Add proper styling

7. **Test Development Server**
   - Run `npm start`
   - Verify application opens in browser
   - Verify hot reload works (make a change and see it update)
   - Check console for errors

8. **Update .gitignore**
   - Ensure node_modules is ignored
   - Ensure .env is ignored
   - Ensure build artifacts are ignored

## Testing Requirements

### Manual Testing
- [ ] Run `npm install` - completes without errors
- [ ] Run `npm start` - development server starts
- [ ] Browser opens automatically to http://localhost:3000
- [ ] App displays "TODO Management" heading
- [ ] No console errors in browser developer tools
- [ ] Make a change to App.jsx - hot reload updates browser
- [ ] Stop server (Ctrl+C) - terminates cleanly

### Automated Testing
```javascript
// src/App.test.js
import { render, screen } from '@testing-library/react';
import App from './App';

test('renders TODO Management heading', () => {
  render(<App />);
  const headingElement = screen.getByText(/TODO Management/i);
  expect(headingElement).toBeInTheDocument();
});
```

Run test: `npm test`

## Definition of Done
- [ ] React project exists with proper structure
- [ ] All required dependencies installed
- [ ] Directory structure created (components, services, styles, utils)
- [ ] Environment configuration set up (.env, constants)
- [ ] App component updated with basic structure
- [ ] Development server starts without errors
- [ ] Hot reload verified working
- [ ] Basic test passes
- [ ] .gitignore properly configured
- [ ] README.md updated with frontend setup instructions
- [ ] Code committed to feature branch

## Common Issues and Solutions

### Issue: "npm start" fails with port 3000 already in use
**Solution**: Stop other processes using port 3000, or change port in package.json: `"start": "PORT=3001 react-scripts start"`

### Issue: CORS errors when calling backend API
**Solution**: Will be addressed in BE-6 (CORS configuration). For now, just set up the structure.

### Issue: Module not found errors
**Solution**: Run `npm install` to ensure all dependencies are installed

### Issue: Hot reload not working
**Solution**: Check if file watcher limit is exceeded (Linux), increase with: `echo fs.inotify.max_user_watches=524288 | sudo tee -a /etc/sysctl.conf`

### Issue: Environment variables not loading
**Solution**: Ensure variables start with `REACT_APP_` prefix and restart development server

## Notes / Additional Context

- This task sets up the foundation for all frontend development
- Follow React best practices: functional components, hooks
- Use modern JavaScript (ES6+): arrow functions, destructuring, async/await
- Keep components small and focused on single responsibility
- Separate concerns: components for UI, services for API calls, utils for helpers
- Use meaningful names for components and files
- Follow consistent naming conventions (PascalCase for components, camelCase for functions)
- Consider using a linter (ESLint) and formatter (Prettier) for code consistency

### Development Tips
- Use React Developer Tools browser extension for debugging
- Use browser developer tools Network tab to inspect API calls
- Console.log is your friend for debugging
- Keep components pure when possible (no side effects)
- Use React hooks properly (useEffect, useState, etc.)

## Related Files

### Files to Create/Modify
- `/frontend/package.json` - Dependencies and scripts
- `/frontend/src/App.jsx` - Main app component
- `/frontend/src/styles/App.css` - App styling
- `/frontend/src/utils/constants.js` - Constants and configuration
- `/frontend/.env` - Environment variables (not committed)
- `/frontend/.env.example` - Environment template (committed)
- `/frontend/.gitignore` - Git ignore rules

### Reference Files
- [Requirements Analysis](../docs/requirements/ba-analyze-raw-requirement.md) - Frontend requirements
- [Implementation Plan](../docs/implementation-plan.md) - Phase 2 overview
- [React Documentation](https://react.dev/) - Official React docs

## Next Steps
After completing this task, proceed to:
- **FE-2**: Create API service layer (can start immediately)
- **FE-3**: Create Task component (requires FE-2)
- **BE-1 to BE-5**: Backend tasks (can develop in parallel)
