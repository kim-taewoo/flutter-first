import 'dart:convert';

// import 'package:scoped_model/scoped_model.dart';
import 'package:http/http.dart' as http;

import '../models/product.dart';
import './connected_products.dart';

// Model 은 scoped_model 에서 옴
// Widget 안에 있는 것이 아니기 때문에 setState 는 다 지운다.
mixin ProductsModel on ConnectedProductsModel {
  bool _showFavorites = false;

  // getters 를 설정하는 과정. myProductsModel.products  (괄호가 없어야 한다.) 같이 쓰는 걸 가능하게 해준다.
  List<Product> get allProducts {
    return List.from(products);
    // _products 를 복사해서 줌으로써 original _products 의 복사본에만 접근할 수 있게 한다.
    // 왜 굳이 복사본을 만드냐면, 직접 수정하는 게 목적이 아니라 Model 을 활용해 관리하는 게 목적이기 때문이다.
  }

  List<Product> get displayedProducts {
    if (_showFavorites) {
      return products.where((Product product) => product.isFavorite).toList();
    }
    return List.from(products);
  }

  int get selectedProductIndex {
    return selProductIndex;
  }

  Product get selectedProduct {
    if (selProductIndex == null) {
      return null;
    }
    return products[selProductIndex];
  }

  bool get displayFavoritesOnly {
    return _showFavorites;
  }

  Future<Null> updateProduct(
      String title, String description, String image, double price) {
    isLoadingStatus = true;
    notifyListeners();
    final Map<String, dynamic> updateData = {
      'title': title,
      'description': description,
      'image':
          'http://health.chosun.com/site/data/img_dir/2015/08/26/2015082601109_0.jpg',
      'price': price,
      'userEmail': selectedProduct.userEmail,
      'userId': selectedProduct.userId,
    };
    return http
        .put(
            'https://flutter-first-project-f49da.firebaseio.com/products/${selectedProduct.uid}.json',
            body: json.encode(updateData))
        .then((http.Response response) {
      isLoadingStatus = false;
      final Product updatedProduct = Product(
        uid: selectedProduct.uid,
        title: title,
        description: description,
        image: image,
        price: price,
        userEmail: selectedProduct.userEmail,
        userId: selectedProduct.userId,
      );
      products[selectedProductIndex] = updatedProduct;
      notifyListeners();
    });
  }

  void deleteProduct() {
    isLoadingStatus = true;
    final deletedProductId = selectedProduct.uid;
    products.removeAt(selectedProductIndex);
    selProductIndex = null;
    notifyListeners();
    http
        .delete(
            'https://flutter-first-project-f49da.firebaseio.com/products/${deletedProductId}.json')
        .then((http.Response response) {
          isLoadingStatus = false;
          notifyListeners();
    });
  }

  Future<Null> fetchProducts() {
    isLoadingStatus = true;
    return http
        .get('https://flutter-first-project-f49da.firebaseio.com/products.json')
        .then((http.Response response) {
      final List<Product> fetchedProductList = [];
      final Map<String, dynamic> productListData = json.decode(response.body);
      if (productListData == null) {
        isLoadingStatus = false;
        notifyListeners();
        return; // 이래야 아래 코드까지 실행시키질 않지
      }
      productListData.forEach((String productId, dynamic productData) {
        final Product product = Product(
          description: productData['description'],
          image: productData['image'],
          price: productData['price'],
          title: productData['title'],
          uid: productId,
          userEmail: productData['userEmail'],
          userId: productData['userId'],
        );
        fetchedProductList.add(product);
      });
      products = fetchedProductList;
      isLoadingStatus = false;
      notifyListeners();
    });
  }

  void toggleProductFavoriteStatus() {
    final bool isCurrentlyFavorite = selectedProduct.isFavorite;
    final bool newFavoriteStatus = !isCurrentlyFavorite;
    final Product updatedProduct = Product(
      description: selectedProduct.description,
      image: selectedProduct.image,
      price: selectedProduct.price,
      title: selectedProduct.title,
      isFavorite: newFavoriteStatus,
      userEmail: selectedProduct.userEmail,
      userId: selectedProduct.userId,
    );
    products[selectedProductIndex] = updatedProduct;
    notifyListeners(); // 이거 한 줄 써줘야 builder 가 재작동해서 live update 가 된다. (StatefulWidget 의 setState 와 비슷)
  }

  void selectProduct(int index) {
    selProductIndex = index;
    if (index != null) {
      notifyListeners();
    }
  }

  void toggleDisplyMode() {
    _showFavorites = !_showFavorites;
    notifyListeners();
  }
}
