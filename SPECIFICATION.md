# PulseGym: App Specification & Refinement

## Core Concept
A streamlined fitness companion for everyday users focused on clear guidance and tracking.

## Visual Style

### Color Palette
- **Primary**: Navy Blue - Headers, Primary Buttons, Active Icons
- **Secondary**: Pastel Blue - Background accents, Progress bars, Secondary cards
- **Base**: White - Main background, Input fields
- **Text**: Dark Slate Grey - Body text for readability against white

---

## 1. User Flow & Onboarding

### Refined Flow Structure
The onboarding follows a sequential "Questionnaire" style to reduce friction and improve user experience.

**Flow**: Splash → Sign Up/Login → Onboarding Questionnaire → Home

### Sign Up / Login
- **Simple entry** with Email/Phone & Password
- **Design Reference**: Clean white page with Navy Blue "Continue" buttons
- **Tech Implementation**: Email/password validation with secure storage

### Onboarding Questionnaire (Data Collection)
Instead of a single long form, use a multi-step wizard to reduce friction:

#### Step 1: Gender Selection
- **UI**: Male/Female buttons
- **Design File**: 4.1 - A - Gender.png
- **Data**: String ("Male"/"Female")

#### Step 2: Age Input
- **UI**: Slider selector
- **Design File**: 4.2 - A - How old.png
- **Data**: Integer (18-100)

#### Step 3: Weight Input
- **UI**: Vertical slider
- **Design File**: 4.3 - Weight.png
- **Data**: Real number (in kg or lbs)

#### Step 4: Height Input
- **UI**: Horizontal slider
- **Design File**: 4.4 - Height.png
- **Data**: Real number (in cm or feet/inches)

#### Step 5: Goal Selection
- **UI**: Cards for different goals
- **Options**: "Lose Weight", "Gain Weight", "Build Muscle", "Stay Fit"
- **Design File**: 4.5 - A - Goal.png
- **Data**: String

#### Step 6: Activity Level
- **UI**: Selection cards
- **Options**: "Beginner", "Intermediate", "Advanced"
- **Design File**: 4.6 - A - Physical activity level.png
- **Data**: String

### Technical Storage
- Store all inputs locally in SQLite `user` table upon completion
- Validate each input before allowing progression to next step
- Allow users to go back and edit previous answers

---

## 2. Home Dashboard

### Purpose
Central hub for quick access to all major features.

### Layout
**Header**:
- Greeting: "Hi, [Name]"
- Motivational subtext: "It's time to challenge your limits"

**Main Sections** (Grid/List View):
1. **Workout**: Direct link to exercise lists
2. **Nutrition**: Direct link to meal plans
3. **Progress Tracking**: Quick view of user stats
4. **Community/Offers**: Space for Gym Offers or community tips

### Design Reference
- **File**: 5 - A - Home.png
- **Layout**: Clean layout with search bar at top and category tiles below

### Navigation
- Bottom navigation bar or hamburger menu
- Quick access tiles for each major feature
- Search functionality for exercises and meals

---

## 3. Workout Tutorials (Core Feature)

### Organization
Exercises are organized by difficulty level for intuitive navigation.

### Categories Screen
**Tabs**:
- Beginner
- Intermediate
- Advanced

**Design File**: 7.1.1.1 - A - Beginner.png

### Exercise List
Each routine lists specific exercises with:
- **Exercise name** (e.g., "Dumbbell Rows")
- **Duration** (e.g., "00:30")
- **Difficulty indicator**
- **Thumbnail image**

### Video Player
**Features**:
- Simple video player interface
- "Save" bookmark icon for favorites
- Basic description text
- Play/pause controls
- Progress indicator

**Design File**: 11.2 - C - Workout Videos.png

### Exercise Details
- **Name**: Exercise title
- **Duration**: Time or reps
- **Instructions**: Step-by-step text guide
- **Video**: Demonstration video
- **Equipment**: Required equipment (if any)
- **Muscle Groups**: Target areas

### Data Structure
```
Workout Routine:
  - ID
  - Name
  - Difficulty Level
  - Duration (total)
  - Exercise List:
    - Exercise ID
    - Name
    - Duration
    - Video URL/Path
    - Instructions
    - Equipment
    - Muscle Groups
```

---

## 4. Meal Plans & Nutrition

### Purpose
Provide users with personalized nutrition guidance without complex calorie counting.

### Preferences Setup (Optional)
Users can customize their meal plan experience:

**Dietary Preferences**:
- Vegan
- Vegetarian
- Keto
- Paleo
- No restrictions

**Caloric Goal**:
- Weight loss
- Maintenance
- Muscle gain

**Design File**: 7.3.1 -B - Meal Plans.png

### Daily Meal View
**Tabs**:
- Breakfast
- Lunch
- Dinner

**Card Display** (for each meal):
- Meal image
- Meal name
- Time to cook
- Calorie count

**Design File**: 7.3.2.1 - B - Meal Plans - Breakfast.png

### Recipe Detail View
**Sections**:
1. **Header**:
   - Meal image
   - Meal name
   - Prep time
   - Cook time
   - Servings
   - Calories per serving

2. **Ingredients List**:
   - Bullet points
   - Quantities
   - Item names

3. **Preparation Steps**:
   - Numbered steps
   - Clear instructions
   - Optional: Step images

4. **Nutritional Information**:
   - Calories
   - Protein
   - Carbs
   - Fat
   - Fiber

### Data Structure
```
Meal:
  - ID
  - Name
  - Meal Type (Breakfast/Lunch/Dinner)
  - Prep Time
  - Cook Time
  - Servings
  - Calories
  - Image URL/Path
  - Ingredients List:
    - Ingredient name
    - Quantity
    - Unit
  - Instructions (text)
  - Nutritional Info:
    - Protein
    - Carbs
    - Fat
    - Fiber
  - Dietary Tags (Vegan, Keto, etc.)
```

### Technical Implementation
- Store recipes as **hardcoded lists** (JSON or clear code structure) to avoid server costs
- Filter by dietary preferences
- Allow users to "favorite" meals for quick access

---

## 5. Profile & Settings

### Purpose
User management, preferences, and account adjustments.

### Profile View
**Display**:
- Profile photo (optional)
- User name
- Statistics:
  - Weight
  - Age
  - Height
  - Goal
  - Activity level
- "Edit Profile" button

**Settings Options**:
- Privacy Policy
- App Settings
- Notification Preferences
- Account Management
- Logout

**Design File**: 6.1 - A - Profile.png

### Edit Mode
**Editable Fields**:
- Name
- Profile photo
- Weight (with date tracking)
- Goal
- Activity level
- Dietary preferences

**Data Updates**:
- Save changes to SQLite database
- Validate inputs
- Show confirmation message

---

## 6. Notifications (Local & Push)

### Purpose
Keep users engaged and remind them of their fitness goals.

### Workout Reminders
**Examples**:
- "New Workout Is Available"
- "Time for your daily workout!"
- "Don't Forget To Drink Water"

**Design File**: 6.2.1 - A - Notification - Workout Reminders.png

### Gym Offers & System Messages
**Examples**:
- "You Have A New Message!"
- "Membership Discount Available"
- "Weekly Progress Summary"

**Design File**: 6.2.2 - A - Notification - Workout System.png

### Technical Implementation
- **Library**: Flutter Local Notifications
- **Triggers**: User-set timers, specific times of day
- **Permissions**: Request notification permissions on first launch
- **Customization**: Users can enable/disable specific notification types

---

## Refined Technical Data Structure (SQLite)

### Table: User
```sql
CREATE TABLE user (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  name TEXT NOT NULL,
  email TEXT UNIQUE NOT NULL,
  password_hash TEXT NOT NULL,
  gender TEXT,
  age INTEGER,
  weight REAL,
  height REAL,
  activity_level TEXT,
  goal TEXT,
  dietary_preferences TEXT,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
```

### Table: Reminders
```sql
CREATE TABLE reminders (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  user_id INTEGER,
  time TEXT NOT NULL,
  is_active BOOLEAN DEFAULT 1,
  reminder_type TEXT,
  message TEXT,
  FOREIGN KEY (user_id) REFERENCES user(id)
);
```

### Table: Favorites (Optional)
```sql
CREATE TABLE favorites (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  user_id INTEGER,
  item_type TEXT, -- 'workout' or 'meal'
  item_id TEXT,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (user_id) REFERENCES user(id)
);
```

### Table: Progress (Optional)
```sql
CREATE TABLE progress (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  user_id INTEGER,
  date DATE NOT NULL,
  weight REAL,
  notes TEXT,
  FOREIGN KEY (user_id) REFERENCES user(id)
);
```

### Note on Hardcoded Data
**Meal Plans and Workout Links** remain hardcoded lists in the application code for simplicity, as originally planned. This reduces infrastructure costs and complexity while maintaining full functionality.

**Implementation Approach**:
- Create JSON files or Dart constants with meal and workout data
- Load data into memory on app startup
- Filter and search through data locally
- No backend server required for initial release

---

## Development Priorities

### Phase 1: Core Functionality
1. ✅ User authentication (sign up/login)
2. ✅ Onboarding questionnaire
3. ✅ Home dashboard
4. ✅ Workout library (hardcoded)
5. ✅ Basic video player
6. ✅ Meal plans (hardcoded)
7. ✅ Profile management

### Phase 2: Enhanced Features
1. ⏳ Progress tracking
2. ⏳ Favorites system
3. ⏳ Search functionality
4. ⏳ Local notifications
5. ⏳ Weight tracking over time

### Phase 3: Polish & Optimization
1. ⏳ Offline mode
2. ⏳ Performance optimization
3. ⏳ Advanced animations
4. ⏳ Social features (optional)
5. ⏳ Integration with wearables (optional)

---

## Technical Requirements

### Minimum Flutter Version
- Flutter 3.0+
- Dart 3.0+

### Key Dependencies
- `sqflite` - SQLite database
- `flutter_local_notifications` - Local notifications
- `video_player` - Video playback
- `shared_preferences` - Simple data persistence
- `provider` or `riverpod` - State management

### Platform Support
- Android 5.0+ (API level 21+)
- iOS 12.0+

---

## Design Consistency Guidelines

### Typography
- **Headers**: Bold, Navy Blue, 24-28px
- **Subheaders**: Semi-bold, Dark Slate Grey, 18-20px
- **Body Text**: Regular, Dark Slate Grey, 14-16px
- **Buttons**: Semi-bold, White on Navy Blue, 16px

### Spacing
- **Padding**: 16px standard, 24px for sections
- **Margins**: 8px between related items, 16px between sections
- **Border Radius**: 8px for cards, 12px for buttons

### Interaction Patterns
- **Buttons**: Press animation with scale effect
- **Cards**: Subtle shadow, tap to navigate
- **Sliders**: Smooth animation, real-time value display
- **Transitions**: Fade or slide animations, 200-300ms duration

---

**Last Updated**: November 26, 2025
