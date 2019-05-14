import 'package:scoped_model/scoped_model.dart';

import '../models/product.dart';

// Model 은 scoped_model 에서 옴
// Widget 안에 있는 것이 아니기 때문에 setState 는 다 지운다.
class ProductsModel extends Model {
  List<Product> _products = [];
  int _selectedProductIndex;

  // getters 를 설정하는 과정. myProductsModel.products  (괄호가 없어야 한다.) 같이 쓰는 걸 가능하게 해준다.
  List<Product> get products {
    return List.from(_products);
    // _products 를 복사해서 줌으로써 original _products 의 복사본에만 접근할 수 있게 한다.
    // 왜 굳이 복사본을 만드냐면, 직접 수정하는 게 목적이 아니라 Model 을 활용해 관리하는 게 목적이기 때문이다.
  }

  int get selectedProductIndex {
    return _selectedProductIndex;
  }

  Product get selectedProduct {
    if (_selectedProductIndex == null) {
      return null;
    }
    return _products[_selectedProductIndex];
  }

  // void _addProduct(Map<String, dynamic> productData) {
  void addProduct(Product product) {
    _products.add(product);
    _selectedProductIndex = null;
  }

  void updateProduct(Product product) {
    _products[_selectedProductIndex] = product;
    _selectedProductIndex = null;
  }

  void deleteProduct() {
    _products.removeAt(_selectedProductIndex);
    _selectedProductIndex = null;
  }

  void selectProduct(int index) {
    _selectedProductIndex = index;
  }
}
