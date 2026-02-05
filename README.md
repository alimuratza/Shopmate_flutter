# E-Commerce Flutter App 🛍️

A professional, production-ready e-commerce mobile application built with Flutter, featuring beautiful UI/UX design and consistent theming throughout.

## ✨ Features

### 🎨 UI/UX Highlights
- **Consistent Design System**: Unified color palette, typography, and spacing across all screens
- **Material Design 3**: Modern, professional UI components
- **Smooth Animations**: Page transitions and micro-interactions
- **Responsive Layout**: Works seamlessly on different screen sizes

### 📱 Screens Implemented

#### 1. Splash Screen
- Beautiful gradient background
- App logo and branding
- Auto-navigation based on onboarding status

#### 2. Onboarding (3 Slides)
- **Slide 1**: Discover Amazing Products
- **Slide 2**: Secure Payment
- **Slide 3**: Fast Delivery
- Smooth page indicators
- Skip functionality
- Back/Next navigation

#### 3. Authentication Screens

**Login Screen**
- Email & Password validation
- Password visibility toggle
- "Forgot Password" link
- Social login buttons (Google, Facebook)
- Navigation to Sign Up

**Sign Up Screen**
- Full name, email, password fields
- Confirm password validation
- Strong password requirements (8+ chars, uppercase, number)
- Terms & Conditions checkbox
- Social signup options
- Back to Login link

**Forgot Password Screen**
- Email validation
- Success state with instructions
- Resend email functionality
- Back to Login navigation

## 🎨 Design System

### Color Palette
- **Primary**: `#6C63FF` (Purple)
- **Accent**: `#FF6584` (Pink)
- **Background**: `#F8F9FA` (Light Gray)
- **Text Primary**: `#2D3436` (Dark Gray)
- **Text Secondary**: `#636E72` (Medium Gray)
- **Success**: `#00B894` (Green)
- **Error**: `#FF7675` (Red)

### Typography
- **Display Large**: 32px, Bold
- **Display Medium**: 28px, Bold
- **Body Large**: 16px, Regular
- **Body Medium**: 14px, Regular

### Spacing
- XS: 4px
- SM: 8px
- MD: 16px
- LG: 24px
- XL: 32px
- XXL: 48px

## 🏗️ Project Structure

```
lib/
├── core/
│   ├── constants/
│   │   ├── app_colors.dart      # Color constants
│   │   └── app_sizes.dart       # Spacing & sizing constants
│   └── theme/
│       └── app_theme.dart       # App-wide theme configuration
├── screens/
│   ├── onboarding/
│   │   └── onboarding_screen.dart
│   └── auth/
│       ├── login_screen.dart
│       ├── signup_screen.dart
│       └── forgot_password_screen.dart
├── widgets/                     # Reusable widgets (future)
└── main.dart                    # App entry point
```

## 🚀 Getting Started

### Prerequisites
- Flutter SDK 3.9.0 or higher
- Dart SDK
- Android Studio / VS Code
- iOS Simulator / Android Emulator (or physical device)

### Installation

1. **Navigate to project directory**
   ```bash
   cd /Users/mac/AndroidStudioProjects/ecommerceapp
   ```

2. **Install dependencies**
   ```bash
   flutter pub get
   ```

3. **Check for issues**
   ```bash
   flutter analyze
   ```

4. **Run the app**
   ```bash
   flutter run
   ```

### Dependencies

```yaml
dependencies:
  flutter:
    sdk: flutter
  cupertino_icons: ^1.0.8
  smooth_page_indicator: ^1.2.0+1  # For onboarding page indicators
  shared_preferences: ^2.2.3        # For storing onboarding status
```

## 📱 How to Test

### First Launch Flow
1. **Splash Screen** → Shows for 2 seconds
2. **Onboarding** → 3 slides with smooth navigation
3. **Login Screen** → After completing onboarding

### Test Onboarding Again
To reset and see onboarding again, clear app data:
```bash
flutter run --clear-cache
# Or uninstall and reinstall the app
```

### Test Login Screen
- Try invalid email format
- Try password < 6 characters
- Click "Forgot Password"
- Click "Sign Up"

### Test Sign Up Screen
- Try name < 3 characters
- Try weak password (no uppercase/number)
- Try mismatched passwords
- Toggle password visibility
- Test Terms & Conditions checkbox

### Test Forgot Password
- Enter email and submit
- See success screen
- Test "Resend Email" button

## 🎯 Validation Rules

### Email
- Required field
- Must match email format: `user@example.com`

### Password (Login)
- Required field
- Minimum 6 characters

### Password (Sign Up)
- Required field
- Minimum 8 characters
- Must contain at least one uppercase letter
- Must contain at least one number

### Name (Sign Up)
- Required field
- Minimum 3 characters

## 🔄 Navigation Flow

```
Splash Screen
    ↓
Onboarding (first time) / Login (returning user)
    ↓
Login Screen
    ├→ Sign Up Screen
    │      └→ Back to Login
    └→ Forgot Password Screen
           └→ Back to Login
```

## 🎨 UI/UX Principles Followed

1. **Consistency**: Same color scheme, typography, and spacing across all screens
2. **Clarity**: Clear labels, helpful error messages, and intuitive navigation
3. **Feedback**: Loading states, success/error messages, and visual feedback
4. **Accessibility**: Proper contrast ratios, readable font sizes
5. **Efficiency**: Minimal steps to complete tasks, smart defaults
6. **Aesthetics**: Clean, modern design with appropriate use of whitespace

## 🛠️ Next Steps / Future Enhancements

- [ ] Add home screen with product grid
- [ ] Implement product detail screen
- [ ] Add shopping cart functionality
- [ ] Implement user profile screen
- [ ] Add search and filter features
- [ ] Integrate with backend API
- [ ] Add Firebase authentication
- [ ] Implement payment gateway
- [ ] Add order tracking
- [ ] Push notifications

## 📝 Code Quality

- ✅ Follows Flutter best practices
- ✅ Stateless/Stateful widgets used appropriately
- ✅ Proper disposal of controllers
- ✅ Form validation on all inputs
- ✅ Null safety enabled
- ✅ Clean, maintainable code structure
- ✅ Reusable theme system

## 🐛 Troubleshooting

### Issue: "Package not found"
```bash
flutter clean
flutter pub get
```

### Issue: "Build failed"
```bash
flutter doctor
# Fix any issues shown
```

### Issue: "Hot reload not working"
```bash
# Stop the app and restart
flutter run
```

## 📄 License

This project is created for educational and demonstration purposes.

## 👨‍💻 Developer Notes

- All screens use the centralized theme from `app_theme.dart`
- Colors are defined in `app_colors.dart`
- Spacing uses constants from `app_sizes.dart`
- Form validation is comprehensive and user-friendly
- Navigation uses Material page routes
- SharedPreferences tracks onboarding completion

---

**Built with ❤️ using Flutter**
