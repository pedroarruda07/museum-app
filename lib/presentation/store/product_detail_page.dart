import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:provider/provider.dart';
import '../../providers/cart_provider.dart';

import '../../data/product.dart';

class ProductDetailPage extends StatefulWidget {
  final Product product;

  const ProductDetailPage({super.key, required this.product});

  @override
  State<ProductDetailPage> createState() => _ProductDetailPageState();
}

class _ProductDetailPageState extends State<ProductDetailPage> with SingleTickerProviderStateMixin {
  int _currentImageIndex = 0;

  final TextStyle productNameStyle = const TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Colors.black87);
  final TextStyle descriptionStyle = TextStyle(fontSize: 18, color: Colors.grey[700]);
  final TextStyle priceStyle = const TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.green);

  final Color activeIndicatorColor = Colors.blue;
  final Color inactiveIndicatorColor = Colors.grey;

  late AnimationController _controller;
  late Animation<double> _animation;
  bool _isAnimationReady = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    _animation = Tween<double>(
      begin: 1,
      end: 0,
    ).animate(_controller);

    // Trigger the animation when the screen is built
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _controller.forward();
      setState(() {
        _isAnimationReady = true;
      });
    });
  }

  @override
  void dispose() {
    _controller.reverse().whenComplete(() {
      _controller.dispose();
      super.dispose();
    });
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final appBarHeight = AppBar().preferredSize.height;
    final screenHeight = MediaQuery.of(context).size.height * 0.5;
    final carouselHeight = screenHeight - appBarHeight;

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
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8.0),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.3),
                    spreadRadius: 2,
                    blurRadius: 5,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  CarouselSlider(
                    items: widget.product.images.map((image) {
                      return Image.asset(image, fit: BoxFit.cover);
                    }).toList(),
                    options: CarouselOptions(
                      height: carouselHeight,
                      viewportFraction: 1.0,
                      enableInfiniteScroll: true,
                      autoPlay: false,
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
                  Text(
                    widget.product.name,
                    style: productNameStyle,
                  ),
                  const SizedBox(height: 30),
                  // Product Description
                  Text(
                    widget.product.description,
                    style: descriptionStyle
                  ),
                  const SizedBox(height: 50),
                  if (widget.product.information.isNotEmpty)
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Specifications',
                          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 10),
                        for (var spec in widget.product.information)
                          Text(
                            '- $spec',
                            style: descriptionStyle,
                          ),
                        const SizedBox(height: 20),
                      ],
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: _isAnimationReady
          ? AnimatedBuilder(
        animation: _animation,
        builder: (context, child) {
          return SlideTransition(
            position: Tween<Offset>(
              begin: const Offset(0.0, 1.0),
              end: Offset.zero,
            ).animate(_controller),
            child: child,
          );
        },
        child: BottomAppBar(
          color: Colors.black87,
          child: Padding(
            padding:
            const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '\u{00A3}${widget.product.price.toStringAsFixed(2)}',
                  style: priceStyle,
                ),
                ElevatedButton(
                  onPressed: () {
                    context.read<Cart>().addToCart(widget.product);
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Added to cart'),
                        duration: Duration(seconds: 1),
                      ),
                    );
                  },
                  child: const Text('Add to Cart'),
                ),
              ],
            ),
          ),
        ),
      )
          : const SizedBox.shrink(),
    );
  }
}
