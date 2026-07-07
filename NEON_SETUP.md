# Create your FREE online PostgreSQL (Neon) — 5 minutes

TapLife uses **PostgreSQL in the cloud** so you do not need to install PostgreSQL on your PC.

## Step 1 — Create Neon account

1. Open **[https://neon.tech](https://neon.tech)**
2. Click **Sign up** (use Google or GitHub — free)
3. Click **New Project**
   - Name: `taplife`
   - Region: pick closest to you (e.g. AWS Europe)
4. Click **Create project**

## Step 2 — Copy connection string

1. On the Neon dashboard, open **Connection details**
2. Select **Connection string**
3. Copy the URL that looks like:

```
postgresql://neondb_owner:AbCdEf123@ep-cool-name-12345678.us-east-2.aws.neon.tech/neondb?sslmode=require
```

## Step 3 — Paste into your project

Edit `backend/.env` and add (replace with your real URL):

```env
DATABASE_URL=postgresql://neondb_owner:YOUR_PASSWORD@ep-xxxx.neon.tech/neondb?sslmode=require
```

You can comment out or remove the local `DB_HOST` lines — `DATABASE_URL` takes priority.

## Step 4 — Create all tables (automatic)

```bash
cd backend
npm run db:init
```

You should see:

```
✓ Connected to database: neondb
✅ Database schema created
👤 Admin login: admin@uok.ac.rw / admin123
📡 IoT device key: attendance-device-key-2026
✅ Online database is ready!
```

## Step 5 — Start the app

```bash
npm run dev
```

Frontend (`frontend/.env`):

```env
VITE_API_URL=http://localhost:5000/api
```

---

## Test connection anytime

```bash
cd backend
npm run db:test
```

---

## Default accounts (created in cloud DB)

| Role | Email | Password |
|------|-------|----------|
| Admin | `admin@uok.ac.rw` | `admin123` |

Students do **not** log in — they use NFC cards at `/enroll`.

---

## Security

- Never commit `.env` to Git (password is inside `DATABASE_URL`)
- Change admin password after first login in production

---

## Alternative: Supabase

1. [https://supabase.com](https://supabase.com) → New project
2. Settings → Database → **Connection string** (URI mode)
3. Same `DATABASE_URL` in `backend/.env`
4. Run `npm run db:init`
