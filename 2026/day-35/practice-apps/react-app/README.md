# React Notes App

A simple sticky-note style Notes application built with React 18. Designed for Docker practice.

## Tech Stack

- **Language:** JavaScript (ES2022)
- **Framework:** React 18
- **Build Tool:** Create React App
- **Production Server:** Nginx (via nginx.conf)

## Project Structure

```
react-app/
├── public/
│   └── index.html        # HTML shell
├── src/
│   ├── index.js          # React entry point
│   └── App.js            # Main Notes component
├── package.json          # npm dependencies & scripts
├── nginx.conf            # Nginx config for serving built app
├── .env                  # Environment variables
└── README.md
```

## Features

- Create, view, and delete notes
- Color-coded notes
- Search/filter notes by title or content
- Fully client-side (no backend required)

## Running Locally (without Docker)

**Prerequisites:** Node.js 18+, npm 9+

```bash
# Install dependencies
npm install

# Start development server
npm start
```

App runs at: `http://localhost:3000`

## Building for Production

```bash
npm run build
```

This creates an optimized production build in the `build/` folder. Serve it with any static file server.

## Docker Practice Goals

- Use multi-stage build: `node:18-alpine` for build stage, `nginx:alpine` for runtime
- Run `npm run build` in the build stage to generate the `build/` folder
- Copy the `build/` output to `/usr/share/nginx/html` in the nginx image
- Use the provided `nginx.conf` for proper SPA routing (`try_files`)
- Expose port `80`
- This shows how to drastically reduce image size by not shipping Node.js to production

## Environment Variables

| Variable           | Default    | Description          |
|--------------------|------------|----------------------|
| `REACT_APP_NAME`   | Notes App  | Application name     |
| `REACT_APP_VERSION`| 1.0.0      | App version          |
| `PORT`             | 3000       | Dev server port      |
