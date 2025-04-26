# Real-Time Guestbook Application

This is a full-stack real-time guestbook application built with:
- Ruby on Rails (API backend with ActionCable for real-time updates)
- Vue 3 (Frontend using Composition API and Vite)
- PostgreSQL (Database)
- Docker Compose (for backend services)

## How to Run (Local Development)

No secrets are needed for local development.

### Start the Entire Project

A convenience script `start_project.sh` is provided to automate the setup and startup process.

```bash
./start_project.sh
```

This script will:
- Install frontend dependencies if missing
- Start the Vue frontend dev server (`localhost:5173`)
- Start Rails API backend and PostgreSQL via Docker Compose (`localhost:3000`)

### Project Structure

```
real_time_guest_book/
├── guestbook_api/          # Rails API backend with Dockerfile and docker-compose.yml
├── guestbook-frontend/     # Vue 3 frontend
├── start_project.sh        # Startup script for entire project
```

## Admin Login Credentials

Default seeded admin user:

- Email: admin@example.com
- Password: password123

## Services

- Rails API: http://localhost:3000
- Vue Frontend: http://localhost:5173

## Important Notes

- Frontend connects to the backend via an environment variable `VITE_API_BASE_URL`.
- Real-time updates are handled by ActionCable WebSockets.
- Database is managed inside Docker Compose (PostgreSQL 14).
- WebSocket connection URL is dynamically generated from the API base URL.

---

Thank you for checking out the project. Simply run the provided script and you are good to go!

