# Unified Smart Card — Thesis Alignment

This project implements the **Unified Smart Card** system described in the thesis by MANZI Maurice (University of Kigali, 2026).

## General Objective (1.3.1)

Design and implement a unified QR-based smart campus management system that replaces multiple physical campus cards with a single digital solution for:

- Student identification  
- Attendance management  
- Access control  
- Cafeteria payments  
- Transport fare management  

## Specific Objectives (1.3.2) → System Modules

| Objective | Module | Route | Description |
|-----------|--------|-------|-------------|
| **I** | Attendance Management | `/attendance` | QR-based attendance recording |
| **II** | Virtual Wallet + Cafeteria | `/cafeteria`, `/wallet` | Cashless cafeteria payments via QR scan |
| **III** | Virtual Wallet + Transport | `/transport`, `/wallet` | Transport fare via QR scan |
| **IV** | Access Control | `/access` | Secure QR-based facility access |
| General | Student Identification | `/qrcode` | Single digital campus ID |

## Research Questions (1.4) → Evaluation Focus

1. Does the attendance module enable accurate and efficient recording?  
2. Does the wallet support cafeteria payments through QR scanning?  
3. Does the wallet support transport payments through QR scanning?  
4. Does access control facilitate secure access to authorized facilities?  

## Significance (1.5)

- **Students** — one app, no multiple cards, real-time records  
- **Lecturers & staff** — faster attendance, fewer manual tasks  
- **University of Kigali** — digital transformation, smart campus  
- **Administrators** — centralized dashboard and reports  
- **Rwanda's digital economy** — local smart-campus solution  

## Technical Stack (as per thesis methodology)

- Frontend: React.js, Tailwind CSS  
- Backend: Node.js, Express.js  
- Database: PostgreSQL  
- Authentication: JWT  
- QR: generation and verification APIs  

## Project folder

Code lives in `taplife-system/` (internal project name). User-facing branding: **Unified Smart Card**.
