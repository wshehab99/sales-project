import 'package:flutter/material.dart';
import 'package:flutter_course/pages/product_edit.dart';
//import '../modules/product.dart';
import 'package:scoped_model/scoped_model.dart';
import '../scoped-model/Main.dart';

class ProductListPage extends StatelessWidget {
  Widget _buildEditButton(BuildContext context, int index, MainModel model) {
    return IconButton(
        icon: Icon(Icons.edit_outlined),
        onPressed: () {
          model.selectProduct(index);
          Navigator.of(context).push(MaterialPageRoute(
            builder: (BuildContext context) {
              return ProductEditPage();
            },
          )).then((_) => model.selectProduct(null));
        });
  }

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<MainModel>(
        builder: (BuildContext context, Widget child, MainModel model) {
      return ListView.builder(
        itemBuilder: (BuildContext context, int index) {
          return Dismissible(
            direction: DismissDirection.endToStart,
            key: Key(model.allProducts[index].title),
            onDismissed: (DismissDirection direction) {
              if (direction == DismissDirection.endToStart) {
                model.selectProduct(index);
                model.deleteProduct();
              }
            },
            background: Container(
              color: Colors.red,
              child: Icon(
                Icons.delete_outline,
                color: Colors.white,
                size: 45.0,
              ),
              alignment: Alignment.centerRight,
            ),
            child: Column(
              children: [
                ListTile(
                  leading: CircleAvatar(
                      backgroundImage: AssetImage(
                    model.allProducts[index].image,
                  )),
                  title: Text(model.allProducts[index].title),
                  subtitle:
                      Text('\LE ${model.allProducts[index].price.toString()}'),
                  trailing: _buildEditButton(context, index, model),
                ),
                Divider(),
              ],
            ),
          );
        },
        itemCount: model.allProducts.length,
      );
    });
  }
}
