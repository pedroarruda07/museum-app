import 'package:flutter/material.dart';

class CheckoutPage extends StatelessWidget {
  const CheckoutPage({super.key});

  @override
  Widget build(BuildContext context) {

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
              buildPlaceholderText('Address Line 1: Placeholder'),
              buildPlaceholderText('Address Line 2: Placeholder'),
              buildPlaceholderText('City: Placeholder'),
              buildPlaceholderText('State: Placeholder'),
              buildPlaceholderText('Zip Code: Placeholder'),
              SizedBox(height: 20),
              // Shipping options section
              buildSectionTitle('Shipping Options'),
              buildHorizontalDivider(),
              // Checkbox for fast or standard shipping
              Row(
                children: [
                  Checkbox(
                    value: false, // Replace with your actual shipping selection logic
                    onChanged: (newValue) {
                      // Handle shipping option selection
                    },
                  ),
                  Text('Fast Shipping'),
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
                    // Product items (Replace with your actual product widgets)
                    ProductItemWidget(), // Example placeholder widget
                    ProductItemWidget(), // Example placeholder widget
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
              buildPlaceholderText('Card Number: Placeholder'),
              buildPlaceholderText('Expiration Date: Placeholder'),
              buildPlaceholderText('CVV: Placeholder'),
              // Add more payment-related fields as needed
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

  Widget buildPlaceholderText(String text) {
    return Text(text);
  }
}

// Example placeholder widget for a product item
class ProductItemWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right: 10),
      width: 100,
      height: 100,
      color: Colors.blueGrey,
      child: Center(child: Text('Product')),
    );
  }
}
