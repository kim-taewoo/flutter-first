import 'package:flutter/material.dart'; // flum 까지 치면 자동완성

class ProductEditPage extends StatefulWidget {
  final Function addProduct;
  final Function updateProduct;
  final Map<String, dynamic> product;
  final int productIndex;

  ProductEditPage({this.addProduct, this.updateProduct, this.product, this.productIndex});

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

  void _submitForm() {
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

    if (widget.product == null) {
      widget.addProduct(_formData);      
    } else {
      widget.updateProduct(widget.productIndex, _formData);
    }
    Navigator.pushReplacementNamed(context, '/products');
  }

  @override
  Widget build(BuildContext context) {
    final double deviceWidth = MediaQuery.of(context).size.width;
    final double targetWidth = deviceWidth > 550.0 ? 500 : deviceWidth * 0.95;
    final double targetPadding = deviceWidth - targetWidth;
    final Widget pageContent = Container(
      margin: EdgeInsets.all(15),
      child: Form(
        key: _formKey,
        child: ListView(
          padding: EdgeInsets.symmetric(horizontal: targetPadding / 2),
          children: <Widget>[
            TextFormField(
              decoration: InputDecoration(labelText: '상품명'),
              initialValue: widget.product == null ? '' : widget.product['title'],
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
              initialValue: widget.product == null ? '' : widget.product['description'],
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
              initialValue: widget.product == null
                  ? ''
                  : widget.product['price'].toString(),
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
            OutlineButton(
              // color: Theme.of(context).errorColor,
              textColor: Colors.red,
              child: Text('등록'),
              onPressed: _submitForm,
            )
            // Text(titleValue)
          ],
        ),
      ),
    );

    return widget.product == null
        ? pageContent
        : Scaffold(
            appBar: AppBar(
              title: Text('Edit Product'),
            ),
            body: pageContent,
          );

    // Center(
    //   child: RaisedButton(
    //     child: Text('저장하기'),
    //     onPressed: () {
    //       showModalBottomSheet(
    //           context: context,
    //           builder: (BuildContext context) {
    //             return Center(
    //               child: Text('모달이에용'),
    //             );
    //           });
    //     },
    //   ),
    // );
  }
}