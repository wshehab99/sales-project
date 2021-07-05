import 'package:scoped_model/scoped_model.dart';
import 'ConnectedProducts.dart';

class MainModel extends Model with ConnectedProducts, ProductModel, UserModel {}
