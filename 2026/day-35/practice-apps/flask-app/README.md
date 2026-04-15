# Flask Task API

A simple RESTful Task Manager API built with Python and Flask. Designed for Docker practice.

## Tech Stack

- **Language:** Python 3.11+
- **Framework:** Flask 3.0
- **Server:** Gunicorn (production)

## Project Structure

```
flask-app/
├── app.py            # Main application & routes
├── requirements.txt  # Python dependencies
└── README.md
```

## API Endpoints

| Method | Endpoint         | Description        |
|--------|------------------|--------------------|
| GET    | `/`              | Welcome message    |
| GET    | `/health`        | Health check       |
| GET    | `/tasks`         | List all tasks     |
| GET    | `/tasks/<id>`    | Get a single task  |
| POST   | `/tasks`         | Create a new task  |
| PUT    | `/tasks/<id>`    | Update a task      |
| DELETE | `/tasks/<id>`    | Delete a task      |

## Running Locally (without Docker)

```bash
# Create virtual environment
python -m venv venv
source venv/bin/activate  # Windows: venv\Scripts\activate

# Install dependencies
pip install -r requirements.txt

# Run development server
python app.py
```

App runs at: `http://localhost:5000`

## Example Requests

```bash
# Get all tasks
curl http://localhost:5000/tasks

# Create a task
curl -X POST http://localhost:5000/tasks \
  -H "Content-Type: application/json" \
  -d '{"title": "Dockerize this app"}'

# Update a task
curl -X PUT http://localhost:5000/tasks/1 \
  -H "Content-Type: application/json" \
  -d '{"done": true}'

# Delete a task
curl -X DELETE http://localhost:5000/tasks/1
```

## Docker Practice Goals

- Build a Python image using `python:3.11-slim`
- Install dependencies from `requirements.txt`
- Expose port `5000`
- Run with `gunicorn app:app --bind 0.0.0.0:5000`
- Practice environment variables, volume mounts, and port mapping
