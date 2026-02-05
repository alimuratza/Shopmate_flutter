import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get/get.dart';
import 'firebase_options.dart';
import 'core/theme/app_theme.dart';
import 'core/constants/app_colors.dart';
import 'data/services/firestore_seeder.dart';
import 'ui/onboarding/onboarding_screen.dart';
import 'ui/onboarding/onboarding_two.dart';
import 'ui/home/home_screen.dart';
import 'ui/auth/login_page.dart';
import 'ui/auth/signup_page.dart';
import 'ui/auth/forgot_password_page.dart';
import 'ui/auth/change_password_page.dart';
import 'ui/cart/cart_screen.dart';
import 'ui/search/search_screen.dart';
import 'ui/categories/categories_screen.dart';
import 'ui/categories/category_products_screen.dart';
import 'ui/checkout/checkout_screen.dart';
import 'ui/orders/orders_screen.dart';
import 'ui/orders/order_detail_screen.dart';
import 'ui/profile/profile_screen.dart';
import 'ui/profile/address_screen.dart';
import 'ui/profile/payment_methods_screen.dart';
import 'ui/product/product_detail_screen.dart';
import 'ui/settings/settings_screen.dart';
import 'ui/wishlist/wishlist_screen.dart';
import 'ui/notifications/notifications_screen.dart';
import 'ui/debug/debug_screen.dart';
import 'ui/products_admin/products_admin_screen.dart';
import 'ui/ai/ai_chatbot_screen.dart';
import 'ui/ai/visual_search_screen.dart';
import 'ui/ai/ai_hub_screen.dart';
import 'bindings/initial_binding.dart';
import 'bindings/auth_binding.dart';
import 'bindings/change_password_binding.dart';
import 'bindings/forgot_password_binding.dart';
import 'bindings/cart_binding.dart';
import 'bindings/search_binding.dart';
import 'bindings/categories_binding.dart';
import 'bindings/category_products_binding.dart';
import 'bindings/checkout_binding.dart';
import 'bindings/orders_binding.dart';
import 'bindings/order_detail_binding.dart';
import 'bindings/profile_binding.dart';
import 'bindings/address_binding.dart';
import 'bindings/payment_methods_binding.dart';
import 'bindings/settings_binding.dart';
import 'bindings/wishlist_binding.dart';
import 'bindings/notifications_binding.dart';
import 'bindings/debug_binding.dart';
import 'bindings/onboarding_binding.dart';
import 'bindings/signup_binding.dart';
import 'bindings/home_binding.dart';
import 'bindings/products_admin_binding.dart';
import 'bindings/product_detail_binding.dart';
import 'bindings/ai_binding.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  
  // Seed sample data to Firestore (runs once if empty)
  await FirestoreSeeder.seedSampleProducts();
  
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'ShopEase',
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.light,
      initialBinding: InitialBinding(),
      home: SplashScreen(),
      getPages: [
        GetPage(name: '/onboarding', page: () => OnboardingOne(), binding: OnboardingBinding()),
        GetPage(name: '/onboarding/two', page: () => const OnboardingTwo()),
        GetPage(name: '/login', page: () => LoginPage(), binding: LoginBinding()),
        GetPage(name: '/auth/login', page: () => LoginPage(), binding: LoginBinding()),
        GetPage(name: '/signup', page: () => SignupPage(), binding: SignupBinding()),
        GetPage(name: '/auth/signup', page: () => SignupPage(), binding: SignupBinding()),
        GetPage(name: '/forgot-password', page: () => ForgotPasswordPage(), binding: ForgotPasswordBinding()),
        GetPage(name: '/auth/forgot-password', page: () => ForgotPasswordPage(), binding: ForgotPasswordBinding()),
        GetPage(name: '/auth/change-password', page: () => ChangePasswordPage(), binding: ChangePasswordBinding()),
        GetPage(name: '/home', page: () => HomeScreen(), binding: HomeBinding()),
        GetPage(name: '/cart', page: () => CartScreen(), binding: CartBinding()),
        GetPage(name: '/search', page: () => const SearchScreen(), binding: SearchBinding()),
        GetPage(name: '/categories', page: () => const CategoriesScreen(), binding: CategoriesBinding()),
        GetPage(name: '/categories/products', page: () => const CategoryProductsScreen(), binding: CategoryProductsBinding()),
        GetPage(name: '/checkout', page: () => const CheckoutScreen(), binding: CheckoutBinding()),
        GetPage(name: '/product/detail', page: () => const ProductDetailScreen(), binding: ProductDetailBinding()),
        GetPage(name: '/orders', page: () => const OrdersScreen(), binding: OrdersBinding()),
        GetPage(name: '/orders/detail', page: () => const OrderDetailScreen(), binding: OrderDetailBinding()),
        GetPage(name: '/profile', page: () => const ProfileScreen(), binding: ProfileBinding()),
        GetPage(name: '/profile/address', page: () => const AddressScreen(), binding: AddressBinding()),
        GetPage(name: '/profile/payment-methods', page: () => const PaymentMethodsScreen(), binding: PaymentMethodsBinding()),
        GetPage(name: '/settings', page: () => const SettingsScreen(), binding: SettingsBinding()),
        GetPage(name: '/wishlist', page: () => const WishlistScreen(), binding: WishlistBinding()),
        GetPage(name: '/notifications', page: () => const NotificationsScreen(), binding: NotificationsBinding()),
        GetPage(name: '/debug', page: () => const DebugScreen(), binding: DebugBinding()),
        GetPage(name: '/admin/products', page: () => const ProductsAdminScreen(), binding: ProductsAdminBinding()),
        
        // AI Features
        GetPage(name: '/ai/hub', page: () => const AIHubScreen(), binding: AIBinding()),
        GetPage(name: '/ai/chatbot', page: () => const AIChatbotScreen(), binding: AIBinding()),
        GetPage(name: '/ai/visual-search', page: () => const VisualSearchScreen(), binding: AIBinding()),
      ],
    );
  }
}

class SplashScreen extends StatefulWidget {
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(duration: const Duration(milliseconds: 1500), vsync: this);
    _scaleAnimation = Tween<double>(begin: 0.5, end: 1.0).animate(CurvedAnimation(parent: _controller, curve: Curves.elasticOut));
    _controller.forward();
    Future.delayed(const Duration(seconds: 3), () => Get.offAllNamed('/onboarding'));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [AppColors.primary, AppColors.primaryDark],
          ),
        ),
        child: Center(
          child: ScaleTransition(
            scale: _scaleAnimation,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 120,
                  height: 120,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(30),
                    boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.2), blurRadius: 30, offset: Offset(0, 10))],
                  ),
                  child: Icon(Icons.shopping_bag_rounded, size: 60, color: AppColors.primary),
                ),
                SizedBox(height: 24),
                Text('ShopEase', style: TextStyle(fontSize: 36, fontWeight: FontWeight.bold, color: Colors.white, letterSpacing: 1.5)),
                SizedBox(height: 8),
                Text('Shop Smart, Live Better', style: TextStyle(fontSize: 16, color: Colors.white.withOpacity(0.9))),
                SizedBox(height: 60),
                SizedBox(width: 40, height: 40, child: CircularProgressIndicator(strokeWidth: 3, valueColor: AlwaysStoppedAnimation<Color>(Colors.white.withOpacity(0.9)))),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
