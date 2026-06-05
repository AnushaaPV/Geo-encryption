# Geo-Encryption 🔐🌍
### Enhanced Location and Time-Bound Cryptographic System

> A security-enhanced academic platform that binds encrypted data — including exam question papers — to authorized geographic coordinates and time windows. Data can only be decrypted at the right place, at the right time.

---

## 📌 Overview

Geo-Encryption is an academic management system that strengthens traditional cryptography by adding **location** and **time** as factors in key generation and data access. Built around an online examination and student management ecosystem, it ensures that sensitive content such as question papers, certificates, and student records can only be accessed from **pre-authorized geographic coordinates**.

This approach directly addresses vulnerabilities in conventional encryption — where a leaked key alone is sufficient to decrypt data — by requiring the decryptor to also be physically present at the correct location within a valid time window.

---

## 🔑 Key Features

- **Geo-bound decryption** — Data is encrypted such that it can only be unlocked at authorized latitude/longitude coordinates.
- **Time-restricted access** — Decryption is further constrained by time windows, preventing early or delayed access.
- **RSA asymmetric encryption** — Public/private key pairs are used to encrypt messages and exam-related content.
- **Armstrong number integrity check** — Question papers include an Armstrong number field for basic data integrity verification.
- **Multi-role academic platform** — Supports Admin, College, Staff, Student, and Company user types.
- **Exam & question paper management** — Colleges upload encrypted question papers that students access only at the right time and place.
- **Online test/MCQ system** — Students take tests; results are stored and linked to their profiles.
- **Digital certificates** — Score-linked certificates with public key references for verification.
- **Staff allocation & subject assignment** — Colleges assign invigilators and subject-specific staff to exams.
- **Chat system** — Messaging between users (students, staff, colleges).
- **Job vacancy portal** — Companies post vacancies; students can apply and track request status.
- **Study materials & notes** — Staff upload subject-wise notes accessible to enrolled students.

---

## 🏗️ System Architecture

```
┌──────────────────────────────────────────────────────────┐
│                    Web Application                        │
│         (HTML + CSS + PHP + Python + JavaScript)          │
└─────────────────────────┬────────────────────────────────┘
                          │
          ┌───────────────┼───────────────┐
          │               │               │
  ┌───────▼──────┐ ┌──────▼──────┐ ┌─────▼───────┐
  │  Geo-Encrypt │ │  User Mgmt  │ │  Exam Mgmt  │
  │  Engine      │ │  (Roles)    │ │  & Q Papers │
  └───────┬──────┘ └──────┬──────┘ └─────┬───────┘
          │               │               │
          └───────────────┴───────────────┘
                          │
                ┌─────────▼──────────┐
                │   MySQL Database   │
                │   (geoencryption)  │
                └────────────────────┘
```

---

## 🌐 How Geo-Encryption Works

Traditional encryption relies solely on a secret key. Geo-Encryption extends this by deriving or validating the encryption key using:

1. **GPS Coordinates (Latitude & Longitude)** — The authorized location of decryption.
2. **Time window** — The exam/access schedule stored in `examschedule`.
3. **RSA Key Pair** — Per-user asymmetric keys stored in the `cipher` table.

### Encryption Flow

```
Plaintext → RSA Encrypt (Public Key + Geo Seed) → Ciphertext stored in DB
```

### Decryption Flow

```
Request to decrypt
      │
      ├─ Is current location within authorized coordinates? ──► NO → Access Denied
      │
      ├─ Is current time within the exam/access window? ──────► NO → Access Denied
      │
      └─ YES → RSA Decrypt using Private Key → Plaintext returned
```

---

## 👥 User Roles

| Role | Description |
|---|---|
| **Admin** | Platform-wide management; manages colleges, staff, exams |
| **College** | Registers departments, courses, uploads encrypted question papers, manages staff allocation |
| **Staff** | Assigned to subjects and exams; uploads notes and study materials |
| **Student** | Accesses geo-locked content, takes tests, views results and certificates |
| **Company** | Posts job vacancies; reviews student applications |

---

## 🗄️ Database Schema

The MySQL database (`geoencryption`) contains the following core tables:

| Table | Purpose |
|---|---|
| `login` | Authentication for all user types |
| `college` | College details including **latitude & longitude** for geo-locking |
| `dept` | Departments within colleges |
| `course` | Courses offered per department |
| `subject` | Subjects per course |
| `student` | Student profiles linked to departments |
| `cipher` | RSA encrypted messages, public keys, and private keys per student |
| `qppr` | Encrypted question papers with Armstrong number integrity check |
| `examschedule` | Exam date and time — defines the decryption time window |
| `allocate` | Staff-to-exam and college allocations |
| `allot_subject` | Staff-to-subject assignments |
| `question` | MCQ question bank with options and answers |
| `answer` | Student responses to test questions |
| `test` | Test/quiz definitions |
| `result` | Student test results |
| `certificate` | Score-linked digital certificates with public key reference |
| `notes` | Study material files per subject |
| `chat` | Inter-user messaging |
| `complaints` | Student/user complaints and replies |
| `vaccancy` | Company job postings |
| `request` | Student job applications and status tracking |
| `company` | Company profiles |

---

## 🔒 Security Highlights

- **Location-bound access:** The `college` table stores `lati` (latitude) and `longi` (longitude) for each institution. Geo-verification checks whether the decrypting party is physically within the authorized area.
- **RSA Encryption:** Each cipher entry holds a unique RSA public/private key pair per student, ensuring per-user encrypted messages that cannot be decrypted by others.
- **Armstrong Number Integrity:** Question papers include an `armstrongno` field used as a lightweight checksum to detect tampering.
- **Time-locked exams:** The `examschedule` table ties paper access to a specific date and time, preventing early retrieval of exam content.
- **Role-based access control:** Five distinct user types with separate authentication flows.

---

## 🛠️ Tech Stack

| Layer | Technology |
|---|---|
| Frontend | HTML (69.9%), CSS (13.0%), JavaScript (2.0%) |
| Backend | Python (14.2%), PHP (0.9%) |
| Database | MySQL 5.5+ |
| Cryptography | RSA (asymmetric key pairs) |
| IDE Config | IntelliJ IDEA (`.idea/`) |

---

## 📁 Project Structure

```
Geo-encryption/
│
├── .idea/              # IDE project configuration (IntelliJ/PyCharm)
├── src/                # Core application source files
│                       # (Python backend, PHP scripts, HTML templates)
│
├── db.sql              # Full MySQL database dump (schema + seed data)
└── README.md
```

---

## 🚀 Getting Started

### Prerequisites

- Python 3.8+
- PHP 7.4+ (or a web server like XAMPP / WAMP / Apache)
- MySQL 5.5+
- A web browser with Geolocation API support

### Setup

**1. Clone the repository**
```bash
git clone https://github.com/AnushaaPV/Geo-encryption.git
cd Geo-encryption
```

**2. Import the database**
```bash
mysql -u root -p < db.sql
```
This creates the `geoencryption` database with all tables and sample data.

**3. Configure database connection**

Update your DB credentials in the relevant backend config file inside `src/`.

**4. Start the server**

For PHP:
```bash
php -S localhost:8000 -t src/
```
For Python (Flask/Django):
```bash
cd src
python app.py
```

**5. Open in browser**

Navigate to `http://localhost:8000` and log in with one of the test accounts:

| Username | Password | Role |
|---|---|---|
| `admin` | `admin` | Admin |
| `student` | `555` | Student |
| `deepa` | `Deepa123` | College |
| `com` | `123` | Company |

---

## 🔑 Encryption / Decryption Usage

When a student requests access to geo-locked content:

1. The browser requests the user's current GPS location (via the Geolocation API).
2. The backend compares the coordinates against the authorized college coordinates.
3. The current timestamp is checked against the exam schedule.
4. On successful validation, the RSA private key is used to decrypt the ciphertext from the `cipher` table.
5. The decrypted content is delivered to the client.

If location or time validation fails, access is denied without exposing any key material.

---

## 🌱 Use Cases

- **Secure exam paper distribution** — Universities can distribute question papers that only unlock at registered exam centers at the scheduled time.
- **Location-verified document access** — Legal or government documents accessible only at authorized offices.
- **Geo-fenced corporate data** — Sensitive corporate data only accessible from within office premises.
- **Anti-leak examination systems** — Prevents early access and unauthorized distribution of exam material.

---

## 🤝 Contributing

Contributions are welcome! Fork the repository, create a feature branch, and open a pull request with a clear description of your changes.

---

## 📄 License

This project is open source. Please refer to the repository for license details.

---

