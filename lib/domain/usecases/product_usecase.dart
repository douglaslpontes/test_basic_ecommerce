import 'package:framework_test/domain/domain.dart';
import 'package:framework_test/domain/entities/product.dart';
import 'package:framework_test/infrastructure/repositories/datastore.dart';

/// Create a locale use case
ProductUsecase newProductUsecase(ProductRepository repo) => _ProductUsecase(repo);

class _ProductUsecase extends ProductUsecase {
  _ProductUsecase(this.repo);
  final ProductRepository repo;

  @override
  Future<List<Product>> getProductList() => repo.getProductList();
  
}