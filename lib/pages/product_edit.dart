import 'package:flutter/material.dart';
//import './image.dart';

class ProductEditPage extends StatefulWidget {
  final Function addProduct;
  final Function updateProduct;
  final Map<String, dynamic> products;
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

  Widget _buildTitleTextField() {
    return TextFormField(
      initialValue: widget.products == null ? '' : widget.products['title'],
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

  Widget _buildDescriptionTextField() {
    return TextFormField(
      initialValue:
          widget.products == null ? '' : widget.products['description'],
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

  Widget _buildPriceTextField() {
    return TextFormField(
      initialValue:
          widget.products == null ? '' : widget.products['price'].toString(),
      validator: (String value) {
        if (value.isEmpty ||
            !RegExp(r'^(?:[1-9]\d*|0)?(?:\.\d+)?$').hasMatch(value)) {
          return 'Price is required and should be anumber.';
        } else {}
      },
      keyboardType: TextInputType.number,
      decoration: InputDecoration(labelText: 'Product Price'),
      onSaved: (String value) {
        _formData['price'] = double.parse(value);
      },
    );
  }

  Widget _buildProductContent() {
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
              _buildTitleTextField(),
              _buildDescriptionTextField(),
              _buildPriceTextField(),
              SizedBox(
                height: 10.0,
              ),
              //ImageInput(),
              SizedBox(height: 10.0),
              /*RaisedButton(
            child: Text('Save'),
            textColor: Colors.white,
            onPressed: _submitForm,
          )*/
              GestureDetector(
                child: Container(
                  padding:
                      EdgeInsets.symmetric(horizontal: 25.0, vertical: 10.0),
                  child: Text('Save'),
                  color: Colors.green,
                ),
                onTap: _submitForm,
              )
            ],
          ),
        ),
      ),
    );
  }

  void _submitForm() {
    if (!_fomKey.currentState.validate()) {
      return;
    }
    ;
    _fomKey.currentState.save();
    if (widget.products == null) {
      widget.addProduct(_formData);
    } else {
      widget.updateProduct(widget.index, _formData);
    }
    Navigator.pushReplacementNamed(context, '/products');
  }

  @override
  Widget build(BuildContext context) {
    final Widget productContent = _buildProductContent();
    return widget.products == null
        ? productContent
        : Scaffold(
            appBar: AppBar(
              title: Text('Edit Product'),
            ),
            body: productContent,
          );
  }
}
