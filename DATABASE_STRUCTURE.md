# TapLife Database Structure

## 📊 Database Name: `taplife_db`

## 🗄️ Complete Table Structure

### 1️⃣ USERS Table (Core)
```
users
├── user_id (Primary Key)
├── registration_number (Unique)
├── email (Unique)
├── password_hash
├── first_name
├── last_name
├── user_role (student/lecturer/admin)
├── phone_number
├── department
├── program
├── year_of_study
├── profile_image
├── is_active
├── created_at
└── updated_at
```

### 2️⃣ QR_CODES Table
```
qr_codes
├── qr_id (Primary Key)
├── user_id (Foreign Key → users)
├── qr_code_data (JSON string)
├── qr_code_type (student_id/attendance/access/cafeteria/transport)
├── qr_image_url (Base64 image)
├── is_permanent (true/false)
├── expires_at
├── created_at
└── is_active
```

### 3️⃣ ATTENDANCE_SESSIONS Table
```
attendance_sessions
├── session_id (Primary Key)
├── lecturer_id (Foreign Key → users)
├── course_code
├── course_name
├── session_date
├── session_time
├── duration_minutes
├── room_number
├── qr_code_data
├── qr_expires_at
├── is_active
└── created_at
```

### 4️⃣ ATTENDANCE_RECORDS Table
```
attendance_records
├── attendance_id (Primary Key)
├── session_id (Foreign Key → attendance_sessions)
├── student_id (Foreign Key → users)
├── scan_timestamp
├── scan_location
└── status (present/late/absent)
```

### 5️⃣ ACCESS_LOCATIONS Table
```
access_locations
├── location_id (Primary Key)
├── location_name
├── location_type (building/room/lab/library/office)
├── permanent_qr_code (Unique)
├── description
├── restricted (true/false)
├── is_active
└── created_at
```

### 6️⃣ ACCESS_LOGS Table
```
access_logs
├── log_id (Primary Key)
├── user_id (Foreign Key → users)
├── location_id (Foreign Key → access_locations)
├── access_timestamp
├── access_granted (true/false)
├── denied_reason
└── entry_exit (entry/exit)
```

### 7️⃣ VIRTUAL_WALLETS Table
```
virtual_wallets
├── wallet_id (Primary Key)
├── user_id (Foreign Key → users, Unique)
├── balance (Decimal 10,2)
├── currency (RWF)
├── last_transaction_date
├── created_at
└── updated_at
```

### 8️⃣ WALLET_TRANSACTIONS Table
```
wallet_transactions
├── transaction_id (Primary Key)
├── wallet_id (Foreign Key → virtual_wallets)
├── user_id (Foreign Key → users)
├── transaction_type (topup/cafeteria/transport/refund)
├── amount
├── balance_before
├── balance_after
├── description
├── transaction_status (pending/completed/failed/reversed)
├── transaction_date
└── location
```

### 9️⃣ CAFETERIA_TRANSACTIONS Table
```
cafeteria_transactions
├── cafeteria_id (Primary Key)
├── transaction_id (Foreign Key → wallet_transactions)
├── user_id (Foreign Key → users)
├── meal_type (breakfast/lunch/dinner/snack)
├── items_purchased
├── amount
├── cafeteria_location
└── transaction_timestamp
```

### 🔟 TRANSPORT_TRANSACTIONS Table
```
transport_transactions
├── transport_id (Primary Key)
├── transaction_id (Foreign Key → wallet_transactions)
├── user_id (Foreign Key → users)
├── route
├── vehicle_number
├── fare_amount
├── departure_time
├── arrival_time
└── transaction_timestamp
```

### 1️⃣1️⃣ ACTIVITY_LOGS Table
```
activity_logs
├── log_id (Primary Key)
├── user_id (Foreign Key → users)
├── activity_type
├── activity_description
├── ip_address
├── user_agent
└── created_at
```

---

## 🔗 Database Relationships

```
users (1) ──→ (Many) qr_codes
users (1) ──→ (Many) attendance_sessions (as lecturer)
users (1) ──→ (Many) attendance_records (as student)
users (1) ──→ (1) virtual_wallets
users (1) ──→ (Many) wallet_transactions
users (1) ──→ (Many) access_logs
users (1) ──→ (Many) cafeteria_transactions
users (1) ──→ (Many) transport_transactions
users (1) ──→ (Many) activity_logs

attendance_sessions (1) ──→ (Many) attendance_records
access_locations (1) ──→ (Many) access_logs
virtual_wallets (1) ──→ (Many) wallet_transactions
wallet_transactions (1) ──→ (1) cafeteria_transactions
wallet_transactions (1) ──→ (1) transport_transactions
```

---

## 📝 Sample Data Pre-loaded

When you run `database.sql`, these are automatically created:

### Default Admin User
- Email: admin@taplife.com
- Password: admin123 (hashed)
- Registration: ADMIN001
- Role: admin

### Sample Locations
1. Main Building (public)
2. Computer Lab A (restricted)
3. Library (public)
4. Admin Block (restricted)

---

## 🎯 How the Database Works

### Student Registration Flow:
1. User registers → Record in `users` table
2. If student → Automatically creates `virtual_wallets` record
3. Student generates QR → Record in `qr_codes` table

### Attendance Flow:
1. Lecturer creates session → `attendance_sessions` table
2. Student scans QR → `attendance_records` table
3. Activity logged → `activity_logs` table

### Payment Flow:
1. Student tops up → `wallet_transactions` table (type: topup)
2. Student pays cafeteria → `wallet_transactions` + `cafeteria_transactions`
3. Balance updated → `virtual_wallets` table
4. Activity logged → `activity_logs` table

### Access Control Flow:
1. Student scans at location → System checks `access_locations`
2. Access granted/denied → `access_logs` table
3. Activity logged → `activity_logs` table

---

## 🔐 Security Features

1. **Passwords**: Hashed with bcryptjs (not stored in plain text)
2. **Indexes**: Created on frequently queried columns for speed
3. **Foreign Keys**: Ensure data integrity (CASCADE on delete)
4. **Unique Constraints**: Prevent duplicate emails and registration numbers
5. **Validation**: Check constraints on enums (user_role, meal_type, etc.)

---

## 💡 Quick Commands

### Check if database exists:
```sql
\l
```

### Connect to database:
```sql
\c taplife_db
```

### List all tables:
```sql
\dt
```

### See table structure:
```sql
\d users
```

### Count records in a table:
```sql
SELECT COUNT(*) FROM users;
```

### View all users:
```sql
SELECT * FROM users;
```

---

## 📊 Expected Table Sizes

After fresh installation:
- users: 1 row (admin)
- access_locations: 4 rows
- All other tables: 0 rows (will grow as system is used)

---

**Your database is the heart of TapLife!** ❤️

Once created, the backend will connect to it automatically using the settings in `backend/.env`.
