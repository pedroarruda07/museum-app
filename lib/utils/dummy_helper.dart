import '../data/product.dart';
import 'constants.dart';

class DummyHelper {
  const DummyHelper._();

  // Product Data
  static final List<Product> products = [
    Product(
      name: 'Jurassic Park T. rex Tubbz in a Crate',
      images: [
        Constants.duck1,
        Constants.duck2,
        Constants.duck3,
        Constants.duck4,
        Constants.duck5,
      ],
      information: [
        "suitable for ages 3+",
        "crate-style box packaging exclusive to the Museum",
        "L12.5cm x H9cm x W10.5cm",
        "180g",
        "made from vinyl, PVC and water-based inks"
      ],
      description:
      "The creative team at Tubbz have brilliantly captured the Jurassic Park's T. rex and transformed it into this new hybrid dinosaur-duck to add to your collection - or to start one.\n\n"
          "They've also managed to capture the mini giant in its own crate-style packaging - exclusively available at the Museum - for safe transit to its destination.",
      price: 20.00,
    ),
    Product(
      name: 'Jurassic Park Lamp',
      images: [
        Constants.lamp1,
        Constants.lamp2,
        Constants.lamp3,
        Constants.lamp4,
      ],
      information: [
        "suitable for ages 3+",
        "W25.5cm x H21cm x D8.5cm",
        "480g",
        "powered by 3 x AA batteries (not included) or micro USB cable (included)",
        "desk/shelf lamp or wall mountable"
      ],
      description:
      "A great gift for the ultimate Jurassic Park fan, this 3D square-shaped moulded lamp features the instantly recognisable logo.\n\n"
          "It can either be charged via a USB cable or battery powered and will look right at home on a desktop, among a jungle of plants on a shelf, mounted on the wall in a bedroom - or garden shed.",
      price: 20.00,
    ),
  ];

}