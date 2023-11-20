import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/cart_provider.dart';
import '../../data/product.dart';
import 'checkout_page.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  bool _isBottomBarVisible = true;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500), // Adjust animation duration as needed
    );

    // Start animation immediately when the widget is built
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Map<Product, int> cartItems = Provider.of<Cart>(context).cart;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black87,
        title: const Text(
          'Cart',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body:  Provider.of<Cart>(context).isCartEmpty ?
        buildNoDataWidget(context) :
        ListView.builder(
        itemCount: cartItems.length,
        itemBuilder: (context, index) {
          final Product item = cartItems.keys.toList()[index];
          final int quantity = cartItems[item] ?? 0;
          return buildCartItem(context, item, quantity);
        },
      ),
      bottomNavigationBar: _buildBottomBar(context),
    );
  }

  Widget buildCartItem(BuildContext context, Product item, int quantity) {
    return Padding(
      padding: EdgeInsets.all(8.0),
      child: Container(
        padding: EdgeInsets.all(12.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12.0),
          border: Border.all(color: Colors.grey),
        ),
        child: Row(
          children: [
            // Item image on the left
            Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8.0),
                image: DecorationImage(
                  image: AssetImage(item.images[0]),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(width: 10),
            // Item details, price, and buttons on the right
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item.name,
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    'Quantity: $quantity',
                    style: TextStyle(fontSize: 16),
                  ),
                  Text(
                    '\$${item.price.toStringAsFixed(2)} each',
                    style: TextStyle(fontSize: 16),
                  ),
                ],
              ),
            ),
            // Buttons for incrementing and decrementing quantity
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  icon: Icon(Icons.remove),
                  onPressed: () {
                    // Decrease the quantity of the item in the cart
                    Provider.of<Cart>(context, listen: false).removeFromCart(item);
                  },
                ),
                IconButton(
                  icon: Icon(Icons.add),
                  onPressed: () {
                    // Increase the quantity of the item in the cart
                    Provider.of<Cart>(context, listen: false).addToCart(item);
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget buildNoDataWidget(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.shopping_cart, color: Colors.grey, size: 120),
          Text(
            'Your cart is empty',
            style: TextStyle(color: Colors.grey, fontSize: 24),
          ),
        ],
      ),
    );
  }

  Widget _buildBottomBar(BuildContext context) {
    final isCartEmpty = Provider.of<Cart>(context).isCartEmpty;

    if (isCartEmpty && _isBottomBarVisible) {
      _animationController.reverse();
      _isBottomBarVisible = false;
    } else if (!isCartEmpty && !_isBottomBarVisible) {
      _animationController.forward();
      _isBottomBarVisible = true;
    }

    return AnimatedContainer(
      duration: Duration(milliseconds: 300),
      height: kBottomNavigationBarHeight,
      child: SlideTransition(
        position: Tween<Offset>(
          begin: Offset(0, 1),
          end: Offset.zero,
        ).animate(_animationController),
        child: BottomAppBar(
          color: Colors.black87,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Total price of the cart on the left
                Padding(
                  padding: const EdgeInsets.only(right: 16.0),
                  child: Text(
                      'Total: \u{00A3}${Provider.of<Cart>(context).cartTotal.toStringAsFixed(2)}', // Replace with your actual total price
                      style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.green)
                  ),
                ),
                // Proceed to checkout button with adjusted padding
                Padding(
                  padding: EdgeInsets.only(left: 8.0),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: Colors.green,
                      onPrimary: Colors.white,
                    ),
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => CheckoutPage()));
                    },
                    child: const Text('Proceed to Checkout'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
