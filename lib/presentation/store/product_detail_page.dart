import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

import '../../data/product.dart';

class ProductDetailPage extends StatefulWidget {
  final Product product;

  const ProductDetailPage({super.key, required this.product});

  @override
  State<ProductDetailPage> createState() => _ProductDetailPageState();
}


class _ProductDetailPageState extends State<ProductDetailPage> {
  int _currentImageIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Product Details'),
        backgroundColor: Colors.black87,
        // Add more app bar actions or icons if needed
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Image Carousel with Indicators
            CarouselSlider(
              items: widget.product.images.map((image) {
                return Image.asset(image, fit: BoxFit.cover);
              }).toList(),
              options: CarouselOptions(
                aspectRatio: 16 / 9,
                viewportFraction: 0.9,
                enableInfiniteScroll: false,
                autoPlay: false,
                //autoPlayInterval: Duration(seconds: 3),
                //autoPlayAnimationDuration: Duration(milliseconds: 800),
                //pauseAutoPlayOnTouch: true,
                enlargeCenterPage: true,
                onPageChanged: (index, reason) {
                  setState(() {
                    _currentImageIndex = index;
                  });
                },
              ),
            ),
            const SizedBox(height: 10),
            // Indicator Dots
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: widget.product.images.map((image) {
                int index = widget.product.images.indexOf(image);
                return Container(
                  width: 8.0,
                  height: 8.0,
                  margin: const EdgeInsets.symmetric(horizontal: 4.0),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: _currentImageIndex == index ? Colors.blue : Colors.grey,
                  ),
                );
              }).toList(),
            ),
            const SizedBox(height: 20),
            // Product Name
            Text(
              widget.product.name,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            // Product Description
            Text(
              widget.product.description,
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 20),
            // Product Price
            Text(
              '\u{00A3}${widget.product.price.toStringAsFixed(2)}',
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.green),
            ),
            const SizedBox(height: 20),
            // Product Specifications
            if (widget.product.information != null && widget.product.information!.isNotEmpty)
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Specifications',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  // Display specifications
                  for (var spec in widget.product.information!)
                    Text(
                      '- $spec',
                      style: const TextStyle(fontSize: 16),
                    ),
                  const SizedBox(height: 20),
                ],
              ),
            // Product Reviews
            if (widget.product.reviews != null && widget.product.reviews!.isNotEmpty)
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Reviews',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  // Display reviews
                  for (var review in widget.product.reviews!)
                    Text(
                      '- $review',
                      style: const TextStyle(fontSize: 16),
                    ),
                  const SizedBox(height: 20),
                ],
              ),
          ],
        ),
      ),
    );
  }
}