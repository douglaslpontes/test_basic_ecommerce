import 'package:framework_test/utils/mapping_db.dart';

///
class Cart {
  /// default constructor
  Cart({
    required this.createdDate,
    required this.id,
    this.checkoutDate
  });

  /// from database
  Cart.fromMap(Map<String, dynamic> map) : 
  id = map[CartConstants.id],
  createdDate = DateTime.fromMillisecondsSinceEpoch(int.parse(map[CartConstants.created_date])),
  checkoutDate = map[CartConstants.checkout_date] != null ? DateTime.fromMillisecondsSinceEpoch(int.parse(map[CartConstants.checkout_date])) : null;

  int id;
  DateTime createdDate;
  DateTime? checkoutDate;
}