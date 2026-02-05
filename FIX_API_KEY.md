# 🔑 How to Add Your Real Google API Key

## Step 1: Get Your API Key
Go to: https://aistudio.google.com/app/apikeys

You should see your keys like:
- `...5_eo` (Gemini API Key)
- `...VYBU` (Default Gemini API Key)

Click on one to see the full key (starts with `AIzaSy`)

## Step 2: Copy Your Key
Click the copy button 📋 next to your API key

## Step 3: Add to Code

**File:** `lib/data/services/ai_service.dart`  
**Line 6:**

Replace:
```dart
static const String _apiKey = 'AIzaSyC1j2k3l4m5n6o7p8q9r0s1t2u3v4w5x6y';
```

With your actual key (paste what you copied):
```dart
static const String _apiKey = 'YOUR_ACTUAL_API_KEY_HERE';
```

Example:
```dart
static const String _apiKey = 'AIzaSyDKjJK2V-rKmJ_HJ-K2J-K2J-K2J-K2J';
```

## Step 4: Save and Test

1. Save the file (Cmd+S)
2. The app should auto-reload
3. Try the chatbot - it will now give real AI answers!

---

## ⚠️ Why Chatbot Isn't Giving Gemini Answers Now

- Current API key is a **placeholder** (doesn't work)
- App is using **smart fallback responses** instead
- Once you add your **real key**, it will use **Google Gemini AI**

The fallback works great, but real Gemini will be much better! 🚀
