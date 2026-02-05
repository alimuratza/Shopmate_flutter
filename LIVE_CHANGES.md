# 🎯 LIVE CHANGES PRACTICE - Teacher Demo Scenarios

## What This Is:
Your teacher will ask you to make changes LIVE during the demo.
This document prepares you for the 15 MOST COMMON requests.

**Practice each scenario 3 times until you can do it WITHOUT looking!**

---

## ⚡ SCENARIO 1: Add a New Button (30 seconds)

**Teacher Says:**
> "Add a button on the home screen that says 'View Offers' and shows a toast"

**What You Do:**

1. Open `lib/screens/home/home_screen.dart`
2. Find the `body:` section with other buttons
3. Add this code:

```dart
ElevatedButton(
  onPressed: () {
    showToast(context, 'Offers coming soon!');
  },
  child: Text('View Offers'),
)
```

4. Save (Cmd+S) → Hot Reload (r)

**What You Say While Doing It:**
> "I'm adding an ElevatedButton with an onPressed handler that calls the toast helper to show a message"

**Practice 3 times - Time yourself!**

---

## 🎨 SCENARIO 2: Change App Bar Color (15 seconds)

**Teacher Says:**
> "Change all app bars to red color"

**What You Do:**

1. Open `lib/core/theme/app_theme.dart`
2. Find `appBarTheme:`
3. Change:

```dart
backgroundColor: Colors.red,  // was Colors.blue or primary
```

4. Save → Hot Reload

**What You Say:**
> "I'm modifying the global app theme so all app bars use the same color throughout the app"

---

## 📱 SCENARIO 3: Create New Screen (60 seconds)

**Teacher Says:**
> "Create a 'Help' screen with a button to navigate to it from home"

**What You Do:**

**Step 1:** Create file `lib/screens/help/help_screen.dart`

```dart
import 'package:flutter/material.dart';

class HelpScreen extends StatelessWidget {
  const HelpScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Help & Support'),
      ),
      body: Center(
        child: Text('Help content will go here'),
      ),
    );
  }
}
```

**Step 2:** Open `lib/screens/home/home_screen.dart`

Add import:
```dart
import '../help/help_screen.dart';
```

Add button:
```dart
ElevatedButton(
  onPressed: () {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => HelpScreen()),
    );
  },
  child: Text('Help'),
)
```

**What You Say:**
> "Creating a new screen following the StatelessWidget pattern, then adding navigation using Navigator.push"

---

## 📝 SCENARIO 4: Change Text/String (10 seconds)

**Teacher Says:**
> "Change the home screen title to 'My Shop'"

**What You Do:**

1. Open `lib/screens/home/home_screen.dart`
2. Find `AppBar` section
3. Change:

```dart
title: Text('My Shop'),  // was 'E-Commerce' or 'Home'
```

4. Save → Hot Reload

**What You Say:**
> "Just updating the AppBar title text"

---

## ⏰ SCENARIO 5: Change Toast Duration (10 seconds)

**Teacher Says:**
> "Make toast messages stay for 5 seconds instead"

**What You Do:**

1. Open `lib/core/utils/toast_helper.dart`
2. Find `duration:`
3. Change:

```dart
duration: const Duration(seconds: 5),  // was 2
```

**What You Say:**
> "Modifying the toast helper utility to change display duration"

---

## 🎨 SCENARIO 6: Change Button Color (20 seconds)

**Teacher Says:**
> "Make the 'Add to Cart' button green"

**What You Do:**

Find the button and wrap it with color:

```dart
ElevatedButton(
  style: ElevatedButton.styleFrom(
    backgroundColor: Colors.green,
  ),
  onPressed: () {
    showToast(context, 'Added to cart!');
  },
  child: Text('Add to Cart'),
)
```

**What You Say:**
> "Using ElevatedButton.styleFrom to customize the button's background color"

---

## 🔍 SCENARIO 7: Add Icon to Button (20 seconds)

**Teacher Says:**
> "Add a cart icon to the 'View Cart' button"

**What You Do:**

Change from:
```dart
child: Text('View Cart'),
```

To:
```dart
child: Row(
  mainAxisSize: MainAxisSize.min,
  children: [
    Icon(Icons.shopping_cart),
    SizedBox(width: 8),
    Text('View Cart'),
  ],
),
```

**What You Say:**
> "Using a Row to place icon and text side by side, with SizedBox for spacing"

---

## 📏 SCENARIO 8: Add Padding (15 seconds)

**Teacher Says:**
> "Add more space around the cart items"

**What You Do:**

Wrap content with Padding:

```dart
body: Padding(
  padding: EdgeInsets.all(16),  // or 20, 24
  child: // existing content
)
```

**What You Say:**
> "Adding EdgeInsets padding to create space around the content"

---

## 🎯 SCENARIO 9: Add Icon to AppBar (15 seconds)

**Teacher Says:**
> "Add a settings icon to the app bar that shows a toast when clicked"

**What You Do:**

In AppBar, add:

```dart
actions: [
  IconButton(
    icon: Icon(Icons.settings),
    onPressed: () {
      showToast(context, 'Settings clicked');
    },
  ),
],
```

**What You Say:**
> "Adding an IconButton to the AppBar actions to show settings icon"

---

## 📊 SCENARIO 10: Change to ListView (30 seconds)

**Teacher Says:**
> "Change the Column to a scrollable ListView"

**What You Do:**

Change from:
```dart
body: Column(
  children: [
    Widget1(),
    Widget2(),
  ],
)
```

To:
```dart
body: ListView(
  children: [
    Widget1(),
    Widget2(),
  ],
)
```

**What You Say:**
> "Converting Column to ListView to make the content scrollable"

---

## 🖼️ SCENARIO 11: Add Divider (10 seconds)

**Teacher Says:**
> "Add a line separator between the items"

**What You Do:**

Add between widgets:
```dart
Divider(thickness: 1, color: Colors.grey),
```

Or for ListTile:
```dart
ListTile(
  title: Text('Item'),
  subtitle: Divider(),
)
```

---

## 🎨 SCENARIO 12: Change Background Color (15 seconds)

**Teacher Says:**
> "Make the screen background light grey"

**What You Do:**

In Scaffold:
```dart
Scaffold(
  backgroundColor: Colors.grey[200],  // or Colors.grey.shade200
  // rest of code
)
```

---

## 🔤 SCENARIO 13: Change Font Size (15 seconds)

**Teacher Says:**
> "Make the product title text bigger"

**What You Do:**

```dart
Text(
  'Product Name',
  style: TextStyle(
    fontSize: 24,  // was 16 or 18
    fontWeight: FontWeight.bold,
  ),
)
```

---

## ⏳ SCENARIO 14: Add Loading Indicator (20 seconds)

**Teacher Says:**
> "Show a loading spinner when the button is clicked"

**What You Do:**

Quick version - show in center:
```dart
body: Center(
  child: CircularProgressIndicator(),
)
```

Or conditional:
```dart
isLoading 
  ? CircularProgressIndicator() 
  : Text('Content')
```

---

## 🔄 SCENARIO 15: Change Navigation to Pop (10 seconds)

**Teacher Says:**
> "Make the cancel button go back to previous screen"

**What You Do:**

```dart
TextButton(
  onPressed: () {
    Navigator.pop(context);  // Go back
  },
  child: Text('Cancel'),
)
```

**What You Say:**
> "Using Navigator.pop to go back to the previous screen"

---

## 🏃 SPEED CHALLENGE

**Practice Mode:**
1. Pick 5 random scenarios
2. Set timer for 5 minutes
3. Complete all 5 changes
4. Hot reload and verify each works

**Goal:** All 5 changes in under 5 minutes!

---

## 💬 WHAT TO SAY DURING DEMO

**When teacher asks you to do something:**

✅ **GOOD responses:**
- "I'll add that using [widget name]"
- "Let me modify the [file name] for that"
- "I can use [pattern name] to achieve that"
- "This will take about [X] seconds"

❌ **BAD responses:**
- "I don't know how"
- "The AI did that part"
- "I forgot"
- Long silence

**Be CONFIDENT and EXPLAIN while typing!**

---

## 📝 PRACTICE TRACKER

Track your practice here:

```
Scenario 1 (Add Button):        □ □ □ (Practice 3x)
Scenario 2 (Change Color):      □ □ □
Scenario 3 (New Screen):        □ □ □
Scenario 4 (Change Text):       □ □ □
Scenario 5 (Toast Duration):    □ □ □
Scenario 6 (Button Color):      □ □ □
Scenario 7 (Add Icon):          □ □ □
Scenario 8 (Add Padding):       □ □ □
Scenario 9 (AppBar Icon):       □ □ □
Scenario 10 (ListView):         □ □ □
Scenario 11 (Divider):          □ □ □
Scenario 12 (Background):       □ □ □
Scenario 13 (Font Size):        □ □ □
Scenario 14 (Loading):          □ □ □
Scenario 15 (Pop):              □ □ □
```

**When all boxes checked = You're READY! 🎉**

---

## 🎯 EXAM DAY STRATEGY

1. **Listen carefully** to what teacher asks
2. **Repeat it back**: "You want me to add a button that..."
3. **Say what you'll do**: "I'll open home_screen and add..."
4. **Code while explaining**: "I'm using ElevatedButton with..."
5. **Test it**: "Let me hot reload to show it works"

**CONFIDENCE = MARKS!**

