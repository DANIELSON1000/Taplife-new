# TapLife Quick Start Guide

## Get Started in 5 Minutes! 🚀

Follow these steps to run the TapLife system on your computer.

### Step 1: Install Required Software (One-time setup)

1. **Install Node.js**
   - Download from: https://nodejs.org/
   - Choose the LTS version (recommended)
   - Follow installation wizard

2. **Install PostgreSQL**
   - Download from: https://www.postgresql.org/download/
   - During installation, set password: `hirwa` (or remember your password)
   - Remember the port (default: 5432)

### Step 2: Setup Database (5 minutes)

1. **Open Command Prompt** (Windows) or **Terminal** (Mac/Linux)

2. **Create Database**
   ```bash
   psql -U postgres
   ```
   Enter your PostgreSQL password when prompted.

   Then type:
   ```sql
   CREATE DATABASE taplife_db;
   \q
   ```

3. **Load Database Schema**
   ```bash
   cd "C:\Users\HP\Documents\maurice manzi UK\taplife-system\backend"
   psql -U postgres -d taplife_db -f database.sql
   ```

### Step 3: Start Backend (2 minutes)

1. **Open Command Prompt/Terminal**

2. **Navigate to backend folder**
   ```bash
   cd "C:\Users\HP\Documents\maurice manzi UK\taplife-system\backend"
   ```

3. **Install Dependencies** (first time only)
   ```bash
   npm install
   ```

4. **Start Backend Server**
   ```bash
   npm run dev
   ```

   ✅ You should see: `🚀 TapLife Backend Server Started`

   **Keep this terminal open!**

### Step 4: Start Frontend (2 minutes)

1. **Open NEW Command Prompt/Terminal** (don't close the backend one)

2. **Navigate to frontend folder**
   ```bash
   cd "C:\Users\HP\Documents\maurice manzi UK\taplife-system\frontend"
   ```

3. **Install Dependencies** (first time only)
   ```bash
   npm install
   ```

4. **Start Frontend Application**
   ```bash
   npm run dev
   ```

   ✅ You should see: `Local: http://localhost:3000/`

   **Keep this terminal open too!**

### Step 5: Use the System! 🎉

1. **Open your browser** (Chrome, Firefox, Edge)

2. **Go to**: `http://localhost:3000`

3. **Create an Account**:
   - Click "Register here"
   - Fill in your details
   - Choose role: Student
   - Click "Create Account"

4. **You're in!** 🎊

---

## Common Issues & Solutions

### ❌ Problem: "Port 5000 already in use"

**Solution**: 
```bash
# Kill the process using port 5000
# Windows:
netstat -ano | findstr :5000
taskkill /PID <PID_NUMBER> /F

# Mac/Linux:
lsof -ti:5000 | xargs kill -9
```

### ❌ Problem: "Cannot connect to database"

**Solution**: 
1. Make sure PostgreSQL is running
2. Check password in `backend/.env` file
3. Verify database name is correct: `taplife_db`

### ❌ Problem: "npm: command not found"

**Solution**: Node.js is not installed or not in PATH
- Reinstall Node.js
- Restart your terminal

### ❌ Problem: Frontend shows blank page

**Solution**:
1. Check backend is running (terminal should show "Server Started")
2. Clear browser cache (Ctrl + Shift + Delete)
3. Refresh page (Ctrl + R or F5)

---

## What's Next?

### Try These Features:

1. **Generate Your QR Code**
   - Dashboard → My QR Code → Generate

2. **Top Up Your Wallet**
   - Dashboard → Virtual Wallet → Top Up
   - Try: 10,000 RWF

3. **Make a Purchase**
   - Dashboard → Cafeteria → Pay Now
   - Select meal and pay

4. **View Your Activity**
   - Dashboard → Attendance (view records)
   - Dashboard → Wallet (view transactions)

---

## Test Accounts (After Database Setup)

**Student**
- Email: student@example.com
- Password: password123

**Lecturer**
- Email: lecturer@example.com  
- Password: password123

**Admin**
- Email: admin@taplife.com
- Password: admin123

---

## Need Help?

### Check Logs
- Backend logs are in the terminal running `npm run dev`
- Frontend errors show in browser Console (F12)

### Documentation
- Main README: `README.md`
- Backend docs: `backend/README.md`
- Frontend docs: `frontend/README.md`

---

## Stopping the System

1. **Stop Frontend**: Press `Ctrl + C` in frontend terminal
2. **Stop Backend**: Press `Ctrl + C` in backend terminal

---

**🎓 Developed by MANZI Maurice | University of Kigali 2026**

*Having issues? Check the README.md file for detailed troubleshooting!*
