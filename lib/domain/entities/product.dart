import 'package:framework_test/utils/mapping_db.dart';

class Product {
  /// Default constructor
  Product({
    required this.description,
    required this.price,
    required this.imageUrl,
    required this.id
  });
  
  /// from database
  Product.fromMap(Map<String, dynamic> map) :
  id = map[ProductConstants.id],
  description = map[ProductConstants.description],
  price = map[ProductConstants.price],
  imageUrl = map[ProductConstants.image_url];

  int id;
  String description;
  double price;
  String imageUrl;
}