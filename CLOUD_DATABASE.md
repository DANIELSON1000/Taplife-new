# Online Database Setup (Recommended: Neon)

For your thesis and real deployments, use a **hosted PostgreSQL** database instead of running PostgreSQL only on your PC.

## Recommended: [Neon](https://neon.tech)

| Why Neon | Details |
|----------|---------|
| Free tier | Enough for development and thesis demo |
| PostgreSQL | Same as your app — no code changes |
| Connection string | One `DATABASE_URL` in `.env` |
| Always online | Backend can run on Render/Railway while DB stays in the cloud |

**Alternatives:** [Supabase](https://supabase.com) (PostgreSQL + extras), [Railway](https://railway.app), [ElephantSQL](https://www.elephantsql.com) (smaller free tier).

---

## Step 1 — Create Neon database

1. Go to [https://neon.tech](https://neon.tech) and sign up (GitHub/Google).
2. Click **New Project** → name it `taplife`.
3. Copy the **connection string** (looks like):
   ```
   postgresql://user:password@ep-xxxx.region.aws.neon.tech/neondb?sslmode=require
   ```

## Step 2 — Configure backend

Edit `backend/.env`:

```env
PORT=5000

# Cloud database (Neon) — use this instead of local DB_HOST/DB_PORT when online
DATABASE_URL=postgresql://user:password@ep-xxxx.region.aws.neon.tech/neondb?sslmode=require

JWT_SECRET=your_long_random_secret_here
JWT_EXPIRE=7d
NODE_ENV=production
```

**Local PostgreSQL** still works if you leave `DATABASE_URL` empty and keep:

```env
DB_HOST=localhost
DB_PORT=5432
DB_NAME=taplife_db
DB_USER=postgres
DB_PASSWORD=your_password
```

## Step 3 — Start backend (creates tables automatically)

```bash
cd backend
npm install
npm run dev
```

On first start, the app runs `database.sql` and migrations on the cloud database.

## Step 4 — Put backend online (free options)

Host the API so the NodeMCU can reach it from campus Wi-Fi while you use the dashboard from home.

### Option A — Northflank (free cloud, always-on)

1. [Northflank](https://northflank.com) → **Developer Sandbox** (free)
2. New service from GitHub → Dockerfile at `backend/Dockerfile`, port `5000`
3. Set `DATABASE_URL` (Neon) and `JWT_SECRET`
4. Copy URL: `https://your-service.northflank.app`

### Option B — Cloudflare Tunnel (free, no hosting account)

```powershell
cd backend
npm run dev
# new terminal:
.\scripts\start-cloudflare-tunnel.ps1
```

Use the `https://....trycloudflare.com` URL (PC must stay on).

### Firmware (HTTPS)

```cpp
const bool USE_CLOUD_API = true;
const char* CLOUD_API_HOST = "your-service.northflank.app";  // or trycloudflare.com host
```

## Step 5 — Frontend

If backend is online, set `frontend/.env`:

```env
VITE_API_URL=https://your-service.northflank.app/api
```

Rebuild: `npm run build`

---

## Security notes

- Never commit `.env` with real passwords to Git.
- Use a strong `JWT_SECRET` in production.
- Neon connection strings include the password — keep them private.

## Default admin (created on first run)

- Email: `admin@uok.ac.rw`
- Password: `admin123`

Change this password after first login in production.
