import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../models/product_model.dart';

class AIService {
  // ✅ Google Gemini API Key (from https://makersuite.google.com/app/apikey)
  static const String _apiKey = 'AIzaSyDnjIVvig7MxMPHicT-7OWshMrJ0YZ5_eo'; // Real Gemini API Key
  late GenerativeModel _model;

  AIService() {
    // Initialize Gemini model with API key
    _model = GenerativeModel(
      model: 'gemini-1.5-flash',
      apiKey: _apiKey,
    );
    print('✅ AI Service: Gemini model initialized with API key');
  }

  /// **AI Product Recommendations**
  /// Generates personalized product recommendations based on user history
  Future<List<String>> getProductRecommendations({
    required List<ProductModel> allProducts,
    required List<ProductModel> browsingHistory,
    required String userPreferences,
  }) async {
    try {
      print('🤖 Getting AI recommendations from Gemini...');
      
      final productDescriptions = allProducts
          .map((p) => '${p.name}: ${p.description} (₹${p.price})')
          .join('\n');

      final browsingHistoryStr = browsingHistory
          .map((p) => p.name)
          .join(', ');

      final prompt = '''
Based on the user's browsing history: $browsingHistoryStr
And user preferences: $userPreferences

From these available products:
$productDescriptions

Recommend the 5 best products that match their interests.
Response format: Just list the product names, one per line, without numbering or explanations.
''';

      // Use REST API like the chatbot
      print('📋 Checking available models for recommendations...');
      final listModelsUrl = Uri.parse(
        'https://generativelanguage.googleapis.com/v1beta/models?key=$_apiKey'
      );
      
      final listResponse = await http.get(listModelsUrl);
      
      if (listResponse.statusCode == 200) {
        final modelsData = jsonDecode(listResponse.body);
        final models = modelsData['models'] as List?;
        if (models != null && models.isNotEmpty) {
          final modelName = models[0]['name'] as String?;
          final modelId = modelName?.split('/').last ?? 'gemini-1.5-pro-latest';
          
          final url = Uri.parse(
            'https://generativelanguage.googleapis.com/v1beta/models/$modelId:generateContent?key=$_apiKey'
          );

          print('📤 Sending recommendations request to model: $modelId');
          final response = await http.post(
            url,
            headers: {'Content-Type': 'application/json'},
            body: jsonEncode({
              'contents': [
                {
                  'parts': [
                    {'text': prompt}
                  ]
                }
              ]
            }),
          );

          if (response.statusCode == 200) {
            final data = jsonDecode(response.body);
            final responseText = data['candidates']?[0]?['content']?['parts']?[0]?['text'] ?? '';
            
            final recommendations = responseText
                .split('\n')
                .where((name) => name.trim().isNotEmpty)
                .map((name) => name.trim())
                .toList();

            print('✅ Gemini recommendations: $recommendations');
            return recommendations;
          }
        }
      }
      
      print('⚠️ API call failed, using fallback');
      return _getFallbackRecommendations(allProducts, browsingHistory);
    } catch (e) {
      print('⚠️ Error getting recommendations: $e');
      return _getFallbackRecommendations(allProducts, browsingHistory);
    }
  }

  /// Fallback recommendations (works without API key)
  List<String> _getFallbackRecommendations(
    List<ProductModel> allProducts,
    List<ProductModel> browsingHistory,
  ) {
    if (allProducts.isEmpty) return [];
    
    // If user has browsing history, recommend similar products
    if (browsingHistory.isNotEmpty) {
      final recentCategory = browsingHistory.last.category;
      final similar = allProducts
          .where((p) => p.category == recentCategory)
          .take(5)
          .map((p) => p.name)
          .toList();
      
      if (similar.isNotEmpty) return similar;
    }
    
    // Otherwise, recommend top-rated or trending products
    return allProducts
        .take(5)
        .map((p) => p.name)
        .toList();
  }

  /// **AI Chatbot**
  /// Customer support and product Q&A chatbot
  Future<String> chatbotResponse({
    required String userMessage,
    required List<ProductModel> products,
  }) async {
    try {
      print('🤖 Calling Gemini API (REST) with message: $userMessage');
      
      final productContext = products
          .take(10)
          .map((p) => '${p.name}: ${p.description}')
          .join('\n');

      final systemPrompt = '''
You are a helpful e-commerce customer support assistant for ShopEase.
You help customers find products, answer questions about orders, and provide shopping assistance.

Available products:
$productContext

Be friendly, professional, and concise in your responses.
''';

      final prompt = '$systemPrompt\n\nCustomer: $userMessage';
      
      // First, try to list available models
      print('📋 Checking available models...');
      final listModelsUrl = Uri.parse(
        'https://generativelanguage.googleapis.com/v1beta/models?key=$_apiKey'
      );
      
      final listResponse = await http.get(listModelsUrl);
      print('📋 Models list status: ${listResponse.statusCode}');
      
      if (listResponse.statusCode == 200) {
        final modelsData = jsonDecode(listResponse.body);
        final models = modelsData['models'] as List?;
        if (models != null && models.isNotEmpty) {
          final modelName = models[0]['name'] as String?;
          print('✅ Available model: $modelName');
          
          // Extract just the model ID (e.g., "gemini-1.5-pro-latest" from "models/gemini-1.5-pro-latest")
          final modelId = modelName?.split('/').last ?? 'gemini-1.5-pro-latest';
          
          // Use REST API with the first available model
          final url = Uri.parse(
            'https://generativelanguage.googleapis.com/v1beta/models/$modelId:generateContent?key=$_apiKey'
          );

          print('📤 Sending REST request to model: $modelId');
          final response = await http.post(
            url,
            headers: {'Content-Type': 'application/json'},
            body: jsonEncode({
              'contents': [
                {
                  'parts': [
                    {'text': prompt}
                  ]
                }
              ]
            }),
          );

          print('📥 Response status: ${response.statusCode}');

          if (response.statusCode == 200) {
            final data = jsonDecode(response.body);
            final result = data['candidates']?[0]?['content']?['parts']?[0]?['text'] ?? 
                           'Sorry, no response from Gemini.';
            print('✅ [REAL GEMINI 🤖] response: $result');
            return '🔴 [REAL GEMINI AI] $result';
          } else {
            print('❌ API Error: ${response.statusCode} - ${response.body}');
            final fallbackResponse = _getFallbackChatResponse(userMessage);
            return '⚫ [FALLBACK - HTTP ${response.statusCode}] $fallbackResponse';
          }
        }
      }
      
      final fallbackResponse = _getFallbackChatResponse(userMessage);
      return '⚫ [FALLBACK - No models available] $fallbackResponse';
      
    } catch (e, stackTrace) {
      print('❌ ERROR calling Gemini API: $e');
      print('📍 Stack trace: $stackTrace');
      final fallbackResponse = _getFallbackChatResponse(userMessage);
      return '⚫ [FALLBACK - ERROR: ${e.toString().substring(0, 50)}] $fallbackResponse';
    }
  }

  /// Smart fallback chat responses (works without API key)
  String _getFallbackChatResponse(String userMessage) {
    final message = userMessage.toLowerCase().trim();
    
    // Greeting responses
    if (_matches(message, ['hello', 'hi', 'hey', 'greetings', 'namaste', 'howdy'])) {
      return '👋 Hey there! Welcome to ShopEase! I\'m your shopping assistant. Looking for something specific, or want some recommendations?';
    }
    
    // Product search & recommendations
    if (_matches(message, ['recommend', 'suggest', 'what should', 'what do you recommend', 'best', 'popular', 'trending'])) {
      return '⭐ Great question! We have awesome products across Electronics, Fashion, Home, and more. Try:\n\n1️⃣ Check our "AI Recommendations" section on home\n2️⃣ Use Visual Search to describe what you want\n3️⃣ Browse our Trending section\n\nWhat category interests you?';
    }
    
    // Search/Find requests
    if (_matches(message, ['find', 'search', 'looking for', 'where can i get', 'do you have', 'show me'])) {
      return '🔍 Perfect! I can help you find exactly what you need. Try describing what you\'re looking for - like "blue running shoes under ₹3000" - and I\'ll search for it!\n\nOr use our Visual Search feature for even better results.';
    }
    
    // Price inquiries
    if (_matches(message, ['price', 'cost', 'how much', 'expensive', 'cheap', 'discount', 'offer', 'deal', 'sale'])) {
      return '💰 We have products at every budget! Our prices range from ₹100 to ₹50,000+. \n\nTips:\n🏷️ Check the "Trending" section for hot deals\n⭐ Browse by category to see price ranges\n💳 Use coupons for extra savings\n\nWhat\'s your budget?';
    }
    
    // Shipping & Delivery
    if (_matches(message, ['delivery', 'shipping', 'how long', 'when will', 'track order', 'where is my'])) {
      return '� Here\'s how delivery works:\n\n⚡ Express: 1-2 days\n🚚 Standard: 3-5 days\n🌍 Nationwide shipping available\n\nTo track your order:\n1. Go to Profile → Orders\n2. Tap your order\n3. See live tracking\n\nHave questions about a specific order?';
    }
    
    // Payment & Checkout
    if (_matches(message, ['payment', 'pay', 'credit card', 'debit card', 'upi', 'wallet', 'checkout', 'proceed to pay'])) {
      return '💳 We accept multiple payment methods:\n\n✅ Credit/Debit Cards (Visa, MasterCard)\n✅ UPI (Google Pay, PhonePe, etc.)\n✅ Digital Wallets\n✅ Cash on Delivery\n\nCheckout is secure and fast. Any issues with payment?';
    }
    
    // Returns & Refunds
    if (_matches(message, ['return', 'refund', 'exchange', 'broken', 'damaged', 'wrong item', 'defective'])) {
      return '↩️ We\'ve got you covered! Our return policy:\n\n� 30-day return window\n🚚 Free return shipping\n💰 Full refund within 5-7 days\n\nTo start a return:\n1. Go to Orders\n2. Select the item\n3. Click "Return/Exchange"\n\nWhat\'s the issue with your item?';
    }
    
    // Account & Profile
    if (_matches(message, ['account', 'profile', 'login', 'password', 'address', 'email', 'phone'])) {
      return '👤 Account & Profile Help:\n\n🔑 Password: Go to Settings → Change Password\n📍 Address: Profile → Manage Addresses\n💌 Email/Phone: Profile → Edit Profile\n🔒 Security: Enable 2FA in Settings\n\nNeed help with something specific?';
    }
    
    // Wishlist & Favorites
    if (_matches(message, ['wishlist', 'favorites', 'save', 'bookmark', 'like', 'heart'])) {
      return '❤️ Love a product? Here\'s what you can do:\n\n💜 Add to Wishlist → Access anytime\n📲 Get price drops alerts\n🔔 Notifications when back in stock\n\nTab the heart icon on any product to save it!';
    }
    
    // Category browsing
    if (_matches(message, ['category', 'categories', 'electronics', 'fashion', 'home', 'sports', 'beauty', 'books'])) {
      return '🛍️ Browse our categories:\n\n📱 Electronics (phones, laptops, etc.)\n👕 Fashion (clothes, shoes, accessories)\n🏠 Home (furniture, decor, kitchenware)\n⚽ Sports (fitness, outdoor gear)\n💄 Beauty (skincare, makeup)\n📚 Books & Media\n\nWhich category interests you?';
    }
    
    // Features & How-to
    if (_matches(message, ['how', 'how do i', 'how to', 'guide', 'tutorial', 'help', 'features', 'what can'])) {
      return '❓ Here\'s what you can do on ShopEase:\n\n🛒 Browse & Search products\n🔍 Use AI-powered Visual Search\n💬 Chat with me for recommendations\n⭐ Check AI Recommendations\n❤️ Save favorites to wishlist\n📦 Track your orders\n💳 Secure checkout with multiple options\n\nWhat would you like help with?';
    }
    
    // Comparison & Reviews
    if (_matches(message, ['compare', 'comparison', 'review', 'rating', 'stars', 'better', 'which is'])) {
      return '⭐ Product Reviews & Ratings:\n\n📊 See real customer reviews\n🌟 Check ratings out of 5\n💬 Read detailed feedback\n📸 View customer photos\n\nTo compare products:\n1. Open product pages side-by-side\n2. Check specs, price, and reviews\n3. Read customer experiences\n\nLooking to compare specific items?';
    }
    
    // Special offers
    if (_matches(message, ['offer', 'promotion', 'coupon', 'code', 'discount code', 'promo'])) {
      return '🎉 Special Offers Available:\n\n🎁 Welcome Offer: 25% off first order\n💰 Flash Sales every weekend\n🏷️ Category discounts\n📧 Email subscriber deals\n\nCheck the home page banner for current offers!\n\nHave a coupon code? Apply it at checkout!';
    }
    
    // Not understood - provide helpful fallback
    else {
      return '🤔 I\'m not sure I understood that perfectly, but here\'s what I can help with:\n\n🔍 Search for products\n💬 Answer shopping questions\n📦 Track orders\n💳 Payment & checkout help\n↩️ Returns & refunds\n❤️ Wishlist & favorites\n\nTry rephrasing your question, or ask me about any shopping topic!';
    }
  }

  /// Helper to match multiple keywords
  bool _matches(String message, List<String> keywords) {
    return keywords.any((keyword) => message.contains(keyword));
  }

  /// **Visual Search (Text-based similarity)**
  /// Searches products based on image description
  Future<List<ProductModel>> visualSearch({
    required String imageDescription,
    required List<ProductModel> allProducts,
  }) async {
    try {
      print('🔍 Visual search for: $imageDescription');
      
      if (allProducts.isEmpty) {
        return [];
      }

      // For web, use smart fallback matching instead of Gemini (it's faster)
      print('� Using smart keyword matching for visual search...');
      return _getFallbackVisualSearch(imageDescription, allProducts);
      
    } catch (e) {
      print('⚠️ Error in visual search: $e');
      return _getFallbackVisualSearch(imageDescription, allProducts);
    }
  }

  /// Smart fallback visual search (works without API key)
  List<ProductModel> _getFallbackVisualSearch(
    String description,
    List<ProductModel> allProducts,
  ) {
    if (allProducts.isEmpty) return [];

    final query = description.toLowerCase();
    
    // Score each product based on keyword matches
    final scored = allProducts.map((product) {
      int score = 0;
      final name = product.name.toLowerCase();
      final desc = product.description.toLowerCase();
      final category = product.category.toLowerCase();
      
      // Keyword matching with scoring
      final keywords = query.split(RegExp(r'\s+'));
      for (final keyword in keywords) {
        if (keyword.length < 2) continue; // Skip single chars
        
        if (name.contains(keyword)) score += 5;
        if (desc.contains(keyword)) score += 3;
        if (category.contains(keyword)) score += 2;
      }
      
      // Price range matching (e.g., "under 1000", "below 500")
      if ((query.contains('under') || query.contains('below')) && allProducts.isNotEmpty) {
        final avgPrice = allProducts.map((p) => p.price).reduce((a, b) => a + b) / allProducts.length;
        if (product.price < avgPrice) score += 2;
      }
      
      if ((query.contains('expensive') || query.contains('premium') || query.contains('luxury'))) {
        final avgPrice = allProducts.map((p) => p.price).reduce((a, b) => a + b) / allProducts.length;
        if (product.price > avgPrice) score += 2;
      }
      
      if ((query.contains('cheap') || query.contains('budget') || query.contains('affordable'))) {
        final avgPrice = allProducts.map((p) => p.price).reduce((a, b) => a + b) / allProducts.length;
        if (product.price < avgPrice) score += 3;
      }
      
      return {'product': product, 'score': score};
    }).toList();
    
    // Sort by score (highest first) and return top 5
    scored.sort((a, b) => (b['score'] as int).compareTo(a['score'] as int));
    
    final results = scored
        .where((item) => (item['score'] as int) > 0)
        .take(5)
        .map((item) => item['product'] as ProductModel)
        .toList();
    
    // If no matches found, return top products
    return results.isNotEmpty ? results : allProducts.take(5).toList();
  }

  /// **Smart Search**
  /// Natural language product search
  Future<List<ProductModel>> smartSearch({
    required String query,
    required List<ProductModel> allProducts,
  }) async {
    try {
      print('🔍 Calling Gemini for smart search: $query');
      
      final productList = allProducts
          .map((p) => '${p.id}|${p.name}|${p.description}|${p.category}')
          .join('\n');

      final prompt = '''
User search query: "$query"

Available products:
$productList

Find products that match the search intent. Return only product IDs that match, comma-separated.
''';

      final content = [Content.text(prompt)];
      final response = await _model.generateContent(content);

      final matchIds = response.text
          ?.split(',')
          .map((id) => id.trim())
          .toList() ?? [];

      final matches = allProducts
          .where((p) => matchIds.contains(p.id))
          .toList();

      print('✅ Gemini smart search found: ${matches.length} products');
      return matches;
    } catch (e) {
      print('⚠️ Error in smart search: $e');
      return _getFallbackVisualSearch(query, allProducts);
    }
  }

  /// **Product Description Enhancement**
  /// Generate better product descriptions
  Future<String> enhanceProductDescription(String basicDescription) async {
    try {
      print('✨ Calling Gemini to enhance description...');
      
      final prompt = '''
Enhance this product description to be more engaging and SEO-friendly:
"$basicDescription"

Provide a single improved description (2-3 sentences).
''';

      final content = [Content.text(prompt)];
      final response = await _model.generateContent(content);

      final enhanced = response.text ?? basicDescription;
      print('✅ Enhanced description: $enhanced');
      return enhanced;
    } catch (e) {
      print('⚠️ Error enhancing description: $e');
      return basicDescription;
    }
  }

  /// **Price Analysis**
  /// Analyze if price is good deal
  Future<String> analyzePriceValue({
    required String productName,
    required double currentPrice,
    required List<ProductModel> similarProducts,
  }) async {
    try {
      print('💰 Calling Gemini for price analysis...');
      
      final similarPrices = similarProducts
          .where((p) => p.name.toLowerCase().contains(productName.toLowerCase()))
          .map((p) => p.price)
          .toList();

      final avgPrice = similarPrices.isEmpty ? currentPrice : 
          (similarPrices.reduce((a, b) => a + b) / similarPrices.length);

      final prompt = '''
Product: $productName
Current Price: ₹$currentPrice
Average market price: ₹$avgPrice
Price difference: ₹${(currentPrice - avgPrice).abs()}

Provide a brief analysis if this is a good deal (1-2 sentences).
''';

      final content = [Content.text(prompt)];
      final response = await _model.generateContent(content);

      final analysis = response.text ?? 'Fair price';
      print('✅ Price analysis: $analysis');
      return analysis;
    } catch (e) {
      print('⚠️ Error analyzing price: $e');
      return _getFallbackPriceAnalysis(currentPrice);
    }
  }

  /// Fallback price analysis
  String _getFallbackPriceAnalysis(double price) {
    if (price < 500) {
      return '💚 Great budget option! Excellent value for money.';
    } else if (price < 2000) {
      return '👍 Good price for the quality. A solid choice!';
    } else if (price < 5000) {
      return '⭐ Premium pricing. Worth considering if it fits your needs.';
    } else {
      return '💎 High-end product. Check reviews before purchasing.';
    }
  }
}
