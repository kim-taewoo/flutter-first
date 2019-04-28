import 'package:flutter/material.dart';

import './products.dart';
// import './product_control.dart';

class ProductManager extends StatelessWidget {
  final List<Map<String, dynamic>> products;
  // final Function addProduct;
  // final Function deleteProduct;

  ProductManager(this.products);


//   final Map<String, String> startingProduct;
//   // Stateful Widget 이니까 데이터가 외부에 의해 계속 바뀌는데,
//   // 왜 final 을 붙이냐면, 그 '바뀐다' 는 게 이 StatefulWidget 과 연결된 State class 에서 바뀌는 것이기 때문이다.
//   // 어차피 연결된거긴 하지만, 그래도 이 StatefulWidget class 에서가 아닌 State class 에서 변하는 것임을 명심
//   // 즉, State 가 아닌 이 StatefulWidget 의 argument 는 이것의 Parent 가 바뀐 값으로 다시 build 를 해야 바뀐다.

//   // named argument 는 {} 을 써야 한다. 
//   // optional(default) 값을 = 을 이용해서 넣을 수 있다.
//   // ProductManager({this.startingProduct = 'Sweets Tester'}) {
//   ProductManager({this.startingProduct}) {
//     print('[ProductManager Widget] Constructor');
//   }
//   // 이건 그냥 ProductManager 의 argument 를 등록하면서 실행할 게 있으면 실행해주는 함수. 
//   // 아무것도 실행 안 시키고 등록만 시켜도 된다.

//   @override
//   State<StatefulWidget> createState() {
//     print('[ProductManager Widget] createState()');
//     return _ProductManagerState();
//   }
// }


// class _ProductManagerState extends State<ProductManager> {
  // List<Map<String, String>> _products = [];
     
  // // initState() 가 아래의 build 보다 먼저 실행되기 때문에 
  // // rerender 하는 데만 쓰이는 setState() 가 올 필요가 없다. 
  // // 반면에 아래의 _addProduct 의 경우, 언제든 실행될 수 있기 때문에
  // // setState() 를 통해서 추가해주게 된다. 
  // @override
  // void initState() {
  //   super.initState();
  //   if (widget.startingProduct != null) {
  //     _products.add(widget.startingProduct);      
  //   }
  //   print('[ProductManager State] initState()');
  //   // super 는 기본적으로 @override 되기 전의 base class의 함수 값을 가져온다. 여기선 State Class 겠지?
  //   // 연결된 위젯의 구성요소에 접근가능한 widget. 키워드는 State Object 에서 제공됨.
  // }

  // // 새로운 external data 를 받을 때마다 didUpdateWidget 이 실행된다. 
  // // 여기같은 경우 main.dart 파일에서 받아오는 startingProduct 같은 external data
  // // oldWidget 은 위에서 쓴 widget 과 비슷한 것이긴 한데,
  // // 대신 이 oldWidget 은 updated 되기 전(새로운 외부 데이터 받아오기 전) 데이터를 지칭한다.
  // // 그래서 뭐 필요하면 그걸 이용해서 서로 비교해도 되고
  // // didUpdate 는 근데 맨 처음에도 발생되긴 한다. 처음도 update 긴 하니까?
  // @override
  // void didUpdateWidget(ProductManager oldWidget) {
  //   super.didUpdateWidget(oldWidget);
  //   print('[ProductManager State] didUpdateWidget()');
  // }
  // // 만약 Map 의 value 값이 다양하게 섞여 있다면, generic type 를 dynamic 이라고 쓴다.
  // // ex) Map<String, dynamic>
  // void _addProduct(Map<String, String> product) {
  //   setState(() {
  //     _products.add(product);
  //   });
  // }

  // void _deleteProduct(int index) {
  //   setState(() {
  //     _products.removeAt(index);
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    print('[ProductManager State] build()');
    return Column(
      children: [
        // Container(
        //   margin: EdgeInsets.all(10.0),
        //   // 바로 실행시킬 게 아니라서 reference 만 보냄.
        //   child: ProductControl(addProduct),
        // ),
        // Expanded 는 남은 모든 부분을 차지하도록 함. 
        // Expanded 를 안 쓸거면 원래는 Container(height: 300.0, child: Products(_products)) 같이 직접 높이를 지정해주어야 한다.
        Expanded(child: Products(products))
      ],
    );
  }
}