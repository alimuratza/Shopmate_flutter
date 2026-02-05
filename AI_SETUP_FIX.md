# 🔧 AI Features Setup & Troubleshooting

## Problem: AI Features Not Working Properly

The AI features (chatbot, visual search, recommendations) were added to your app, but they need **3 critical steps** to work:

---

## ✅ Step 1: Get Google Gemini API Key (2 minutes)

### What is it?
- Free API from Google for accessing Gemini AI model
- Required to use AI recommendations, chatbot, and visual search
- Completely free tier available

### How to get it:

1. **Visit**: https://makersuite.google.com/app/apikey
2. **Click**: "Create API Key" (blue button)
3. **Choose**: "Create API key in new Google Cloud project"
4. **Copy**: Your API key (looks like: `AIzaSy...`)
5. **Keep it safe** - Don't share this with anyone!

---

## ✅ Step 2: Add API Key to Code (30 seconds)

**File**: `lib/data/services/ai_service.dart`

**Find this line (Line 5):**
```dart
static const String _apiKey = 'AIzaSyDKjJK2V-rKmJ_HJ-K2J-K2J-K2J-K2J'; // Replace with your API key
```

**Replace with:**
```dart
static const String _apiKey = 'YOUR_API_KEY_HERE'; // Paste your actual API key
```

**Example:**
```dart
static const String _apiKey = 'AIzaSyC1j2k3l4m5n6o7p8q9r0s1t2u3v4w5x6y'; // Your real key
```

### ⚠️ Important Security Note:
- **Never** commit this file to public GitHub
- Add to `.gitignore`: `lib/data/services/ai_service.dart`
- Or use environment variables for production

---

## ✅ Step 3: Rebuild & Deploy (5 minutes)

### For Local Testing:
```bash
cd /Users/mac/AndroidStudioProjects/ecommerceapp
flutter pub get
flutter run -d chrome
```

### For Production (Firebase):
```bash
flutter build web --release --no-tree-shake-icons
firebase deploy --only hosting
```

---

## 🧪 Testing the AI Features

### After deployment, test these features:

1. **AI Chat** 💬
   - Tap AI button in header OR scroll to "AI Chat" card
   - Ask: "What products do you have?"
   - Expected: AI responds with product information

2. **Visual Search** 🔍
   - Tap "Visual Search" card
   - Enter: "I want a blue backpack under ₹500"
   - Expected: Shows matching products with AI scoring

3. **AI Recommendations** ⭐
   - Scroll home page to see "AI Pick" products
   - These are recommended based on browsing history
   - Expected: Shows 3-5 recommended products

---

## 🐛 Troubleshooting

### Issue: "Error: API key not found"
**Solution**: You forgot Step 2. Add your API key to `ai_service.dart` line 5.

### Issue: "Unsupported operation" errors
**Solution**: These are debug warnings. They don't affect functionality.
- Ignore them or test on the deployed Firebase version

### Issue: AI responses are empty
**Solution**: 
- Check internet connection
- Verify API key is correct
- Check Google Cloud quota hasn't been exceeded
- Wait 30 seconds, API sometimes takes time

### Issue: "Web routing errors"
**Solution**: Already fixed in the code. Just redeploy to Firebase.

---

## 📋 AI Features Overview

### 1. **AI Chatbot** 🤖
- **Location**: Home header AI button → "AI Chat" card
- **What it does**: Chat interface with AI assistant
- **How it works**: User types questions, AI responds using Gemini
- **Example**: "Can you help me find a laptop?"

### 2. **Visual Search** 🔍
- **Location**: Home header AI button → "Visual Search" card
- **What it does**: Search products by describing what you want
- **How it works**: NLP understanding → product matching → scoring
- **Example**: "I need a red running shoe under ₹3000"

### 3. **AI Recommendations** ⭐
- **Location**: Home feed (scroll down)
- **What it does**: Shows AI-picked products
- **How it works**: Analyzes browsing history → recommends similar items
- **Example**: Viewed "T-shirts" → AI recommends matching pants

### 4. **AI Hub** 🎯
- **Location**: Home header AI button
- **What it does**: Shows all 3 AI features with "How It Works"
- **How it works**: Landing page for exploring all AI capabilities
- **Example**: "Explore all AI features"

---

## 🚀 Next Steps

1. **Get API key** from https://makersuite.google.com/app/apikey
2. **Add to ai_service.dart** line 5
3. **Rebuild web**: `flutter build web --release --no-tree-shake-icons`
4. **Deploy**: `firebase deploy --only hosting`
5. **Test** all 3 features at https://ali-ecommerce-1234.web.app

---

## 📞 Need Help?

- Google API Key Help: https://support.google.com/googleapi/answer/6158840
- Flutter GetX Routing: https://github.com/jonataslaw/getx
- Firebase Deployment: https://firebase.google.com/docs/hosting/deploy

---

**Status**: ✅ Code Ready | ⏳ Waiting for API Key | 🚀 Ready to Deploy
