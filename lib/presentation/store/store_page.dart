import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ipm_project/providers/cart_provider.dart';
import 'package:ipm_project/presentation/store/product_detail_page.dart';
import 'package:ipm_project/presentation/store/check_cart_page.dart';
import 'package:ipm_project/utils/dummy_helper.dart';


class StorePage extends StatelessWidget {
  const StorePage({super.key});

  @override
  Widget build(BuildContext context) {
    int cartCount = Provider.of<Cart>(context).itemsInCart;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black87,
        title: const Text(
          'Store',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              children: [
                Expanded(
                  child: // Search Bar
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: 'Search products',
                      prefixIcon: const Icon(Icons.search),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                FloatingActionButton(
                  foregroundColor: Colors.white,
                  backgroundColor: Colors.black87,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  onPressed: () {
                    // Show filter options as a pop-up dialog
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: const Text('Filters'),
                          content: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              // Price Range Slider
                              const Padding(
                                padding: EdgeInsets.symmetric(vertical: 8.0),
                                child: Text('Price Range'),
                              ),
                              // Placeholder for a price range slider
                              // Replace this with an actual slider for price range selection
                              // Example: RangeSlider(...),
                              Slider(
                                min: 0,
                                max: 100,
                                onChanged: (value) {
                                  // Handle changes in price range selection
                                },
                                value: 50,
                              ),
                              const Divider(),
                              // Filter Dropdown Menu
                              const Padding(
                                padding: EdgeInsets.symmetric(vertical: 8.0),
                                child: Text('Category'),
                              ),
                              // Placeholder for a dropdown menu for category selection
                              // Replace this with an actual dropdown for category selection
                              // Example: DropdownButton(...),
                              DropdownButton<String>(
                                onChanged: (String? newValue) {
                                  // Handle changes in category selection
                                },
                                items: [
                                  'Dinosaurs',
                                  'Books',
                                  'Toys & Games',
                                  'Clothing & Accessories',
                                  'Home & Stationery'
                                ].map<DropdownMenuItem<String>>((String value) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: Text(value),
                                  );
                                }).toList(),
                                value: 'Dinosaurs', // Default value
                              ),
                              const Divider(),
                              // Sort Dropdown Menu
                              const Padding(
                                padding: EdgeInsets.symmetric(vertical: 8.0),
                                child: Text('Sort By'),
                              ),
                              // Placeholder for a dropdown menu for sorting options
                              // Replace this with an actual dropdown for sorting selection
                              // Example: DropdownButton(...),
                              DropdownButton<String>(
                                onChanged: (String? newValue) {
                                  // Handle changes in sorting selection
                                },
                                items: ['New', 'Popular', 'Relevant']
                                    .map<DropdownMenuItem<String>>((String value) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: Text(value),
                                  );
                                }).toList(),
                                value: 'New', // Default value
                              ),
                            ],
                          ),
                          actions: <Widget>[
                            TextButton(
                              child: const Text('Apply'),
                              onPressed: () {
                                // Apply filters logic
                                Navigator.pop(context); // Close the dialog
                              },
                            ),
                          ],
                        );
                      },
                    );
                  },
                  child: const Icon(Icons.filter_list),
                ),
              ]
            ),
            const SizedBox(height: 20),
            // Real Store Items
            Expanded(
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 16,
                  crossAxisSpacing: 16,
                  childAspectRatio: 0.8,
                ),
                itemCount: DummyHelper.products.length,
                itemBuilder: (context, index) {
                  final product = DummyHelper.products[index];
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        PageRouteBuilder(
                          pageBuilder: (context, animation, secondaryAnimation) {
                            return ProductDetailPage(product: product);
                          },
                          transitionsBuilder: (context, animation, secondaryAnimation, child) {
                            const begin = Offset(1.0, 0.0);
                            const end = Offset.zero;
                            const curve = Curves.easeInOut;
                            var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
                            var offsetAnimation = animation.drive(tween);
                            return SlideTransition(
                              position: offsetAnimation,
                              child: child,
                            );
                          },
                          transitionDuration: const Duration(milliseconds: 500),
                        ),
                      );
                    },
                    child: Card(
                      elevation: 4,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          // Image takes most of the space
                          Expanded(
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(8.0),
                              child: Image.asset(
                                product.images[0], // Assuming the first image in the list represents the product
                                fit: BoxFit.contain,
                              ),
                            ),
                          ),
                          // Title and Price
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  product.name,
                                  style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  '\u{00A3}${product.price.toStringAsFixed(2)}',
                                  style: const TextStyle(
                                    fontSize: 14,
                                    color: Colors.green,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: Stack(
        children: <Widget>[
          FloatingActionButton(
            onPressed: () {
              // Navigate to the checkout page here
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const CartPage()), // Replace CheckoutPage with your actual checkout page widget
              );
            },
            backgroundColor: Colors.black87,
            child: const Icon(Icons.shopping_cart), // Shopping cart icon
          ),
          if (cartCount > 0) // Show the cart count only if it's greater than 0
            Positioned(
              right: 0,
              top: 0,
              child: Container(
                padding: const EdgeInsets.all(4),
                decoration: BoxDecoration(
                  color: Colors.red,
                  borderRadius: BorderRadius.circular(10),
                ),
                constraints: const BoxConstraints(
                  minWidth: 20,
                  minHeight: 20,
                ),
                child: Center(
                  child: Consumer<Cart>(
                    builder: (context, cart, child) {
                      int cartItemCount = cart.itemsInCart;
                      return Text(
                        '$cartItemCount',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      );
                    },
                  ),
                ),
              ),
            ),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat, // Positioning the FAB
    );
  }
}
