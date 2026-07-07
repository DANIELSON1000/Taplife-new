# Smart Card Attendance Management System

**IoT-Based Attendance Management System** — University of Kigali thesis project by MANZI Maurice (June 2026).

Physical RFID smart cards + ESP32 readers record class attendance through a web dashboard.

## Stack

| Layer | Technology |
|-------|------------|
| Frontend | React + Tailwind CSS (Vite) |
| Backend | Node.js + Express |
| Database | PostgreSQL |
| IoT | ESP32 + RC522 RFID (MIFARE cards) |

## Quick start

### 1. Database

Create PostgreSQL database `taplife_db` (password in `.env`):

```sql
CREATE DATABASE taplife_db;
```

Tables are created automatically when the backend starts.

### 2. Backend

```bash
cd backend
npm install
npm run dev
```

API: `http://localhost:5000`

**Default admin** (seeded if none exists): `admin@uok.ac.rw` / `admin123`

**Default IoT device key:** `attendance-device-key-2026`

### 3. Frontend

```bash
cd frontend
npm install
npm run dev
```

App: `http://localhost:3000`

### 4. IoT firmware (NodeMCU ESP8266)

1. Open `iot-firmware/attendance_reader/attendance_reader.ino` in Arduino IDE
2. Install libraries: **Adafruit PN532**, **LiquidCrystal I2C**, **ArduinoJson**
3. Set `WIFI_SSID` and `WIFI_PASSWORD` (any network with internet)
4. For **different networks** (campus reader + home dashboard): set `USE_CLOUD_API = true` and `CLOUD_API_HOST` to your deployed API hostname (see below)
5. For **local testing** on same Wi-Fi: set `USE_CLOUD_API = false` and `LOCAL_API_HOST` to your PC IP
6. Flash to NodeMCU

## Cross-network setup (IoT + dashboard on different Wi-Fi)

Database is already on Neon (cloud). You need a **public HTTPS URL** for the backend so the IoT reader and dashboard can talk to the same API from any network:

```
IoT reader (campus Wi-Fi)  ──HTTPS──►  Public API  ◄──HTTPS──  Dashboard (any network)
                                              │
                                              ▼
                                        Neon PostgreSQL
```

### Option A — Northflank (free cloud, recommended)

**100% free** Developer Sandbox — always-on, no sleep, no monthly fee.

#### Step 1 — Put code on GitHub

1. Install Git: [git-scm.com/download/win](https://git-scm.com/download/win)
2. Create a new repo on [github.com/new](https://github.com/new) (name: `taplife-system`)
3. In PowerShell:

```powershell
cd D:\taplife-system\taplife-system
git init
git add .
git commit -m "TapLife attendance system"
git branch -M main
git remote add origin https://github.com/YOUR_USERNAME/taplife-system.git
git push -u origin main
```

#### Step 2 — Create Northflank project

1. Go to [northflank.com](https://northflank.com) → sign up
2. Choose **Developer Sandbox** (free)
3. Click **Create project** → name it `taplife`

#### Step 3 — Add backend service

1. In the project → **Add new** → **Service**
2. **Deployment** → connect **GitHub** → select `taplife-system` repo, branch `main`
3. **Build**:
   - Type: **Dockerfile**
   - Build context: `/backend`
   - Dockerfile path: `/backend/Dockerfile`
4. **Networking** → **Add port**:
   - Port: `5000`
   - Protocol: **HTTP**
   - **Publicly expose** ✓
5. **Environment variables** (copy from your `backend/.env`):

| Variable | Value |
|----------|-------|
| `DATABASE_URL` | Your Neon connection string |
| `JWT_SECRET` | Your secret from `.env` |
| `NODE_ENV` | `production` |

6. Click **Create & deploy**

#### Step 4 — Get your public URL

After build finishes (2–5 min), open **Ports & DNS** → copy the URL, e.g.:

`https://taplife-api-xxxxx.northflank.app`

Test in browser: `https://YOUR-URL/api/health` → should show `"database": "connected"`

#### Step 5 — Connect frontend & IoT

**Frontend** — edit `frontend/.env`:

```env
VITE_API_URL=https://YOUR-URL.northflank.app/api
```

Restart: `cd frontend` → `npm run dev`

**IoT firmware** — edit `attendance_reader.ino`:

```cpp
const bool USE_CLOUD_API = true;
const char* CLOUD_API_HOST = "YOUR-URL.northflank.app";  // no https://
```

Re-flash NodeMCU, set campus Wi-Fi in `WIFI_SSID` / `WIFI_PASSWORD`.

> Card may be asked for verification only — you are **not charged** on the Sandbox plan.

### Option B — Cloudflare Tunnel (free, no signup for quick test)

Expose your **local** backend to the internet — no hosting account needed.

1. Install: `winget install Cloudflare.cloudflared`
2. Start backend: `cd backend` → `npm run dev`
3. In another terminal: `.\scripts\start-cloudflare-tunnel.ps1`
4. Copy the `https://....trycloudflare.com` URL shown

> Your PC must stay on while the IoT device is in use. URL changes each time you restart the tunnel (fine for demos).

### Point frontend to public API

Edit `frontend/.env`:

```env
VITE_API_URL=https://YOUR-PUBLIC-HOST/api
```

Examples:
- Northflank: `https://taplife-api-abc123.northflank.app/api`
- Cloudflare: `https://random-name.trycloudflare.com/api`

Restart frontend: `npm run dev`

### Point IoT firmware to public API

In `attendance_reader.ino`:

```cpp
const bool USE_CLOUD_API = true;
const char* CLOUD_API_HOST = "taplife-api-abc123.northflank.app";  // hostname only
```

Re-flash the NodeMCU.

## Workflow

1. **Admin** registers physical cards and links them to students (`/cards`)
2. **Lecturer** creates an attendance session (`/attendance`)
3. **Lecturer** activates the session on an IoT reader (`/devices`)
4. **Student** taps RFID card on ESP32 — reader POSTs to `/api/iot/attendance`
5. **Lecturer/Admin** views reports and absenteeism alerts (`/reports`)

## Test IoT endpoint (curl)

```bash
curl -X POST http://localhost:5000/api/iot/attendance \
  -H "Content-Type: application/json" \
  -H "X-Device-Key: attendance-device-key-2026" \
  -d "{\"card_uid\":\"A1B2C3D4\"}"
```

## Project structure

```
taplife-system/
├── backend/          # Express API
├── frontend/         # React dashboard
├── iot-firmware/     # ESP32 Arduino sketch
└── README.md
```

## Scope

This system covers **attendance only** (thesis §1.7.6). Cafeteria, transport, wallet, and access control are out of scope.
