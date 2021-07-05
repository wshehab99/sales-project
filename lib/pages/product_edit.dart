import 'package:flutter/material.dart';
//import './image.dart';
import '../modules/product.dart';
import 'package:scoped_model/scoped_model.dart';
import '../scoped-model/Main.dart';

class ProductEditPage extends StatefulWidget {
  final Function addProduct;
  final Function updateProduct;
  final Product products;
  final int index;
  ProductEditPage(
      {this.addProduct, this.updateProduct, this.products, this.index});

  @override
  State<StatefulWidget> createState() {
    return _ProductEditPageState();
  }
}

class _ProductEditPageState extends State<ProductEditPage> {
  final Map<String, dynamic> _formData = {
    'title': null,
    'description': null,
    'price': null,
    'image': 'assets/food.jpg',
  };
  GlobalKey<FormState> _fomKey = GlobalKey<FormState>();

  Widget _buildTitleTextField(Product product) {
    return TextFormField(
      initialValue: product == null ? '' : product.title,
      validator: (String value) {
        if (value.isEmpty || value.length < 5) {
          return 'Title is required and should be more than 5 characters';
        }
      },
      decoration: InputDecoration(labelText: 'Product Title'),
      onSaved: (String value) {
        _formData['title'] = value;
      },
    );
  }

  Widget _buildDescriptionTextField(Product products) {
    return TextFormField(
      initialValue: products == null ? '' : products.description,
      validator: (String value) {
        if (value.isEmpty || value.length < 10) {
          return 'Product description is required and should be more than 10 characters.';
        }
      },
      maxLines: 4,
      decoration: InputDecoration(labelText: 'Product Description'),
      onSaved: (String value) {
        _formData['description'] = value;
      },
    );
  }

  Widget _buildPriceTextField(Product products) {
    return TextFormField(
      keyboardType: TextInputType.number,
      decoration: InputDecoration(labelText: 'Product Price'),
      initialValue: products == null ? '' : products.price.toString(),
      validator: (String value) {
        if (value.isEmpty ||
            !RegExp(r'^(?:[1-9]\d*|0)?(?:\.\d+)?$').hasMatch(value)) {
          return 'Price is required and should be anumber.';
        }
      },
      onSaved: (String value) {
        _formData['price'] = double.parse(value);
      },
    );
  }

  Widget _buildSubmitForm() {
    return ScopedModelDescendant<MainModel>(
        builder: (BuildContext context, Widget child, MainModel model) {
      return RaisedButton(
        child: Text('Save'),
        textColor: Colors.white,
        onPressed: () => _submitForm(model.addProduct, model.updateProduct,
            model.selectProduct, model.selectedProductIndex),
      );
      /* GestureDetector(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 25.0, vertical: 10.0),
          child: Text('Save'),
          color: Colors.green,
        ),
        onTap: () => _submitForm(model.addProduct, model.updateProduct),
      );*/
    });
  }

  Widget _buildProductContent(BuildContext context, Product product) {
    final double deviceWidth = MediaQuery.of(context).size.width;
    final double targetWidth =
        deviceWidth > 550 ? deviceWidth * 0.7 : deviceWidth * 0.95;
    final double targetpadding = deviceWidth - targetWidth;
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: targetpadding / 2),
        margin: EdgeInsets.all(10.0),
        child: Form(
          key: _fomKey,
          child: ListView(
            children: <Widget>[
              _buildTitleTextField(product),
              _buildDescriptionTextField(product),
              _buildPriceTextField(product),
              SizedBox(
                height: 10.0,
              ),
              _buildSubmitForm(),
              // ImageInput(),
              SizedBox(height: 10.0),
            ],
          ),
        ),
      ),
    );
  }

  void _submitForm(
      Function addProduct, Function updateProduct, Function unSelectProduct,
      [int selectedProductIndex]) {
    if (!_fomKey.currentState.validate()) {
      return;
    }
    _fomKey.currentState.save();
    if (selectedProductIndex != null) {
      updateProduct(_formData['title'], _formData['description'],
          _formData['price'], _formData['image']);
    } else {
      addProduct(_formData['title'], _formData['description'],
          _formData['price'], _formData['image']);
    }

    Navigator.pushNamed(context, '/products')
        .then((_) => unSelectProduct(null));
  }

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<MainModel>(
        builder: (BuildContext context, Widget child, MainModel model) {
      final Widget productContent =
          _buildProductContent(context, model.selectedProduct);
      return model.selectedProductIndex == null
          ? productContent
          : Scaffold(
              appBar: AppBar(
                title: Text('Edit Product'),
              ),
              body: productContent,
            );
    });
  }
}
