# 🧠 BookBridge — ARCHITECTURE MCP (v1.0)

> **Status:** LOCKED
> **Authority:** Architecture MCP
> **Applies to:** Flutter App, Web App, Firebase Backend, AI Agents (Gemini CLI, Qwen Coder CLI)

---

## 1️⃣ Purpose & Scope

### 🎯 Primary Goal

**Buy and Sell Used Books Nearby** 📚
An online classified marketplace that enables **students** to discover, buy, and sell **used physical books within their locality**.

### 🚫 Explicit Non-Goals (v1)

The following are intentionally **out of scope**:

* Online payments
* Delivery / logistics
* Reviews & ratings
* In-app chat systems
* Digital books (PDFs)
* Global marketplace

> ⚠️ Any feature not serving the *local used-book exchange* violates this architecture.

---

## 2️⃣ Domain Model (Canonical)

### Core Entities

#### 👤 User

Represents a student using BookBridge.

* Users do **not** own books
* Users **own listings**

#### 📘 Book

Represents book metadata (idea of a book).

* Independent of sellers
* Shared across listings
* System-owned

#### 📦 Listing (CORE ENTITY)

Represents a **specific physical copy** of a book offered for sale.

* Belongs to exactly one seller
* Represents exactly one physical book

#### 📍 Location

Represents a normalized locality (campus / town / area).

---

## 3️⃣ Relationships & Invariants

### Relationships

```
User 1 ── owns ──> Many Listings
Book 1 ── referenced by ──> Many Listings
Location 1 ── groups ──> Users & Listings
```

### Invariants (NON-NEGOTIABLE)

* One listing = one physical book
* A sold listing is immutable
* A listing cannot change seller
* Books contain **no price or condition**
* Firebase stores state, not meaning

---

## 4️⃣ Data Schema v1 (Firestore)

### `users`

```
userId (Auth UID)
name
role = "student"
localityId
contact { phone?, whatsapp? }
createdAt
```

### `books` (System-Owned)

```
bookId
title
author
isbn?
category
edition?
createdAt
```

### `listings` (CORE)

```
listingId
bookId
sellerId
price
condition = new | good | fair | poor
localityId
status = available | reserved | sold
createdAt
```

### `locations`

```
localityId
name
city
```

---

## 5️⃣ Data Ownership Rules

| Data          | Owner  |
| ------------- | ------ |
| User profile  | User   |
| Book metadata | System |
| Listings      | Seller |
| Location data | System |

---

## 6️⃣ Security Rules (Conceptual)

### Global

* All access requires authentication (Google Sign-In)

### Users

* Users may read/write **only their own document**

### Books

* Read-only for users
* Write access restricted to system/admin

### Listings

* Create only if `sellerId == auth.uid`
* Update only by seller
* Sold listings are immutable
* Deletion is forbidden in v1

### Locations

* Read-only

---

## 7️⃣ System Boundaries

### Flutter App

* UI rendering
* Input validation (UX-level)
* Calls Firebase APIs

❌ No business rule enforcement beyond UX

### Web App (Svelte/SvelteKit)

Its role is:

* Public landing page

* Read-only browsing of nearby listings

* SEO & discoverability

* Trust & legitimacy

### Firebase

* Single source of truth
* Enforces security & invariants

---

## 8️⃣ AI Agent & MCP Rules

### Allowed

* Generate code that strictly follows this document
* Scaffold UI based on approved flows

### Forbidden

* Changing schema
* Adding entities or fields
* Introducing new features
* Moving business logic across layers

> ❗ Any violation requires Architecture MCP approval.

---

## 9️⃣ Change Control

All changes must:

1. Be proposed explicitly
2. Be reviewed by Architecture MCP
3. Update this document

No silent changes.

---

## 🔒 Final Statement

This document is the **single source of architectural truth** for BookBridge.

> If code and this document disagree — **the code is wrong**.

## 📁 Project Root
bookbridge/
├── ARCHITECTURE.md   ← THIS IS THE ARCHITECTURE MCP
├── README.md
├── firebase/
├── flutter/
├── web/


## 📁 Recommended Flutter Folder Structure (v1)

lib/
├── main.dart
│
├── app/
│   ├── app.dart              // App root
│   ├── router.dart           // Navigation
│   └── theme.dart
│
├── core/
│   ├── constants/
│   │   └── app_constants.dart
│   │
│   ├── utils/
│   │   └── validators.dart
│   │
│   └── errors/
│       └── exceptions.dart
│
├── features/
│   ├── auth/
│   │   ├── data/
│   │   │   └── auth_service.dart
│   │   ├── presentation/
│   │   │   └── auth_gate.dart
│   │   └── state/
│   │       └── auth_provider.dart
│   │
│   ├── listings/
│   │   ├── data/
│   │   │   └── listing_service.dart
│   │   ├── domain/
│   │   │   └── listing_model.dart
│   │   ├── presentation/
│   │   │   ├── listing_card.dart
│   │   │   ├── listing_detail_screen.dart
│   │   │   └── create_listing_screen.dart
│   │   └── state/
│   │       └── listing_provider.dart
│   │
│   ├── books/
│   │   ├── domain/
│   │   │   └── book_model.dart
│   │   └── data/
│   │       └── book_service.dart
│   │
│   ├── users/
│   │   ├── domain/
│   │   │   └── user_model.dart
│   │   └── data/
│   │       └── user_service.dart
│   │
│   └── locations/
│       ├── domain/
│       │   └── location_model.dart
│       └── data/
│           └── location_service.dart
│
└── shared/
    ├── widgets/
    │   └── loading_indicator.dart
    └── services/
        └── firebase_service.dart

## State Management Rules (Riverpod)

1️⃣ Riverpod Philosophy (Non-Negotiable)

Providers coordinate. Services execute. Models describe. Widgets render.

If a file violates this, it’s wrong.

2️⃣ Approved Provider Types (v1)

We will use only these:

Provider → services, repositories

FutureProvider → one-time reads

StreamProvider → live Firestore streams

StateNotifierProvider → user-initiated actions

❌ No ChangeNotifierProvider
3️⃣ Where Providers Live (Strict)
features/
  listings/
    state/
      listing_provider.dart
No global provider dumping

Providers are feature-scoped

Shared providers only in shared/

4️⃣ Example: Listings (Conceptual Flow)
🔹 listing_service.dart

Talks to Firestore

No Riverpod imports

🔹 listing_provider.dart

Calls listing_service

Exposes state to UI

Enforces immutability rules

🔹 UI

Watches provider

Sends user intents (create, mark sold)

UI never touches Firestore.

5️⃣ Authentication Flow (Google Sign-In)
Pattern:
AuthGate
   ↓
authProvider
   ↓
FirebaseAuth

Auth state is global

Everything else is feature-local

6️⃣ File Naming Rules (AI-Friendly)

*_model.dart

*_service.dart

*_provider.dart

*_screen.dart

If AI generates anything else — fix it.

7️⃣ You Are Now Allowed to Code

This is the moment I promised.

🟢 You may now start generating Flutter code using Gemini CLI / Qwen Coder CLI.

But only in this order:
🚦 CODING ORDER (Do NOT Skip)
Step 1️⃣

Generate domain models:

user_model.dart

book_model.dart

listing_model.dart

location_model.dart

📌 Prompt must reference ARCHITECTURE.md.

Step 2️⃣

Generate Firebase services:

auth_service.dart

listing_service.dart

book_service.dart

user_service.dart

Step 3️⃣

Generate Riverpod providers:

auth_provider.dart

listing_provider.dart

Step 4️⃣

Only then:

Screens

Widgets

Navigation

⚠️ Absolute Rule (Read This Carefully).
