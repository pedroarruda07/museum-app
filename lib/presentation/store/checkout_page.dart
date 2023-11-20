import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../data/product.dart';
import '../../providers/cart_provider.dart';

class CheckoutPage extends StatefulWidget {
  const CheckoutPage({super.key});

  @override
  _CheckoutPageState createState() => _CheckoutPageState();
}

class _CheckoutPageState extends State<CheckoutPage> {
  bool fastShipping = false;
  double fastShippingCost = 9.99;


  @override
  Widget build(BuildContext context) {
    Map<Product, int> cartItems = Provider.of<Cart>(context).cart;
    double cartTotal = Provider.of<Cart>(context).cartTotal;
    double totalPrice = fastShipping ? cartTotal + fastShippingCost : cartTotal;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black87,
        title: const Text(
          'Checkout',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Address details section
              buildSectionTitle('Address Details'),
              buildHorizontalDivider(),
              // Placeholder for address form fields
              // Replace with your actual address form fields
              buildPlaceholderText('Address Line 1:', 'Placeholder'),
              buildPlaceholderText('Address Line 2:', 'Placeholder'),
              buildPlaceholderText('City:', 'Placeholder'),
              buildPlaceholderText('State:', 'Placeholder'),
              buildPlaceholderText('Zip Code:', 'Placeholder'),
              SizedBox(height: 20),
              // Shipping options section
              buildSectionTitle('Shipping Options'),
              buildHorizontalDivider(),
              // Checkbox for fast or standard shipping
              Row(
                children: [
                  Checkbox(
                    value: fastShipping, // Replace with your actual shipping selection logic
                    onChanged: (newValue) {
                      setState(() {
                        fastShipping = newValue ?? false;
                      });
                    },
                    checkColor: Colors.white,

                  ),
                  Text('Fast Shipping'),
                  Spacer(), // This will push the text to the far right
                  Text(
                    '+ \u{00A3}${fastShippingCost}', // Replace with your set amount of money
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.green,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20),
              // Order details section
              buildSectionTitle('Order Details'),
              SizedBox(height: 10),
              buildHorizontalDivider(),
              SizedBox(height: 10),
              // Horizontal scrollable product list (Replace with your actual product list)
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    for (var entry in cartItems.entries)
                      ProductItemWidget(
                        product: entry.key,
                        quantity: entry.value,
                      ),
                    // Product items (Replace with your actual product widgets)
                    // Add more ProductItemWidget() as needed for each product
                  ],
                ),
              ),
              SizedBox(height: 20),
              // Payment details section
              buildSectionTitle('Payment Details'),
              buildHorizontalDivider(),
              // Placeholder for payment information
              // Replace with your actual payment form fields
              buildPlaceholderText('Card Number:', 'Placeholder'),
              buildPlaceholderText('Expiration Date:', 'Placeholder'),
              buildPlaceholderText('CVV:','Placeholder'),

              SizedBox(height: 20),
              // Custom total price layout
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Total:',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    '\u{00A3}${totalPrice.toStringAsFixed(2)}',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.green,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20),
              // Button to place the order
              ElevatedButton(
                onPressed: () {
                  // Implement logic to place the order
                },
                child: Text('Place Order'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildSectionTitle(String title) {
    return Text(
      title,
      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
    );
  }

  Widget buildHorizontalDivider() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      height: 1,
      color: Colors.grey,
    );
  }

  Widget buildPlaceholderText(String label, String placeholder) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        Expanded(
          child: Text(
            placeholder,
            textAlign: TextAlign.end,
            style: TextStyle(
              fontSize: 16,
            ),
          ),
        ),
      ],
    );
  }
}

// Example placeholder widget for a product item
class ProductItemWidget extends StatelessWidget {
  final Product? product;
  final int? quantity;
  const ProductItemWidget({super.key, this.product, this.quantity});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 8.0),
      width: 120.0,
      height: 160.0, // Increased height to accommodate the total price text
      decoration: BoxDecoration(
        color: Colors.grey[300],
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Display product image or placeholder
          SizedBox(
            width: 100,
            height: 80,
            child: Image.asset(
              product!.images[0],
              fit: BoxFit.cover,
            ),
          ),
          // Display product name
          Text(
            product?.name ?? 'Product Name',
            style: TextStyle(fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          // Display product price per unit and quantity
          Column(
            children: [
              Text(
                'Price/Unit: \$${product?.price ?? 0.0}',
                style: TextStyle(fontSize: 14),
                textAlign: TextAlign.center,
              ),
              Text(
                'Quantity: ${quantity ?? 1}',
                style: TextStyle(fontSize: 14),
                textAlign: TextAlign.center,
              )
            ],
          ),
        ],
      ),
    );
  }
}
