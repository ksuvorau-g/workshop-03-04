# FE-1: Set up React Project Structure

## Task Information
- **Task ID**: FE-1
- **Phase**: Phase 2 - Frontend Foundation
- **Effort Estimate**: 0.5 days
- **Priority**: High (Foundational)
- **Dependencies**: None (can start in parallel with backend)

## Description

Verify and set up the React project structure to ensure it's ready for development. This includes checking package dependencies, organizing the project structure with proper directories for components, services, and styles, and ensuring the development server runs successfully.

## Objectives

1. Verify package.json has necessary dependencies
2. Create organized folder structure
3. Configure API base URL
4. Set up environment variables
5. Verify development server starts
6. Set up basic routing (if needed)

## Technical Details

### Required Dependencies
```json
{
  "dependencies": {
    "react": "^18.x",
    "react-dom": "^18.x",
    "axios": "^1.x" // or use fetch API
  },
  "devDependencies": {
    "@testing-library/react": "^14.x",
    "@testing-library/jest-dom": "^6.x",
    "@testing-library/user-event": "^14.x"
  }
}
```

### Folder Structure
```
frontend/
├── public/
│   └── index.html
├── src/
│   ├── components/
│   │   ├── Task.js
│   │   ├── TaskList.js
│   │   └── AddTask.js
│   ├── services/
│   │   └── taskService.js
│   ├── styles/
│   │   ├── App.css
│   │   └── index.css
│   ├── App.js
│   ├── index.js
│   └── setupTests.js
├── .env
├── .env.example
└── package.json
```

### Environment Configuration
`.env.example`:
```
REACT_APP_API_BASE_URL=http://localhost:8080/api
```

`.env`:
```
REACT_APP_API_BASE_URL=http://localhost:8080/api
```

### Basic App.js Structure
```javascript
import React from 'react';
import './styles/App.css';

function App() {
  return (
    <div className="App">
      <header>
        <h1>TODO App</h1>
      </header>
      <main>
        {/* Components will go here */}
      </main>
    </div>
  );
}

export default App;
```

## Acceptance Criteria

- [ ] package.json exists with all required dependencies
- [ ] Folder structure created (components/, services/, styles/)
- [ ] Environment variables configured (.env file)
- [ ] API base URL configured and accessible via process.env
- [ ] Development server starts with `npm start`
- [ ] Application loads in browser at http://localhost:3000
- [ ] No console errors on initial load
- [ ] Basic App component renders

## Testing Steps

1. Run `npm install` - should complete without errors
2. Run `npm start` - dev server should start
3. Open http://localhost:3000 in browser
4. Check browser console for errors
5. Verify hot reload works by making a small change
6. Run `npm test` - test suite should initialize

## Definition of Done

- [ ] All acceptance criteria met
- [ ] Dependencies installed successfully
- [ ] Folder structure created
- [ ] Environment variables configured
- [ ] Dev server runs without errors
- [ ] Application renders in browser
- [ ] Project structure documented
- [ ] Changes committed to version control

## Project Setup Commands

### Install Dependencies
```bash
cd frontend
npm install
```

### Start Development Server
```bash
npm start
```

### Run Tests
```bash
npm test
```

### Build for Production
```bash
npm run build
```

## Common Issues and Solutions

### Issue 1: Port 3000 Already in Use
**Solution**: 
```bash
# Kill process on port 3000
npx kill-port 3000
# Or use different port
PORT=3001 npm start
```

### Issue 2: ESLINT Warnings
**Solution**: Configure .eslintrc or disable specific rules in package.json

### Issue 3: Module Not Found Errors
**Solution**: 
```bash
rm -rf node_modules package-lock.json
npm install
```

## Notes

- React 18 uses automatic JSX transform (no need to import React in every file)
- Use functional components and hooks (modern React patterns)
- Keep components small and focused
- Use meaningful file and component names
- Follow React naming conventions (PascalCase for components)

## Related Files

- `frontend/package.json` - Dependencies and scripts
- `frontend/src/App.js` - Main application component
- `frontend/src/index.js` - Entry point
- `frontend/.env` - Environment variables
- `frontend/.gitignore` - Should exclude node_modules, .env, build/

## Environment Variables Access

```javascript
// Accessing API base URL in components
const API_BASE_URL = process.env.REACT_APP_API_BASE_URL;
```

Note: All custom env vars must start with `REACT_APP_`

## References

- [Create React App Documentation](https://create-react-app.dev/)
- [React Documentation](https://react.dev/)
- [Environment Variables in CRA](https://create-react-app.dev/docs/adding-custom-environment-variables/)
