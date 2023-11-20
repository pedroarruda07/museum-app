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
    Product(
      name: 'The Ultimate Dinosaur Glow in the Dark Sticker Book',
      images: [
        Constants.book1,
        Constants.book2,
        Constants.book3,
      ],
      information: [
        "by Melanie Halton",
        "ISBN 9780751344387",
        "60 reusable stickers",
        "16 pages",
        "paperback",
        "21.5cm x 28cm"
      ],
      description: "Create prehistoric scenes and decorate cards and notebooks with these wonderful glow in the dark stickers. They feature eye-catching feathers, dynamic posing, fossils and skeletons, and use a mix of photography, computer-renders and artwork. They're easy to peel and reusable too.",
      price: 3.99,
    ),
    Product(
      name: 'Dinosaur Skeletons Scarf for Kids',
      images: [
        Constants.scarf1,
        Constants.scarf2,
        Constants.scarf3,
        Constants.scarf4,
      ],
      information: [
        "exclusive design",
        "one size: L140cm x W21cm",
        "made from GRS-certified, 100% recycled yarn",
        "250g"
      ],
      description: "Wrap yourself up in a herd of tyrannosaurs, titanosaurs and stegosaurs with this terrifically toasty scarf. It's festive green, red and white pattern has been designed just for us and matches (clashes?) brilliantly with the Christmas jumper if you're going full dino this season!\n\n"
      "It's been knitted with a yarn made entirely from recycled material certified by the Global Recycled Standard (GRS) - a soft blend of recycled cotton (off-cuts from the textile industry) and polyester made from recycled plastic bottles.",
      price: 18.00,
    ),
    Product(
      name: 'Monopoly Dinosaurs Board Game',
      images: [
        Constants.monopoly1,
        Constants.monopoly2,
        Constants.monopoly3,
        Constants.monopoly4,
        Constants.monopoly5,
        Constants.monopoly6,
      ],
      information: [
        "suitable for ages 8+",
        "2-6 players",
        "includes 6 bespoke tokens",
        "includes 28 title deed cards",
        "includes 16 chance cards",
        "includes 16 community chest cards",
        "includes 1 pack of monopoly money",
        "includes 32 green houses",
        "includes 12 red hotels",
        "includes 2 dice",
        "includes instructions",
        "box dimensions: L40cm x W26.5cm x D5cm",
        "box weight: 1.1kg"
      ],
      description: "Which dinosaurs will you uncover?\n\n"
        "Live the life of a globe-trotting scientist in the field of palaeontology. Travel the Mesozoic Era collecting dino-discoveries as you go. Dinosaur sites, continents and discoveries are all up for grabs.\n\n"
        "Lay claim to each dinosaur fossil, and leave tents and jeeps on your fascinating discoveries. Then watch the rent come pouring in as you make deals with other palaeontologists and explore excavation sites and laboratories.\n\n"
        "But stay sharp, because there's only room for one professor of palaeontology... will that be you?",
      price: 35.00
    ),
    Product(
      name: 'Titanosaur Fossil Mug',
      images: [
        Constants.mug1,
        Constants.mug2,
      ],
      information: [
        "exclusive to the Museum",
        "box packaging: H105mm, W105mm x D85mm",
        "342g",
        "ceramic",
        "dishwasher safe",
        "microwave safe",
        "capacity: 300ml",
        "dimensions: H9cm x W8cm"
      ],
      description: "Pour yourself a colossal cuppa in this white and orange mug, featuring a black skeleton design of one of the largest creatures ever to have walked the Earth, and the words: Titanosaur: Life as the Biggest Dinosaur.\n\n"
        "This is the name of the new exhibition at the Museum, which tells the story of how Patagotitan mayorum thrived and survived millions of years ago. Why not book tickets to come and see it? ",
      price: 8.00
    )
  ];

}