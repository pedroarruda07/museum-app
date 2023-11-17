import 'package:flutter/material.dart';
import 'package:ipm_project/presentation/store/product_detail_page.dart';

import '../../data/product.dart';

class StorePage extends StatelessWidget {
  const StorePage({super.key});

  // Product Data
  static final List<Product> products = [
    Product(
      name: 'Jurassic Park T. rex Tubbz in a Crate',
      images: [
        'assets/images/store_products/duck1.jpg',
        'assets/images/store_products/duck2.jpg',
        'assets/images/store_products/duck3.jpg',
        'assets/images/store_products/duck4.jpg',
        'assets/images/store_products/duck5.jpg'
      ],
      description:
          "The creative team at Tubbz have brilliantly captured the Jurassic Park's T. rex and transformed it into this new hybrid dinosaur-duck to add to your collection - or to start one.\n\n"
          "They've also managed to capture the mini giant in its own crate-style packaging - exclusively available at the Museum - for safe transit to its destination.\n\n",
      price: 20.00,
      reviews: ['Good product', 'Excellent quality'],
    ),
    Product(
      name: 'Jurassic Park Lamp',
      images: [
        'assets/images/store_products/lamp1.jpg',
        'assets/images/store_products/lamp2.jpg',
        'assets/images/store_products/lamp3.jpg',
        'assets/images/store_products/lamp4.jpg',
        'assets/images/store_products/lamp5.jpg'
      ],
      description:
          "A great gift for the ultimate Jurassic Park fan, this 3D square-shaped moulded lamp features the instantly recognisable logo.\n\n"
          "It can either be charged via a USB cable or battery powered and will look right at home on a desktop, among a jungle of plants on a shelf, mounted on the wall in a bedroom - or garden shed.\n\n",
      price: 20.00,
      reviews: ['Good product', 'Excellent quality'],
    ),
  ];

  @override
  Widget build(BuildContext context) {
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
            // Search Bar
            TextFormField(
              decoration: InputDecoration(
                labelText: 'Search products',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
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
                itemCount: products.length,
                itemBuilder: (context, index) {
                  final product = products[index];
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ProductDetailPage(product: product),
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
                                fit: BoxFit.cover,
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
    );
  }
}
