import 'package:get/get.dart';
import '../../data/models/product_model.dart';
import '../../data/services/ai_service.dart';

class AIViewModel extends GetxController {
  final aiService = AIService();

  // Recommendations
  final recommendations = <ProductModel>[].obs;
  final isLoadingRecommendations = false.obs;

  // Chatbot
  final chatMessages = <ChatMessage>[].obs;
  final isLoadingChat = false.obs;

  // Visual Search
  final visualSearchResults = <ProductModel>[].obs;
  final isLoadingVisualSearch = false.obs;

  // All products (for reference)
  final allProducts = <ProductModel>[].obs;

  /// **Load AI Recommendations**
  Future<void> loadRecommendations(
    List<ProductModel> products,
    List<ProductModel> browsingHistory,
  ) async {
    try {
      isLoadingRecommendations.value = true;
      allProducts.value = products;

      final recommendedNames = await aiService.getProductRecommendations(
        allProducts: products,
        browsingHistory: browsingHistory,
        userPreferences: 'Popular items with good ratings',
      );

      final recommendedProducts = products
          .where((p) => recommendedNames.contains(p.name))
          .toList();

      recommendations.value = recommendedProducts.take(5).toList();
    } catch (e) {
      print('Error loading recommendations: $e');
    } finally {
      isLoadingRecommendations.value = false;
    }
  }

  /// **Send Chat Message**
  Future<void> sendChatMessage(String message) async {
    try {
      // Add user message
      chatMessages.add(ChatMessage(
        text: message,
        isUser: true,
        timestamp: DateTime.now(),
      ));

      isLoadingChat.value = true;

      // Get AI response
      final response = await aiService.chatbotResponse(
        userMessage: message,
        products: allProducts,
      );

      // Add AI response
      chatMessages.add(ChatMessage(
        text: response,
        isUser: false,
        timestamp: DateTime.now(),
      ));
    } catch (e) {
      print('Error sending message: $e');
    } finally {
      isLoadingChat.value = false;
    }
  }

  /// **Visual Search**
  Future<void> visualSearch(String imageDescription) async {
    try {
      isLoadingVisualSearch.value = true;

      final results = await aiService.visualSearch(
        imageDescription: imageDescription,
        allProducts: allProducts,
      );

      visualSearchResults.value = results;
    } catch (e) {
      print('Error in visual search: $e');
    } finally {
      isLoadingVisualSearch.value = false;
    }
  }

  /// **Smart Search**
  Future<List<ProductModel>> smartSearch(String query) async {
    try {
      final results = await aiService.smartSearch(
        query: query,
        allProducts: allProducts,
      );
      return results;
    } catch (e) {
      print('Error in smart search: $e');
      return [];
    }
  }
}

class ChatMessage {
  final String text;
  final bool isUser;
  final DateTime timestamp;

  ChatMessage({
    required this.text,
    required this.isUser,
    required this.timestamp,
  });
}
