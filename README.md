# Shopmate - E-Commerce Flutter App

A modern, cross-platform e-commerce application built with Flutter and Firebase.

## Overview

Shopmate is a full-featured shopping app designed for iOS, Android, and Web. It follows clean architecture principles with MVVM pattern and GetX for state management.

## Tech Stack

- **Framework:** Flutter 3.x
- **State Management:** GetX
- **Backend:** Firebase (Auth, Firestore, Storage, Hosting)
- **Architecture:** MVVM (Model-View-ViewModel)
- **Platforms:** iOS, Android, Web

## Features

### Core Functionality
- User authentication (Email, Google, Apple, Facebook)
- Product catalog with categories and filters
- Shopping cart and wishlist
- Secure checkout flow
- Order tracking and history
- User profile management

### UI/UX
- Material Design 3 components
- Responsive layouts for all screen sizes
- Custom animations and transitions
- Dark/Light theme support

### AI Integration
- Smart product recommendations
- AI-powered chatbot for customer support
- Visual search capability

## Project Structure

```
lib/
├── bindings/          # Dependency injection
├── core/              # Constants, themes, utilities
├── data/
│   ├── models/        # Data models
│   ├── repos/         # Repositories
│   └── services/      # API services
├── ui/
│   ├── auth/          # Authentication screens
│   ├── home/          # Home screen
│   ├── product/       # Product screens
│   ├── cart/          # Cart functionality
│   ├── profile/       # User profile
│   └── ...
└── widgets/           # Reusable components
```

## Setup

1. Clone the repository
```bash
git clone https://github.com/alimuratza/Shopmate_flutter.git
cd Shopmate_flutter
```

2. Install dependencies
```bash
flutter pub get
```

3. Configure Firebase
- Add your `google-services.json` (Android)
- Add your `GoogleService-Info.plist` (iOS)
- Update `firebase_options.dart`

4. Run the app
```bash
flutter run
```

## Build

```bash
# Android
flutter build apk --release

# iOS
flutter build ios --release

# Web
flutter build web --release
```

## Deployment

The web version is deployed on Firebase Hosting:
- **Live URL:** https://ali-ecommerce-1234.web.app

## Contributing

1. Fork the repository
2. Create your feature branch (`git checkout -b feature/new-feature`)
3. Commit your changes (`git commit -m 'Add new feature'`)
4. Push to the branch (`git push origin feature/new-feature`)
5. Open a Pull Request

## License

This project is licensed under the MIT License.

## Contact

**Ali Muratza**  
GitHub: [@alimuratza](https://github.com/alimuratza)
