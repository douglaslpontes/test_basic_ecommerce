class ProductConstants {
  static const String tableName = 'tb_product';
  static const String id = 'id';
  static const String description = 'description';
  static const String price = 'price';
  static const String image_url = 'image_url';
}

class CartConstants {
  static const String tableName = 'tb_cart';
  static const String id = 'id';
  static const String created_date = 'created_date';
  static const String checkout_date = 'checkout_date';
}

class CartItemConstants {
  static const String tableName = 'tb_cart_item';
  static const String id = 'id';
  static const String qty = 'qty';
  static const String product_id = 'product_id';
  static const String cart_id = 'cart_id';
}