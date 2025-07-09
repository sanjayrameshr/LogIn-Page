# Flutter Firebase Authentication App

A clean and simple Flutter application that implements user authentication using Firebase. It supports user login, registration, and navigation to a home screen after successful authentication.

---

## Features

- Login with email and password
- Register new user accounts
- Firebase Authentication integration
- Home screen after successful login
- Modular code structure using separate files for screens, constants, and colors

---

## Project Structure
```bash
lib/
├── main.dart # Application entry point and routing
├── login_screen.dart # Login UI and authentication logic
├── register_screen.dart # Registration UI and logic
├── homescreen.dart # Home screen after successful login
├── constants.dart # Reusable constants
└── colors.dart # App color definitions
```
---

### Prerequisites

- Flutter SDK installed
- A Firebase project set up in [Firebase Console](https://console.firebase.google.com/)
- `google-services.json` file downloaded from Firebase and placed in `android/app`

---

## Firebase Setup

1. Go to [Firebase Console](https://console.firebase.google.com/)
2. Create a new project or use an existing one
3. Enable **Email/Password** authentication under Authentication > Sign-in Method
4. Download the `google-services.json` file and add it to your Flutter project under `android/app`
5. Add the necessary dependencies to your `pubspec.yaml` and follow [Firebase setup for Flutter](https://firebase.flutter.dev/docs/overview)

---

## How to Run

1. Clone the repository:
   ```bash
   git clone https://github.com/yourusername/flutter-firebase-auth.git
   cd flutter-firebase-auth
   ```
---

## Install dependencies:

```bash 
flutter pub get
```
---

## Run the app:
```bash
flutter run
``` 
---

## Screens Overview
Login Screen -- User can enter email and password to log in
Register Screen -- Allows new users to create an account
Home Screen -- Landing page shown after successful login

---

## Author
**Sanjay R**
GitHub: sanjayrameshr
LinkedIn: linkedin.com/in/sanjayrameshr