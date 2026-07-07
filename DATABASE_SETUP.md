# Database Setup Instructions for TapLife

## About the Database

**Database Name:** `taplife_db`
**Database Type:** PostgreSQL
**Username:** postgres
**Password:** hirwa (as you specified)

## How I Created the Database Schema

The database includes **11 tables** to manage the entire TapLife system:

1. **users** - Stores all users (students, lecturers, admins)
2. **qr_codes** - Stores generated QR codes
3. **attendance_sessions** - Stores lecture sessions
4. **attendance_records** - Stores student attendance
5. **access_locations** - Stores campus locations (buildings, labs)
6. **access_logs** - Logs all access attempts
7. **virtual_wallets** - Stores student wallet balances
8. **wallet_transactions** - All wallet transactions
9. **cafeteria_transactions** - Meal purchases
10. **transport_transactions** - Transport fares
11. **activity_logs** - System activity logs

---

## STEP-BY-STEP: Create the Database

### Option 1: Using pgAdmin (GUI - Easiest)

1. **Open pgAdmin** (search for it in Windows Start menu)

2. **Connect to PostgreSQL**
   - Click on "Servers" → "PostgreSQL"
   - Enter password: `hirwa`

3. **Create Database**
   - Right-click "Databases"
   - Click "Create" → "Database"
   - Name: `taplife_db`
   - Click "Save"

4. **Load Schema**
   - Click on `taplife_db`
   - Click "Tools" → "Query Tool"
   - Click "Open File" icon
   - Navigate to: `C:\Users\HP\Documents\maurice manzi UK\taplife-system\backend\database.sql`
   - Click "Execute" (⚡ icon) or press F5

✅ **Done!** Your database is ready.

---

### Option 2: Using Command Line (CMD)

1. **Open Command Prompt** (Windows Key + R, type `cmd`, press Enter)

2. **Navigate to PostgreSQL bin folder** (adjust version number if different):
   ```cmd
   cd "C:\Program Files\PostgreSQL\15\bin"
   ```
   
   OR if PostgreSQL 16:
   ```cmd
   cd "C:\Program Files\PostgreSQL\16\bin"
   ```

3. **Create the database:**
   ```cmd
   psql -U postgres -c "CREATE DATABASE taplife_db;"
   ```
   Enter password: `hirwa`

4. **Load the schema:**
   ```cmd
   psql -U postgres -d taplife_db -f "C:\Users\HP\Documents\maurice manzi UK\taplife-system\backend\database.sql"
   ```

✅ **Done!** Your database is ready.

---

### Option 3: Using SQL Shell (psql)

1. **Open SQL Shell (psql)** from Start menu

2. Press Enter for all prompts (Server, Database, Port, Username) to use defaults

3. **Enter password:** `hirwa`

4. **Create database:**
   ```sql
   CREATE DATABASE taplife_db;
   ```

5. **Connect to the new database:**
   ```sql
   \c taplife_db
   ```

6. **Load schema file:**
   ```sql
   \i 'C:/Users/HP/Documents/maurice manzi UK/taplife-system/backend/database.sql'
   ```
   *(Note: Use forward slashes / )*

✅ **Done!** Your database is ready.

---

## Verify Database Was Created

In psql or pgAdmin, run:
```sql
\dt
```
OR
```sql
SELECT table_name FROM information_schema.tables WHERE table_schema = 'public';
```

You should see **11 tables**:
- users
- qr_codes
- attendance_sessions
- attendance_records
- access_locations
- access_logs
- virtual_wallets
- wallet_transactions
- cafeteria_transactions
- transport_transactions
- activity_logs

---

## Sample Data Included

The database.sql file automatically creates:
- ✅ 1 Admin user (admin@taplife.com)
- ✅ 4 Sample access locations (Main Building, Lab, Library, Admin Block)

---

## If You Get Errors

### Error: "database already exists"
✅ **Good!** The database is already created. Just load the schema:
```cmd
psql -U postgres -d taplife_db -f "path\to\database.sql"
```

### Error: "password authentication failed"
- Your PostgreSQL password is NOT `hirwa`
- Change the password in `backend/.env` file to match your actual password

### Error: "psql not found"
- PostgreSQL is not in your system PATH
- Use Option 1 (pgAdmin) instead
- Or use full path to psql.exe

---

## Connection Details for Backend

The backend connects using these settings (in `backend/.env`):

```
DB_HOST=localhost
DB_PORT=5432
DB_NAME=taplife_db
DB_USER=postgres
DB_PASSWORD=hirwa
```

**Important:** If your PostgreSQL password is different, change `DB_PASSWORD=hirwa` to your actual password!

---

## After Database is Created

You can now run the project:

1. **Start Backend:**
   ```cmd
   cd "C:\Users\HP\Documents\maurice manzi UK\taplife-system\backend"
   npm install
   npm run dev
   ```

2. **Start Frontend:**
   ```cmd
   cd "C:\Users\HP\Documents\maurice manzi UK\taplife-system\frontend"
   npm install
   npm run dev
   ```

3. **Open browser:** http://localhost:3000

---

## Need Help?

If you're stuck, tell me:
1. Which option you tried (1, 2, or 3)
2. What error message you see
3. What step you're on

I'll help you fix it! 😊
