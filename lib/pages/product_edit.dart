import 'package:flutter/material.dart'; // flum 까지 치면 자동완성

import 'package:scoped_model/scoped_model.dart';

import '../models/product.dart';
import '../scoped-models/main.dart';

class ProductEditPage extends StatefulWidget {
  // final Function addProduct;
  // final Function updateProduct;
  // // final Map<String, dynamic> product;
  // final Product product;
  // final int productIndex;

  // ProductEditPage(
  //     {this.addProduct, this.updateProduct, this.product, this.productIndex});

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
    'image': 'assets/food.jpg'
  };
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  void _submitForm(
      Function addProduct, Function updateProduct, Function setSelectedProduct,
      [int selectedProductIndex]) {
    if (!_formKey.currentState.validate()) {
      return;
    }
    _formKey.currentState.save();
    // final Map<String, dynamic> product = {
    //   'title': _titleValue,
    //   'description': _descriptionValue,
    //   'price': _priceValue,
    //   'image': 'assets/food.jpg'
    // };

    if (selectedProductIndex == -1) {
      addProduct(
        _formData['title'],
        _formData['description'],
        _formData['image'],
        _formData['price'],
      ).then((bool success) {
        if (success) {
          Navigator.pushReplacementNamed(context, '/products')
              .then((_) => setSelectedProduct(null));
        } else {
          showDialog(
              context: context, // 이 context는 그냥 build 에 있었다고 생각하면 된다.
              builder: (BuildContext context) {
                return AlertDialog(
                  title: Text('Someting went wrong'),
                  content: Text('Please try again!'),
                  actions: <Widget>[
                    FlatButton(
                      onPressed: () => Navigator.of(context).pop(),
                      child: Text('Okay'),
                    )
                  ],
                );
              });
        }
      });
    } else {
      updateProduct(
        _formData['title'],
        _formData['description'],
        _formData['image'],
        _formData['price'],
      ).then((_) => Navigator.pushReplacementNamed(context, '/products')
          .then((_) => setSelectedProduct(null)));
    }
  }

  Widget _buildSubmitButton() {
    return ScopedModelDescendant<MainModel>(
      builder: (BuildContext context, Widget child, MainModel model) {
        return model.isLoading
            ? Center(child: CircularProgressIndicator())
            : OutlineButton(
                // color: Theme.of(context).errorColor,
                textColor: Colors.red,
                child: Text('등록'),
                // _submitForm 을 또다시 화살표 함수로 감싸줌으로써, onPressed 가 눌려졌을 때만 _submitForm 을 호출하게 한다.
                onPressed: () => _submitForm(
                    model.addProduct,
                    model.updateProduct,
                    model.selectProduct,
                    model.selectedProductIndex),
              );
      },
    );
  }

  Widget _buildPageContent(BuildContext context, Product product) {
    final double deviceWidth = MediaQuery.of(context).size.width;
    final double targetWidth = deviceWidth > 550.0 ? 500 : deviceWidth * 0.95;
    final double targetPadding = deviceWidth - targetWidth;
    return Container(
      margin: EdgeInsets.all(15),
      child: Form(
        key: _formKey,
        child: ListView(
          padding: EdgeInsets.symmetric(horizontal: targetPadding / 2),
          children: <Widget>[
            TextFormField(
              decoration: InputDecoration(labelText: '상품명'),
              initialValue: product == null ? '' : product.title,
              // autovalidate: true,
              validator: (String value) {
                // if (value.trim().length <= 0) {
                if (value.isEmpty || value.length < 5) {
                  return 'Title is required and should be 5+ characters long';
                }
              },
              onSaved: (String value) {
                // setState(() {
                //   _titleValue = value;
                // });
                // 다른 데도 마찬가지지만, 이제 Form 을 쓰니까
                // onSaved 할때 setState() 를 통해 다시 build 를 하는 건 낭비다.
                // 어차피 한 번에 폼 전송하고 끝나는 거니까, 그냥 변수에 저장하기만
                // 하면 되고, 따라서 setState() 를 없애준다.
                _formData['title'] = value;
              },
            ),
            TextFormField(
              decoration: InputDecoration(labelText: '상품 설명'),
              maxLines: 4,
              initialValue: product == null ? '' : product.description,
              validator: (String value) {
                // if (value.trim().length <= 0) {
                if (value.isEmpty || value.length < 10) {
                  return 'Description is required and should be 10+ characters long';
                }
              },
              onSaved: (String value) {
                _formData['description'] = value;
              },
            ),
            TextFormField(
              decoration: InputDecoration(labelText: '가격'),
              keyboardType: TextInputType.number,
              initialValue: product == null ? '' : product.price.toString(),
              validator: (String value) {
                // if (value.trim().length <= 0) {
                if (value.isEmpty ||
                    !RegExp(r'^(?:[1-9]\d*|0)?(?:[.,]\d+)?$').hasMatch(value)) {
                  return 'Price is required and should be numbers';
                }
              },
              onSaved: (String value) {
                _formData['price'] =
                    double.parse(value.replaceFirst(RegExp(r','), '.'));
              },
            ),
            SizedBox(
              height: 10.0,
            ),
            _buildSubmitButton(),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<MainModel>(
      builder: (BuildContext context, Widget child, MainModel model) {
        final Widget pageContent =
            _buildPageContent(context, model.selectedProduct);
        return model.selectedProductIndex == -1
            ? pageContent
            : Scaffold(
                appBar: AppBar(
                  title: Text('Edit Product'),
                ),
                body: pageContent,
              );
      },
    );
  }
}
