///product_model.dart
class Product {
  final int id;
  final String slug;
  final String name;
  final String description;
  final String category;
  final String subcategory;
  final String image;
  final double price;
  final double offerPrice;
  final String type;
  final int status;
  final String shippingType;

  Product({
    required this.id,
    required this.slug,
    required this.name,
    required this.description,
    required this.category,
    required this.subcategory,
    required this.image,
    required this.price,
    required this.offerPrice,
    required this.type,
    required this.status,
    required this.shippingType,
  });

// Add a factory method to convert JSON to a Product object
  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      slug: json['slug'],
      name: json['name'],
      description: json['description'],
      category: json['category'],
      subcategory: json['subcategory'],
      image: json['image'],
      price: json['price'].toDouble(),
      offerPrice: json['offer_price'].toDouble(),
      type: json['type'],
      status: json['status'],
      shippingType: json['shipping_type'],
    );
  }
}
