# 🎯 MVVM Quick Reference Guide

## What Changed?

### Before (❌ BAD - Not MVVM)
```dart
// Hardcoded data in UI
class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        buildProduct('Laptop', '₹45000'),  // ❌ Hardcoded
        buildProduct('Phone', '₹25000'),   // ❌ Hardcoded
      ],
    );
  }
}
```

### After (✅ GOOD - MVVM)
```dart
// Data from ViewModel
class HomeTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final HomeVM vm = Get.put(HomeVM());  // ✅ ViewModel
    
    return Obx(() {                        // ✅ Reactive
      return ListView(
        children: vm.products.map((product) =>
          buildProduct(context, product, vm)
        ).toList(),
      );
    });
  }
}
```

## 📁 File Organization

### Models (`lib/data/models/`)
```dart
// product_model.dart
class ProductModel {
  final String id;
  final String name;
  final double price;
  // ... other properties
  
  factory ProductModel.fromJson(Map<String, dynamic> json) { }
  Map<String, dynamic> toJson() { }
}
```

### Repositories (`lib/data/repos/`)
```dart
// product_repo.dart
class ProductRepo {
  List<ProductModel> getAllProducts() {
    // Fetch from Firebase/API or return mock data
    return [/* products */];
  }
}
```

### ViewModels (`lib/ui/[feature]/[feature]_vm.dart`)
```dart
// home_vm.dart
class HomeVM extends GetxController {
  final ProductRepo _repo = ProductRepo();
  var products = <ProductModel>[].obs;  // Observable
  
  @override
  void onInit() {
    super.onInit();
    loadData();
  }
  
  void loadData() {
    products.value = _repo.getAllProducts();
  }
  
  void addToCart(ProductModel product) {
    Get.snackbar('Success', 'Added to cart');
  }
}
```

### Views (`lib/screens/[feature]/[feature]_screen.dart`)
```dart
// home_screen.dart
class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final HomeVM vm = Get.put(HomeVM());
    
    return Obx(() => ListView.builder(
      itemCount: vm.products.length,
      itemBuilder: (context, index) {
        final product = vm.products[index];
        return ListTile(
          title: Text(product.name),
          onTap: () => vm.viewProduct(product),
        );
      },
    ));
  }
}
```

## 🔄 MVVM Flow

1. **User taps button** → View
2. **View calls ViewModel method** → `vm.addToCart(product)`
3. **ViewModel processes logic** → Validation, state updates
4. **ViewModel calls Repository** → `_repo.saveToCart(product)`
5. **Repository handles data** → Firebase/API call
6. **Repository returns Model** → `ProductModel`
7. **ViewModel updates observable** → `cartItems.add(item)`
8. **View auto-updates via Obx** → UI refreshes

## ✅ MVVM Rules

### ✅ DO
- Keep UI code in Views only
- Put business logic in ViewModels
- Use Repositories for data access
- Use Models for data structures
- Make ViewModels observable with `.obs`
- Wrap UI with `Obx()` to observe changes
- Call ViewModel methods from Views

### ❌ DON'T
- Don't put business logic in Views
- Don't hardcode data in UI
- Don't directly call Firebase/API from Views
- Don't import widgets in ViewModels
- Don't use `setState` (use GetX observables)
- Don't skip the Repository layer

## 🚀 Adding New Features

### Step 1: Create Model
```dart
// lib/data/models/order_model.dart
class OrderModel {
  final String id;
  final double total;
  // ...
}
```

### Step 2: Create Repository
```dart
// lib/data/repos/order_repo.dart
class OrderRepo {
  Future<List<OrderModel>> getOrders() async {
    // Fetch from Firebase
  }
}
```

### Step 3: Create ViewModel
```dart
// lib/ui/orders/orders_vm.dart
class OrdersVM extends GetxController {
  final OrderRepo _repo = OrderRepo();
  var orders = <OrderModel>[].obs;
  
  void loadOrders() {
    orders.value = await _repo.getOrders();
  }
}
```

### Step 4: Create View
```dart
// lib/screens/orders/orders_screen.dart
class OrdersScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final OrdersVM vm = Get.put(OrdersVM());
    
    return Obx(() => ListView.builder(
      itemCount: vm.orders.length,
      itemBuilder: (context, index) {
        return OrderCard(order: vm.orders[index]);
      },
    ));
  }
}
```

## 🎨 Common Patterns

### Loading State
```dart
// In ViewModel
var isLoading = false.obs;

void loadData() async {
  isLoading.value = true;
  // fetch data
  isLoading.value = false;
}

// In View
Obx(() {
  if (vm.isLoading.value) {
    return CircularProgressIndicator();
  }
  return YourContent();
})
```

### Error Handling
```dart
// In ViewModel
var errorMessage = ''.obs;

void loadData() {
  try {
    // fetch data
  } catch (e) {
    errorMessage.value = e.toString();
    Get.snackbar('Error', e.toString());
  }
}
```

### Pull to Refresh
```dart
// In ViewModel
Future<void> refreshData() async {
  await loadData();
}

// In View
RefreshIndicator(
  onRefresh: vm.refreshData,
  child: YourList(),
)
```

## 📚 Summary

**MVVM = Model + View + ViewModel**

- **Model**: Data structures (ProductModel, UserModel)
- **View**: UI only (Screens, Widgets)
- **ViewModel**: Business logic + State management
- **Repository**: Data access (Firebase, API)

**Benefits:**
- ✅ Clean code organization
- ✅ Easy to test
- ✅ Easy to maintain
- ✅ Team collaboration friendly
- ✅ Scalable architecture

---
**Your project is now MVVM compliant!** 🎉
