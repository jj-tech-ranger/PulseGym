# PulseGym 💪

A streamlined fitness companion app focused on clear guidance and tracking. Built with Flutter for cross-platform support, PulseGym helps users achieve their fitness goals through personalized workout plans, nutrition guidance, and progress tracking.

## 📋 Overview

PulseGym is designed for everyday fitness enthusiasts who want a simple, effective way to track their fitness journey. The app combines workout tutorials, meal planning, and progress tracking in one intuitive interface.

## ✨ Key Features

### 🏋️ Workout Tutorials
- **Difficulty-based categorization**: Beginner, Intermediate, and Advanced levels
- **Video demonstrations**: Clear exercise guidance with visual references
- **Structured routines**: Pre-designed workout programs for different goals
- **Exercise library**: Comprehensive collection of exercises with timing and instructions

### 🥗 Nutrition & Meal Planning
- **Personalized meal plans**: Based on user goals and dietary preferences
- **Dietary filters**: Support for Vegan, Keto, and other dietary preferences
- **Daily meal structure**: Organized breakfast, lunch, and dinner plans
- **Recipe details**: Ingredients lists, preparation instructions, and nutritional info
- **Calorie tracking**: Monitor daily caloric intake

### 📊 Progress Tracking
- **Personal statistics**: Track weight, measurements, and fitness milestones
- **Goal setting**: Set and monitor fitness objectives
- **Activity monitoring**: Keep tabs on workout frequency and consistency

### 👤 User Profile & Personalization
- **Customizable profile**: Store personal fitness data
- **Goal-oriented onboarding**: Tailored experience based on fitness objectives
- **Activity level assessment**: Workouts matched to user experience level

### 🔔 Smart Notifications
- **Workout reminders**: Stay consistent with scheduled notifications
- **Hydration alerts**: Reminders to stay hydrated
- **Gym offers**: Special deals and membership notifications

## 🎨 Design System

### Color Palette
- **Primary**: Navy Blue (#2C3E50) - Headers, primary buttons, active icons
- **Secondary**: Pastel Blue (#A8DADC) - Background accents, progress bars
- **Base**: White (#FFFFFF) - Main background, input fields
- **Text**: Dark Slate Grey (#2E4053) - Body text for optimal readability

### UI/UX Principles
- Clean, minimalist interface
- Intuitive navigation
- Visual hierarchy with clear typography
- Responsive design for all screen sizes

## 🛠️ Technical Stack

- **Framework**: Flutter (Dart)
- **Database**: SQLite for local data persistence
- **Notifications**: Flutter Local Notifications
- **Architecture**: Clean, modular code structure
- **State Management**: [To be determined based on implementation]

## 📱 App Structure

### Onboarding Flow
1. Splash Screen
2. Sign Up / Login
3. Multi-step Questionnaire:
   - Gender selection
   - Age input
   - Weight & Height
   - Fitness goals
   - Activity level

### Main Sections
1. **Home Dashboard**: Central hub with quick access to all features
2. **Workouts**: Browse and follow exercise routines
3. **Nutrition**: Meal planning and recipes
4. **Progress**: Track your fitness journey
5. **Profile**: Manage account and settings

## 📂 Repository Structure

```
PulseGym/
├── README.md                 # Project overview
├── SPECIFICATION.md          # Detailed app specification
├── USER_FLOW.md             # User journey documentation
├── DATABASE_SCHEMA.md       # SQLite database structure
├── DESIGN_SYSTEM.md         # UI/UX design guidelines
└── FEATURES.md              # Detailed feature descriptions
```

## 🚀 Getting Started

### Prerequisites
- Flutter SDK (latest stable version)
- Dart SDK
- Android Studio / VS Code with Flutter extensions
- iOS Simulator (for Mac) or Android Emulator

### Installation
```bash
# Clone the repository
git clone https://github.com/jj-tech-ranger/PulseGym.git

# Navigate to project directory
cd PulseGym

# Install dependencies
flutter pub get

# Run the app
flutter run
```

## 📖 Documentation

Detailed documentation for each aspect of the app can be found in the following files:

- **[SPECIFICATION.md](SPECIFICATION.md)**: Complete app specification with all features
- **[USER_FLOW.md](USER_FLOW.md)**: Detailed user journey and navigation flows
- **[DATABASE_SCHEMA.md](DATABASE_SCHEMA.md)**: SQLite database structure and relationships
- **[DESIGN_SYSTEM.md](DESIGN_SYSTEM.md)**: Color palette, typography, and UI components
- **[FEATURES.md](FEATURES.md)**: In-depth feature descriptions and requirements

## 🎯 Development Roadmap

### Phase 1: Core Features (Current)
- [ ] User authentication and onboarding
- [ ] Basic workout library
- [ ] Meal plan database
- [ ] Profile management

### Phase 2: Enhanced Features
- [ ] Progress tracking and analytics
- [ ] Custom workout creation
- [ ] Social features (optional)
- [ ] Integration with wearables

### Phase 3: Premium Features
- [ ] Advanced analytics
- [ ] AI-powered recommendations
- [ ] Video streaming optimization
- [ ] Offline mode enhancements

## 🤝 Contributing

Contributions are welcome! Please feel free to submit pull requests or open issues for bugs and feature requests.

## 📄 License

This project is currently unlicensed. All rights reserved.

## 📧 Contact

For questions or feedback, please open an issue in this repository.

---

**Built with ❤️ for the fitness community**
