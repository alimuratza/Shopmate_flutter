# 🎓 EXAM PRACTICE - Code Removal & Fix Scenarios

## How to Use This Guide
Your teacher will REMOVE code and ask you to FIX it on the spot. Practice these scenarios until you can fix them in **under 30 seconds** each!

---

## 📝 SCENARIO 1: Missing Import Statement

**What Teacher Removes:**
```dart
// Deletes this line from ANY screen file
import 'package:flutter/material.dart';
```

**Error You'll See:**
```
Undefined class: 'StatelessWidget'
Undefined class: 'Widget'
```

**How to Fix (5 seconds):**
1. Go to TOP of the file
2. Add this EXACT line:
```dart
import 'package:flutter/material.dart';

```
3. Save → Hot reload (press `r`)

**Practice:** Open any screen file, delete the import, then add it back!

---

## 📝 SCENARIO 2: Missing Toast Helper Import

**What Teacher Removes:**
```dart
import '../../core/utils/toast_helper.dart';
```

**Error You'll See:**
```
Undefined name: 'showToast'
```

**How to Fix (10 seconds):**
1. Count folders: If file is in `lib/screens/cart/cart_screen.dart`:
   - Need to go UP 2 levels: `../../`
2. Add:
```dart
import '../../core/utils/toast_helper.dart';
```

**Quick Reference:**
- From `screens/X/` → Use `../../core/utils/toast_helper.dart`
- From `screens/` → Use `../core/utils/toast_helper.dart`

---

## 📝 SCENARIO 3: Deleted onPressed Handler

**What Teacher Removes:**
```dart
ElevatedButton(
  onPressed: null,  // Teacher deletes the function
  child: Text('Click Me'),
)
```

**Error You'll See:**
```
Button doesn't work / does nothing
```

**How to Fix (15 seconds):**
Replace `null` with:
```dart
onPressed: () {
  showToast(context, 'Button clicked!');
},
```

**Full Example:**
```dart
ElevatedButton(
  onPressed: () {
    showToast(context, 'Button clicked!');
  },
  child: Text('Click Me'),
)
```

---

## 📝 SCENARIO 4: Deleted Navigation Route

**What Teacher Removes:**
```dart
// Teacher deletes the Navigator.push code
Navigator.push(
  context,
  MaterialPageRoute(builder: (_) => CartScreen()),
);
```

**Error You'll See:**
```
Button does nothing / Navigation broken
```

**How to Fix (20 seconds):**
1. Remember the pattern:
```dart
Navigator.push(
  context,
  MaterialPageRoute(builder: (_) => ScreenName()),
);
```

2. Replace `ScreenName` with actual screen (e.g., `CartScreen()`)

**Example - Fix Cart Button:**
```dart
onPressed: () {
  Navigator.push(
    context,
    MaterialPageRoute(builder: (_) => CartScreen()),
  );
},
```

---

## 📝 SCENARIO 5: Missing Screen Import

**What Teacher Removes:**
```dart
import '../cart/cart_screen.dart';
```

**Error You'll See:**
```
Undefined class: 'CartScreen'
```

**How to Fix (15 seconds):**
1. Find where the screen file is
2. Add import with correct path:
```dart
import '../cart/cart_screen.dart';  // Same level folder
import '../../cart/cart_screen.dart';  // Up one, then down
```

**Path Rules:**
- `../` = go UP one folder
- `../../` = go UP two folders
- Then add the path to the file

---

## 📝 SCENARIO 6: Deleted Scaffold

**What Teacher Removes:**
```dart
// Teacher deletes entire Scaffold wrapper
return Scaffold(
  appBar: AppBar(title: Text('Title')),
  body: Center(child: Text('Content')),
);
```

**Error You'll See:**
```
Must have Scaffold in MaterialApp
```

**How to Fix (25 seconds):**
Wrap your content in Scaffold:
```dart
@override
Widget build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(
      title: Text('Title Here'),
    ),
    body: Center(
      child: Text('Your content'),
    ),
  );
}
```

**Remember:** Every screen MUST return a Scaffold!

---

## 📝 SCENARIO 7: Deleted const Constructor

**What Teacher Removes:**
```dart
const HomeScreen({super.key});  // Removes 'const'
```

**Warning You'll See:**
```
Prefer const constructors
```

**How to Fix (5 seconds):**
Add `const` keyword:
```dart
const HomeScreen({super.key});
```

---

## 📝 SCENARIO 8: Deleted AppBar

**What Teacher Removes:**
```dart
appBar: AppBar(title: Text('Title')),
```

**Error You'll See:**
```
Screen has no title bar
```

**How to Fix (10 seconds):**
Add AppBar to Scaffold:
```dart
Scaffold(
  appBar: AppBar(
    title: Text('Screen Name'),
  ),
  body: // your content
)
```

---

## 📝 SCENARIO 9: Missing Toast Helper File

**What Teacher Removes:**
```bash
# Deletes entire file: lib/core/utils/toast_helper.dart
```

**Error You'll See:**
```
Error: Cannot find module 'toast_helper.dart'
```

**How to Fix (30 seconds):**
Recreate the file:
```dart
// lib/core/utils/toast_helper.dart
import 'package:flutter/material.dart';

void showToast(BuildContext context, String message, {bool isError = false}) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(message),
      backgroundColor: isError ? Colors.red : Colors.green,
      duration: const Duration(seconds: 2),
    ),
  );
}
```

---

## 📝 SCENARIO 10: Deleted Build Method

**What Teacher Removes:**
```dart
@override
Widget build(BuildContext context) {
  return Scaffold(...);
}
```

**Error You'll See:**
```
Missing concrete implementation of 'Widget.build'
```

**How to Fix (20 seconds):**
Add build method back:
```dart
@override
Widget build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(title: Text('Title')),
    body: Center(child: Text('Content')),
  );
}
```

---

## 📝 SCENARIO 11: Deleted BottomNavigationBar

**What Teacher Removes:**
```dart
bottomNavigationBar: BottomNavigationBar(...),
```

**Error You'll See:**
```
No bottom navigation visible
```

**How to Fix (30 seconds):**
```dart
Scaffold(
  body: // content,
  bottomNavigationBar: BottomNavigationBar(
    currentIndex: 0,
    items: [
      BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
      BottomNavigationBarItem(icon: Icon(Icons.shopping_cart), label: 'Cart'),
    ],
  ),
)
```

---

## 📝 SCENARIO 12: Missing StatefulWidget State

**What Teacher Removes:**
```dart
State<HomeScreen> createState() => _HomeScreenState();
```

**Error You'll See:**
```
Missing createState override
```

**How to Fix (15 seconds):**
```dart
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}
```

**Pattern:** `State<ClassName> createState() => _ClassNameState();`

---

## 📝 SCENARIO 13: Deleted ListView/GridView

**What Teacher Removes:**
```dart
ListView(children: [...])
```

**Error You'll See:**
```
Content not scrolling / layout issues
```

**How to Fix (20 seconds):**
Wrap content in ListView:
```dart
body: ListView(
  padding: EdgeInsets.all(16),
  children: [
    // your widgets here
  ],
)
```

---

## 📝 SCENARIO 14: Missing AppStrings Import

**What Teacher Removes:**
```dart
import '../../core/constants/app_strings.dart';
```

**Error You'll See:**
```
Undefined name: 'AppStrings'
```

**How to Fix (10 seconds):**
```dart
import '../../core/constants/app_strings.dart';
```

Then use: `AppStrings.home`, `AppStrings.cart`, etc.

---

## 📝 SCENARIO 15: Deleted IconButton

**What Teacher Removes:**
```dart
IconButton(
  icon: Icon(Icons.search),
  onPressed: () {},
)
```

**How to Fix (15 seconds):**
```dart
IconButton(
  icon: Icon(Icons.search),
  onPressed: () {
    showToast(context, 'Search clicked');
  },
)
```

---

## 🎯 QUICK CHEAT SHEET (Memorize This!)

### 1. Basic Screen Template
```dart
import 'package:flutter/material.dart';

class ScreenName extends StatelessWidget {
  const ScreenName({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Title')),
      body: Center(child: Text('Content')),
    );
  }
}
```

### 2. Navigation Template
```dart
Navigator.push(
  context,
  MaterialPageRoute(builder: (_) => NextScreen()),
);
```

### 3. Button Template
```dart
ElevatedButton(
  onPressed: () {
    showToast(context, 'Message');
  },
  child: Text('Button'),
)
```

### 4. Toast Template
```dart
showToast(context, 'Success!');
showToast(context, 'Error!', isError: true);
```

### 5. Import Paths
```dart
// Material (always needed)
import 'package:flutter/material.dart';

// Toast helper
import '../../core/utils/toast_helper.dart';

// Screens (adjust ../ based on folder depth)
import '../cart/cart_screen.dart';
```

---

## 🏃 SPEED PRACTICE DRILL

**Set a timer for 2 minutes and do this:**

1. Open `home_screen.dart`
2. Delete `import 'package:flutter/material.dart';`
3. Fix it
4. Delete a Navigator.push
5. Fix it
6. Delete showToast import
7. Fix it
8. Delete an onPressed handler
9. Fix it
10. Run the app - if it works, you're ready!

**Goal:** Fix all 4 deletions in under 2 minutes!

---

## 💡 TEACHER DEMO SURVIVAL TIPS

1. **Keep calm** - Errors are normal, you know how to fix them
2. **Read the error** - It tells you the line number!
3. **Check imports first** - 80% of errors are missing imports
4. **Use hot reload** (press `r`) - Don't restart the whole app
5. **Explain as you type** - "I'm adding the missing import because..."

### What to Say During Demo:
- ❌ "I don't know"
- ✅ "The error shows line 45, let me check the import"
- ✅ "This needs a Navigator.push to navigate to the next screen"
- ✅ "I'll add the onPressed handler to make the button work"

---

## 🎖️ CONFIDENCE BUILDER

**You know how to fix:**
- ✅ Missing imports (5 sec)
- ✅ Broken navigation (20 sec)
- ✅ Missing buttons (15 sec)
- ✅ Missing toast (30 sec to recreate file)
- ✅ Missing Scaffold (25 sec)
- ✅ Any common Flutter error!

**Practice these 15 scenarios 3 times each = You're READY! 🚀**

---

## 📞 Quick Help Reference

**Common Errors → Quick Fix:**
- `Undefined class 'Widget'` → Add `import 'package:flutter/material.dart';`
- `Undefined name 'showToast'` → Add toast_helper import
- `Undefined class 'CartScreen'` → Add screen import
- Button does nothing → Add `onPressed: () { }`
- Missing createState → Add `State<X> createState() => _XState();`

**You got this! 💪**
