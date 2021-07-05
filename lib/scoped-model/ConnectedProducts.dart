import 'package:scoped_model/scoped_model.dart';
import '../modules/product.dart';
import '../modules/User.dart';

mixin ConnectedProducts on Model {
  List<Product> _products = [];
  int _selectProductIndex;
  User _authentication;
  void addProduct(
      String title, String description, double price, String image) {
    Product product = new Product(
        title: title,
        description: description,
        price: price,
        image: image,
        userEmail: _authentication.email,
        userId: _authentication.name);
    _products.add(product);
  }
}
mixin ProductModel on ConnectedProducts {
  bool _showFavorites = false;
  List<Product> get allProducts {
    return List.from(_products);
  }

  bool get showFavorites {
    return _showFavorites;
  }

  Product get selectedProduct {
    if (_selectProductIndex == null) {
      return null;
    } else {
      return _products[_selectProductIndex];
    }
  }

  List<Product> get displayedProduct {
    if (_showFavorites) {
      return _products.where((Product product) => product.isFavorite).toList();
    }
    return List.from(_products);
  }

  int get selectedProductIndex {
    return _selectProductIndex;
  }

  void updateProduct(
      String title, String description, double price, String image) {
    Product updatedproduct = new Product(
        title: title,
        description: description,
        price: price,
        image: image,
        userEmail: selectedProduct.userEmail,
        userId: selectedProduct.userEmail);
    _products[_selectProductIndex] = updatedproduct;
  }

  void deleteProduct() {
    _products.removeAt(_selectProductIndex);
    notifyListeners();
  }

  void toggleFavorite() {
    final bool currentState = selectedProduct.isFavorite;
    final bool toglledState = !currentState;
    final Product updatedProduct = Product(
        title: selectedProduct.title,
        description: selectedProduct.description,
        price: selectedProduct.price,
        image: selectedProduct.image,
        userEmail: selectedProduct.userEmail,
        userId: selectedProduct.userId,
        isFavorite: toglledState);
    _products[_selectProductIndex] = updatedProduct;
    notifyListeners();
  }

  void selectProduct(int index) {
    _selectProductIndex = index;
    if (index != null) {
      notifyListeners();
    }
  }

  void toggleShowFavorite() {
    _showFavorites = !_showFavorites;
    notifyListeners();
  }
}

mixin UserModel on ConnectedProducts {
  void login(String email, String password) {
    _authentication =
        User(name: "jhtfaa;oifjk", email: email, password: password);
  }
}
