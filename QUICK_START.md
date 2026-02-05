# 🚀 Quick Start Guide

## ⚡ Run the App (3 Steps)

```bash
# 1. Navigate to project
cd /Users/mac/AndroidStudioProjects/ecommerceapp

# 2. Install dependencies
flutter pub get

# 3. Run on your device/simulator
flutter run
```

---

## 📱 What You'll See

### Flow
1. **Splash Screen** (2 seconds)
2. **Onboarding** (3 slides) - First time only
3. **Login Screen**

### Test the App
- Swipe through onboarding slides
- Try login with invalid email/password
- Click "Sign Up" and test validation
- Click "Forgot Password" and complete flow
- Toggle password visibility
- Check Terms checkbox validation

---

## 🎨 Theme Colors

All screens use these consistent colors:

| Element | Color |
|---------|-------|
| Primary Buttons | Purple `#6C63FF` |
| Accent/Highlights | Pink `#FF6584` |
| Background | Light Gray `#F8F9FA` |
| Text | Dark Gray `#2D3436` |
| Success | Green `#00B894` |
| Error | Red `#FF7675` |

---

## �� File Locations

Need to edit something? Here's where everything is:

```
lib/
├── main.dart                                    ← Splash screen
├── core/
│   ├── constants/app_colors.dart               ← Change colors
│   ├── constants/app_sizes.dart                ← Change spacing
│   └── theme/app_theme.dart                    ← Change theme
├── screens/
│   ├── onboarding/onboarding_screen.dart       ← Edit onboarding
│   └── auth/
│       ├── login_screen.dart                   ← Edit login
│       ├── signup_screen.dart                  ← Edit signup
│       └── forgot_password_screen.dart         ← Edit forgot password
```

---

## 🛠️ Common Commands

```bash
# Clean build
flutter clean && flutter pub get

# Check for issues
flutter analyze

# Run in debug mode
flutter run

# Run in release mode (faster)
flutter run --release

# Hot reload (press 'r' in terminal while app running)
# Hot restart (press 'R' in terminal)

# Clear onboarding and restart
# Just uninstall and reinstall the app
```

---

## ✅ Validation Rules Quick Reference

### Login
- Email: Must be valid format
- Password: Min 6 characters

### Sign Up
- Name: Min 3 characters
- Email: Valid format
- Password: 8+ chars, 1 uppercase, 1 number
- Must match confirm password
- Must accept terms

### Forgot Password
- Email: Valid format

---

## 🎯 Next Features to Add

Ready to extend? Here are logical next steps:

1. **Home Screen** - Product grid/list
2. **Product Detail** - Full product info
3. **Cart Screen** - Add/remove items
4. **Profile Screen** - User info/settings
5. **Search** - Product search
6. **Backend Integration** - Connect to API
7. **Firebase Auth** - Real authentication
8. **Payment** - Stripe/PayPal integration

---

## 📖 More Info

- Full docs: `README.md`
- Project overview: `PROJECT_SUMMARY.md`
- This guide: `QUICK_START.md`

---

**Happy Coding! 🎉**
