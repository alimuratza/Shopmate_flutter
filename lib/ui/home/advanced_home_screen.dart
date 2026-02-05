import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'home_vm.dart';
import '../cart/cart_screen.dart';
import '../wishlist/wishlist_screen.dart';
import '../profile/profile_screen.dart';
import '../../widgets/advanced/advanced_widgets.dart';
import '../../core/constants/app_colors.dart';

/// Advanced Home Screen with modern UI
class AdvancedHomeScreen extends GetView<HomeVM> {
  const AdvancedHomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Set status bar style
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
      ),
    );

    return Obx(() {
      final currentIndex = controller.tabIndex.value;
      return Scaffold(
        backgroundColor: AppColors.background,
        body: _getScreen(currentIndex),
        extendBody: true,
        bottomNavigationBar: AdvancedBottomNav(
          currentIndex: currentIndex,
          onTap: controller.setTab,
          items: const [
            AdvancedBottomNavItem(
              icon: Icons.home_outlined,
              activeIcon: Icons.home_rounded,
              label: 'Home',
            ),
            AdvancedBottomNavItem(
              icon: Icons.favorite_outline_rounded,
              activeIcon: Icons.favorite_rounded,
              label: 'Wishlist',
            ),
            AdvancedBottomNavItem(
              icon: Icons.shopping_bag_outlined,
              activeIcon: Icons.shopping_bag_rounded,
              label: 'Cart',
              badge: '3', // TODO: Connect to cart count
            ),
            AdvancedBottomNavItem(
              icon: Icons.person_outline_rounded,
              activeIcon: Icons.person_rounded,
              label: 'Profile',
            ),
          ],
        ),
      );
    });
  }

  Widget _getScreen(int tabIndex) {
    switch (tabIndex) {
      case 0:
        return const AdvancedHomeTab();
      case 1:
        return const WishlistScreen();
      case 2:
        return const CartScreen();
      case 3:
        return const ProfileScreen();
      default:
        return const AdvancedHomeTab();
    }
  }
}

/// Advanced Home Tab with all modern widgets
class AdvancedHomeTab extends GetView<HomeVM> {
  const AdvancedHomeTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Obx(() {
          if (controller.isLoading.value) {
            return const _LoadingState();
          }

          return RefreshIndicator(
            onRefresh: controller.refreshData,
            color: AppColors.primary,
            child: CustomScrollView(
              slivers: [
                // App Bar
                SliverToBoxAdapter(child: _buildHeader(context)),
                
                // Search Bar
                SliverToBoxAdapter(child: _buildSearchBar()),
                
                // Promo Banners
                SliverToBoxAdapter(child: _buildPromoBanners()),
                
                // Categories Section
                SliverToBoxAdapter(child: _buildCategoriesSection()),
                
                // Featured Products
                SliverToBoxAdapter(child: _buildFeaturedProducts()),
                
                // All Products Grid
                SliverToBoxAdapter(child: _buildProductsSection()),
                
                // Bottom padding for nav bar
                const SliverToBoxAdapter(
                  child: SizedBox(height: 100),
                ),
              ],
            ),
          );
        }),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 16, 20, 8),
      child: Row(
        children: [
          // Greeting
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Hello, Shopper! 👋',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey[600],
                  ),
                ),
                const SizedBox(height: 4),
                const Text(
                  'Find Your Style',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textPrimary,
                  ),
                ),
              ],
            ),
          ),
          
          // Notification Button
          AnimatedIconButton(
            icon: Icons.notifications_outlined,
            onPressed: () => Get.toNamed('/notifications'),
            badge: '2',
            backgroundColor: Colors.white,
          ),
        ],
      ),
    );
  }

  Widget _buildSearchBar() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 16, 20, 8),
      child: GestureDetector(
        onTap: () => controller.navigateToSearch(),
        child: const AdvancedSearchBar(
          hintText: 'Search for products...',
          readOnly: true,
        ),
      ),
    );
  }

  Widget _buildPromoBanners() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: PromoBannerCarousel(
        height: 160,
        banners: [
          PromoBanner(
            title: 'Summer Sale',
            subtitle: 'Up to 50% off on selected items',
            tag: 'LIMITED TIME',
            buttonText: 'Shop Now',
            gradientColors: [
              const Color(0xFF667eea),
              const Color(0xFF764ba2),
            ],
            onTap: () {},
          ),
          PromoBanner(
            title: 'New Arrivals',
            subtitle: 'Check out our latest collection',
            tag: 'FRESH',
            buttonText: 'Explore',
            gradientColors: [
              const Color(0xFFf093fb),
              const Color(0xFFf5576c),
            ],
            onTap: () {},
          ),
          PromoBanner(
            title: 'Free Shipping',
            subtitle: 'On orders above ₹999',
            tag: 'DEAL',
            buttonText: 'Learn More',
            gradientColors: [
              const Color(0xFF4facfe),
              const Color(0xFF00f2fe),
            ],
            onTap: () {},
          ),
        ],
      ),
    );
  }

  Widget _buildCategoriesSection() {
    return Column(
      children: [
        SectionHeader(
          title: 'Categories',
          subtitle: 'Browse by category',
          onSeeAll: () => Get.toNamed('/categories'),
        ),
        const SizedBox(height: 8),
        Obx(() => SizedBox(
          height: 120,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            itemCount: controller.categories.length,
            itemBuilder: (context, index) {
              final category = controller.categories[index];
              return Container(
                width: 100,
                margin: const EdgeInsets.only(right: 12),
                child: AdvancedCategoryCard(
                  name: category.name,
                  icon: category.icon,
                  color: category.color,
                  onTap: () => controller.navigateToCategory(category.name),
                ),
              );
            },
          ),
        )),
      ],
    );
  }

  Widget _buildFeaturedProducts() {
    return Column(
      children: [
        const SizedBox(height: 24),
        SectionHeader(
          title: 'Featured Products',
          subtitle: 'Hand-picked for you',
          onSeeAll: () {},
        ),
        const SizedBox(height: 8),
        Obx(() => SizedBox(
          height: 280,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            itemCount: controller.products.take(5).length,
            itemBuilder: (context, index) {
              final product = controller.products[index];
              return Container(
                width: 180,
                margin: const EdgeInsets.only(right: 16),
                child: AdvancedProductCard(
                  name: product.name,
                  price: '₹${product.price.toStringAsFixed(0)}',
                  originalPrice: product.originalPrice != null
                      ? '₹${product.originalPrice!.toStringAsFixed(0)}'
                      : null,
                  imageUrl: product.imageUrl,
                  rating: product.rating,
                  reviewCount: product.reviewCount,
                  isWishlisted: false, // TODO: Connect to wishlist
                  discountPercent: product.originalPrice != null
                      ? ((product.originalPrice! - product.price) /
                              product.originalPrice! *
                              100)
                          .round()
                      : null,
                  heroTag: 'product_${product.id}',
                  onTap: () => controller.viewProductDetails(product),
                  onWishlistTap: () {
                    // TODO: Add to wishlist
                    AdvancedSnackBar.success(
                      context,
                      'Added to wishlist',
                    );
                  },
                  onAddToCart: () {
                    controller.addToCart(product);
                    AdvancedSnackBar.success(
                      context,
                      '${product.name} added to cart',
                    );
                  },
                ),
              );
            },
          ),
        )),
      ],
    );
  }

  Widget _buildProductsSection() {
    return Column(
      children: [
        const SizedBox(height: 24),
        SectionHeader(
          title: 'All Products',
          subtitle: 'Discover more',
          onSeeAll: () {},
        ),
        const SizedBox(height: 8),
        Obx(() => GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          padding: const EdgeInsets.symmetric(horizontal: 16),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 16,
            crossAxisSpacing: 16,
            childAspectRatio: 0.65,
          ),
          itemCount: controller.products.length,
          itemBuilder: (context, index) {
            final product = controller.products[index];
            return AdvancedProductCard(
              name: product.name,
              price: '₹${product.price.toStringAsFixed(0)}',
              originalPrice: product.originalPrice != null
                  ? '₹${product.originalPrice!.toStringAsFixed(0)}'
                  : null,
              imageUrl: product.imageUrl,
              rating: product.rating,
              discountPercent: product.originalPrice != null
                  ? ((product.originalPrice! - product.price) /
                          product.originalPrice! *
                          100)
                      .round()
                  : null,
              heroTag: 'product_grid_${product.id}',
              onTap: () => controller.viewProductDetails(product),
              onWishlistTap: () {},
              onAddToCart: () {
                controller.addToCart(product);
              },
            );
          },
        )),
      ],
    );
  }
}

/// Loading state with shimmer
class _LoadingState extends StatelessWidget {
  const _LoadingState();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header shimmer
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    ShimmerBox(height: 16, width: 120),
                    SizedBox(height: 8),
                    ShimmerBox(height: 24, width: 180),
                  ],
                ),
              ),
              const ShimmerBox(height: 48, width: 48, borderRadius: 24),
            ],
          ),
          const SizedBox(height: 24),
          
          // Search shimmer
          const ShimmerBox(height: 56, borderRadius: 16),
          const SizedBox(height: 24),
          
          // Banner shimmer
          const ShimmerBox(height: 160, borderRadius: 20),
          const SizedBox(height: 24),
          
          // Categories shimmer
          Row(
            children: const [
              ShimmerBox(height: 20, width: 100),
              Spacer(),
              ShimmerBox(height: 20, width: 60),
            ],
          ),
          const SizedBox(height: 16),
          SizedBox(
            height: 100,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: 4,
              itemBuilder: (_, __) => const Padding(
                padding: EdgeInsets.only(right: 12),
                child: ShimmerBox(height: 100, width: 100, borderRadius: 16),
              ),
            ),
          ),
          const SizedBox(height: 24),
          
          // Products shimmer
          const GridSkeleton(itemCount: 4),
        ],
      ),
    );
  }
}
