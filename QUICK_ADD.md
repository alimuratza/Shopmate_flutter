# ⚡ QUICK ADD TEMPLATES - Copy & Paste Ready

## What This Is:
Templates you can quickly copy-paste when teacher asks for common additions.
**Bookmark this file - you'll need it during the exam!**

---

## 📱 NEW SCREEN TEMPLATE (30 seconds)

When teacher says: **"Create a new [X] screen"**

**Copy this entire template:**

```dart
import 'package:flutter/material.dart';
import '../../core/utils/toast_helper.dart';

// TODO: Change ScreenName to actual name (e.g., HelpScreen, AboutScreen)
class ScreenNameHere extends StatelessWidget {
  const ScreenNameHere({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Screen Title Here'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Content goes here'),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                showToast(context, 'Button clicked!');
              },
              child: Text('Action Button'),
            ),
          ],
        ),
      ),
    );
  }
}
```

**Then add navigation from another screen:**

```dart
// Add import at top
import '../foldername/screen_name_here.dart';

// Add button
ElevatedButton(
  onPressed: () {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => ScreenNameHere()),
    );
  },
  child: Text('Go to Screen'),
)
```

---

## 🔘 NEW BUTTON TEMPLATE (10 seconds)

**ElevatedButton with Toast:**
```dart
ElevatedButton(
  onPressed: () {
    showToast(context, 'Button pressed!');
  },
  child: Text('Button Text'),
)
```

**ElevatedButton with Navigation:**
```dart
ElevatedButton(
  onPressed: () {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => TargetScreen()),
    );
  },
  child: Text('Go to Page'),
)
```

**Button with Icon:**
```dart
ElevatedButton.icon(
  onPressed: () {
    showToast(context, 'Clicked!');
  },
  icon: Icon(Icons.add),
  label: Text('Add Item'),
)
```

**Colored Button:**
```dart
ElevatedButton(
  style: ElevatedButton.styleFrom(
    backgroundColor: Colors.blue,
    foregroundColor: Colors.white,
  ),
  onPressed: () {
    showToast(context, 'Success!');
  },
  child: Text('Submit'),
)
```

---

## 🎨 COLOR CHANGE LOCATIONS

**Global App Bar Color:**
```
File: lib/core/theme/app_theme.dart
Location: appBarTheme: AppBarTheme(backgroundColor: Colors.XXX)
```

**Single Screen Background:**
```dart
Scaffold(
  backgroundColor: Colors.grey[200],
  // ...
)
```

**Button Color:**
```dart
ElevatedButton(
  style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
  // ...
)
```

**Text Color:**
```dart
Text(
  'Hello',
  style: TextStyle(color: Colors.blue),
)
```

---

## 🔍 ICON ADDITION TEMPLATES

**Icon in AppBar:**
```dart
AppBar(
  title: Text('Title'),
  actions: [
    IconButton(
      icon: Icon(Icons.search),
      onPressed: () {
        showToast(context, 'Search clicked');
      },
    ),
  ],
)
```

**Icon in Button:**
```dart
ElevatedButton(
  onPressed: () {},
  child: Row(
    mainAxisSize: MainAxisSize.min,
    children: [
      Icon(Icons.shopping_cart),
      SizedBox(width: 8),
      Text('Cart'),
    ],
  ),
)
```

**Standalone IconButton:**
```dart
IconButton(
  icon: Icon(Icons.favorite),
  color: Colors.red,
  onPressed: () {
    showToast(context, 'Liked!');
  },
)
```

---

## 📏 LAYOUT TEMPLATES

**Padding Wrapper:**
```dart
Padding(
  padding: EdgeInsets.all(16),
  child: YourWidget(),
)
```

**Row (Horizontal):**
```dart
Row(
  mainAxisAlignment: MainAxisAlignment.spaceBetween,
  children: [
    Text('Left'),
    Text('Right'),
  ],
)
```

**Column (Vertical):**
```dart
Column(
  crossAxisAlignment: CrossAxisAlignment.start,
  children: [
    Text('Top'),
    SizedBox(height: 10),
    Text('Bottom'),
  ],
)
```

**ListView (Scrollable):**
```dart
ListView(
  children: [
    ListTile(title: Text('Item 1')),
    ListTile(title: Text('Item 2')),
    ListTile(title: Text('Item 3')),
  ],
)
```

**Container with Border:**
```dart
Container(
  padding: EdgeInsets.all(16),
  decoration: BoxDecoration(
    border: Border.all(color: Colors.grey),
    borderRadius: BorderRadius.circular(8),
  ),
  child: Text('Content'),
)
```

---

## 🚀 NAVIGATION TEMPLATES

**Push to New Screen:**
```dart
Navigator.push(
  context,
  MaterialPageRoute(builder: (_) => NextScreen()),
);
```

**Go Back:**
```dart
Navigator.pop(context);
```

**Push with Data:**
```dart
Navigator.push(
  context,
  MaterialPageRoute(
    builder: (_) => DetailScreen(id: '123'),
  ),
);
```

**Replace Current Screen:**
```dart
Navigator.pushReplacement(
  context,
  MaterialPageRoute(builder: (_) => NewScreen()),
);
```

---

## 📝 TEXT STYLE TEMPLATES

**Bold Text:**
```dart
Text(
  'Bold Text',
  style: TextStyle(fontWeight: FontWeight.bold),
)
```

**Large Text:**
```dart
Text(
  'Big Text',
  style: TextStyle(fontSize: 24),
)
```

**Colored Text:**
```dart
Text(
  'Colored',
  style: TextStyle(color: Colors.blue),
)
```

**Combined Styles:**
```dart
Text(
  'Styled Text',
  style: TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.bold,
    color: Colors.red,
  ),
)
```

---

## 🎯 COMMON WIDGETS QUICK REF

**Divider (Line Separator):**
```dart
Divider(thickness: 1, color: Colors.grey)
```

**Spacer:**
```dart
SizedBox(height: 20)  // Vertical space
SizedBox(width: 20)   // Horizontal space
```

**Loading Spinner:**
```dart
CircularProgressIndicator()
```

**Card:**
```dart
Card(
  elevation: 2,
  child: Padding(
    padding: EdgeInsets.all(16),
    child: Text('Card Content'),
  ),
)
```

**Image (Network):**
```dart
Image.network('https://example.com/image.jpg')
```

**Image (Asset):**
```dart
Image.asset('assets/logo.png')
```

---

## ⚡ TOAST VARIATIONS

**Success Toast:**
```dart
showToast(context, 'Success!');
```

**Error Toast:**
```dart
showToast(context, 'Error occurred!', isError: true);
```

**Custom Message:**
```dart
showToast(context, 'Item added to cart');
```

---

## 🔧 QUICK FIXES

**Missing Import - Material:**
```dart
import 'package:flutter/material.dart';
```

**Missing Import - Toast:**
```dart
import '../../core/utils/toast_helper.dart';
```

**Missing Import - Screen (same level):**
```dart
import 'screen_name.dart';
```

**Missing Import - Screen (different folder):**
```dart
import '../foldername/screen_name.dart';
```

**Missing onPressed:**
```dart
onPressed: () {
  showToast(context, 'Clicked!');
},
```

**Missing child in button:**
```dart
child: Text('Button Text'),
```

---

## 📊 STATEFUL WIDGET TEMPLATE (Advanced)

If teacher asks for **"Add a counter"** or **"Make it change when clicked"**:

```dart
class CounterScreen extends StatefulWidget {
  const CounterScreen({Key? key}) : super(key: key);

  @override
  State<CounterScreen> createState() => _CounterScreenState();
}

class _CounterScreenState extends State<CounterScreen> {
  int counter = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Counter')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Count: $counter', style: TextStyle(fontSize: 24)),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  counter++;
                });
              },
              child: Text('Increment'),
            ),
          ],
        ),
      ),
    );
  }
}
```

---

## 🎯 EXAM STRATEGY

**When teacher asks for something NEW:**

1. **Check this file** for matching template
2. **Copy the template**
3. **Modify names/text** to match requirement
4. **Save and hot reload**
5. **Show it works** to teacher

**Time savings:**
- Without templates: 2-3 minutes per addition
- With templates: 20-30 seconds per addition

**That's 5X FASTER! 🚀**

---

## 📝 PRINT THIS FOR EXAM DAY

Keep this file open in a browser tab or print the most common templates:

**TOP 5 MUST-HAVE:**
1. New Screen Template
2. Button Templates
3. Navigation Push/Pop
4. Import Fixes
5. onPressed Template

**These 5 cover 90% of what teachers ask for!**

