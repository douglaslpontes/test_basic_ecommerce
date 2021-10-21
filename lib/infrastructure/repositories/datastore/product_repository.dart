import 'package:framework_test/domain/entities/product.dart';
import 'package:framework_test/infrastructure/repositories/datastore.dart';
import 'package:framework_test/infrastructure/repositories/datastore/db_config.dart';
import 'package:framework_test/utils/mapping_db.dart';

/// create a sqlite product repository
ProductRepository newProductRepository() {
  return _ProductRepository();
}

///
class _ProductRepository extends ProductRepository {
  @override
  Future<List<Product>> getProductList() async {
    var _db = await DBManager.db();

    var list = await _db.query(ProductConstants.tableName);

    return list.map((map) => Product.fromMap(map)).toList();
  }
}