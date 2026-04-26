# Flutter User System & Profile - TODO List

## ✅ Phase 1: Dependencies & Helpers
- [x] Update `pubspec.yaml` with new dependencies (sqflite, path, image_picker, connectivity_plus)
- [x] Run `flutter pub get`
- [x] Create `lib/core/utils/app_database.dart` - SQLite database helper (replaces SharedPreferences)
- [x] Create `lib/core/utils/app_connectivity.dart` - Internet connectivity checker

## ✅ Phase 2: New Screens
- [x] Create `lib/core/featuers/profile/App_ProfileScreen.dart` - Profile screen with image picker
- [x] Create `lib/core/featuers/form/App_FormScreen.dart` - Form screen for extra data (age, bio)

## ✅ Phase 3: Navigation Updates
- [x] Update `lib/config/router.dart` - Add profileScreen and formScreen routes
- [x] Update `lib/config/App_router.dart` - Register new routes with GoRouter

## ✅ Phase 4: String Resources
- [x] Update `lib/core/theme/app_string.dart` - Add all new strings

## ✅ Phase 5: Register Screen Updates
- [x] Add Name field to Register screen
- [x] Save user data (name, email, password) to SQLite after registration
- [x] Navigate to Login after successful registration

## ✅ Phase 6: Login Screen Fixes & Updates
- [x] Fix State variables (controllers outside build)
- [x] Validate credentials against SQLite database
- [x] Navigate to Profile on successful login
- [x] Remove unused imports

## ✅ Phase 7: Splash Screen Cleanup
- [x] Remove unused imports

## ✅ Phase 8: Main.dart Cleanup
- [x] Remove unused imports

## ✅ Phase 9: SQLite Migration
- [x] Replace SharedPreferences with SQLite (sqflite + path)
- [x] Delete old `app_shared_preferences.dart`
- [x] Update all screens to use `AppDatabase`

## ✅ Phase 10: Final Polish
- [x] Fix all unused imports across the project
- [x] Verify navigation flow works correctly
- [x] Test image picker and database operations

---

## 🗺️ App Flow
```
Splash → Login/Register → Profile → Form (Add Info) → Profile
```

## 🗄️ Database Schema (SQLite)
- **users** table: id, name, email, password
- **extra_data** table: id, age, bio
- **profile_images** table: id, image_path


