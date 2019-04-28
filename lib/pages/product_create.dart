import 'package:flutter/material.dart'; // flum 까지 치면 자동완성

class ProductCreatePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _ProductCreatePageState();
  }
}

class _ProductCreatePageState extends State<ProductCreatePage> {
  String titleValue = '';

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        TextField(
          onChanged: (String value) {
            setState(() {
              titleValue = value;
            });
          },
        ),
        Text(titleValue)
      ],
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
