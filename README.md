# Dynamic UI Widget Component Library

A Flutter application showcasing a comprehensive reusable UI component library with authentication, dark mode support, and interactive component demonstrations.

## Features

- **Splash Screen** – Animated splash with session check
- **Login Screen** – SharedPreferences session management with form validation
- **Dashboard** – Component overview with search functionality
- **Button Components** – 4 variants (Filled, Outlined, Text, Danger) with loading state, click counter, and code preview
- **Card Components** – Basic, Stat, Highlighted, Action card variants with interactive tap feedback
- **Graph Components** – Animated bar charts with dynamic period selector (Weekly/Monthly/Yearly)
- **Form Components** – Text fields with validation, toggles, radio buttons, sliders, and filter chips
- **Feedback Components** – Dialogs, bottom sheets, snackbars (Success/Error/Warning/Info), progress indicators, and step wizard
- **Display Components** – Avatars with status indicators, notification badges, dividers, and list tiles
- **Dark/Light Mode Toggle** – Theme preference saved locally
- **Logout** – Session clearing with confirmation dialog

## Tech Stack

- Flutter & Dart
- SharedPreferences (local session & theme)
- Provider (state management)
- Material Design 3
- Custom design system & theming

## Demo Credentials

| Username | Password  |
|----------|-----------|
| admin    | admin123  |

## Project Structure

lib/
├── main.dart
├── theme/app_theme.dart
├── services/
│   ├── auth_service.dart
│   └── theme_service.dart
├── screens/
│   ├── splash_screen.dart
│   ├── login_screen.dart
│   ├── dashboard_screen.dart
│   └── components/
│       ├── button_showcase.dart
│       ├── card_showcase.dart
│       ├── graph_showcase.dart
│       ├── form_showcase.dart
│       ├── feedback_showcase.dart
│       └── display_showcase.dart
└── widgets/
├── custom_button.dart
├── custom_text_field.dart
├── info_card.dart
└── bar_chart_widget.dart

## Getting Started

```bash
git clone https://github.com/bethaniapermai/flutter_widget_library
cd flutter_widget_library
flutter pub get
flutter run
```

## Author

**Bethania Permai Simangunsong**  
D4 Software Engineering Technology — Institut Teknologi Del  
[github.com/bethaniapermai](https://github.com/bethaniapermai)