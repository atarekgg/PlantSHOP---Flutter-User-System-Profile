# 🌿 PlantSHOP - Flutter User System & Profile

A complete Flutter application featuring user authentication, profile management, and local data storage using SQLite.

---

## ✨ Features

### 1. Splash Screen
- Beautiful splash screen with background image and logo
- Auto-navigation to Login screen after 5 seconds

### 2. Authentication System
- **Register Screen**: Create account with Name, Email, and Password
- **Login Screen**: Secure login with credential validation against SQLite database
- Form validation with user-friendly error messages

### 3. Profile Screen
- Display user information (Name, Email)
- **CircleAvatar** with profile image support
- **Image Picker**: Choose profile picture from Camera or Gallery
- Display additional user data (Age, Bio)
- **Internet Connectivity Check**: Real-time connection status indicator
- **Logout**: Clear all data and return to Login

### 4. Form Screen (Add Extra Data)
- Collect additional user information (Age, Bio)
- Save data to SQLite database
- Pre-fill existing data for editing

### 5. Navigation
- Smooth navigation using **GoRouter**
- Clean route management with centralized routing configuration

---

## 🛠️ Tech Stack

| Technology | Purpose |
|------------|---------|
| **Flutter** | UI Framework |
| **Dart** | Programming Language |
| **GoRouter** | Navigation & Routing |
| **SQLite (sqflite)** | Local Database |
| **path** | Database path management |
| **Image Picker** | Camera & Gallery access |
| **Connectivity Plus** | Internet connection checking |
| **Flutter SVG** | SVG icon rendering |
| **Device Preview** | Responsive design testing |

---

## 🗄️ Database Schema (SQLite)

### `users` Table
| Column | Type | Description |
|--------|------|-------------|
| id | INTEGER PRIMARY KEY AUTOINCREMENT | User ID |
| name | TEXT NOT NULL | Full name |
| email | TEXT NOT NULL UNIQUE | Email address |
| password | TEXT NOT NULL | Password |

### `extra_data` Table
| Column | Type | Description |
|--------|------|-------------|
| id | INTEGER PRIMARY KEY AUTOINCREMENT | Data ID |
| age | TEXT | User age |
| bio | TEXT | User biography |

### `profile_images` Table
| Column | Type | Description |
|--------|------|-------------|
| id | INTEGER PRIMARY KEY AUTOINCREMENT | Image ID |
| image_path | TEXT | Local image file path |

---

## 🗺️ App Navigation Flow

```
┌─────────────┐     ┌─────────────┐     ┌─────────────┐
│   Splash    │────▶│Login/Register│────▶│   Profile   │
│   Screen    │     │   Screen     │     │   Screen    │
└─────────────┘     └─────────────┘     └──────┬──────┘
                                                │
                                         ┌──────▼──────┐
                                         │  Form Screen │
                                         │ (Add Info)   │
                                         └─────────────┘
```

---

## 📁 Project Structure

```
lib/
├── main.dart                          # App entry point
├── config/
│   ├── App_router.dart                # GoRouter configuration
│   └── router.dart                    # Route constants
├── core/
│   ├── assets/
│   │   ├── app_icons.dart             # SVG icon paths
│   │   └── app_images.dart            # Image asset paths
│   ├── featuers/
│   │   ├── SplashScreen/
│   │   │   └── App_SplashScreen.dart  # Splash screen
│   │   ├── login/
│   │   │   └── App_LoginScreen.dart   # Login screen
│   │   ├── register/
│   │   │   └── App_RegisterScreen.dart# Register screen
│   │   ├── profile/
│   │   │   └── App_ProfileScreen.dart # Profile screen
│   │   └── form/
│   │       └── App_FormScreen.dart    # Form screen
│   ├── theme/
│   │   ├── app_colors.dart            # Color palette
│   │   ├── app_string.dart            # All text strings
│   │   ├── app_text_style.dart        # Text styles
│   │   └── app_theme.dart             # App theme data
│   └── utils/
│       ├── app_database.dart          # SQLite database helper
│       ├── app_connectivity.dart      # Internet checker
│       └── app_responsive.dart        # Responsive utilities
├── assets/
│   ├── icons/                         # SVG icons
│   └── images/                        # PNG images
└── android/
    └── app/
        └── src/
            └── main/
                └── AndroidManifest.xml # App permissions
```

---

## 🚀 Getting Started

### Prerequisites
- Flutter SDK (^3.11.1)
- Dart SDK
- Android Studio / VS Code
- Android Emulator or Physical Device

### Installation

1. **Clone the repository**
   ```bash
   git clone <repository-url>
   cd login
   ```

2. **Install dependencies**
   ```bash
   flutter pub get
   ```

3. **Run the app**
   ```bash
   flutter run
   ```

---

## 📱 Screens

| Screen | Description |
|--------|-------------|
| **Splash** | App launch screen with logo and background |
| **Login** | Email & password login with validation |
| **Register** | New account creation with name, email, password |
| **Profile** | User profile with image, info, and connectivity status |
| **Form** | Add/edit additional user data (age, bio) |

---

## 🔐 Permissions

The app requires the following permissions (configured in `AndroidManifest.xml`):

```xml
<uses-permission android:name="android.permission.INTERNET" />
<uses-permission android:name="android.permission.CAMERA" />
<uses-permission android:name="android.permission.READ_EXTERNAL_STORAGE" />
```

---

## 🎨 Design System

- **Primary Color**: `#004643` (Dark Teal)
- **Background**: `#FFFFFF` (White)
- **Error Color**: `#D32F2F` (Red)
- **Font Family**: Cairo / Manrope
- **Border Radius**: 8px (consistent across all inputs)

---

## 📝 Notes

- All user data is stored locally using **SQLite** (no internet required for auth)
- Profile images are stored as local file paths
- Internet connectivity is checked and displayed in real-time on the Profile screen
- Form validation ensures data integrity before saving

---

## 📄 License

This project is for educational purposes.

---

## 👨‍💻 Developer

Ahmed T. Abdelwahed
