import 'package:flutter/material.dart';

class FoodDetailPage extends StatefulWidget {
  @override
  _FoodDetailPage createState() => _FoodDetailPage();
}

FocusNode myFocusNode = new FocusNode();

class _FoodDetailPage extends State<FoodDetailPage> {
//  int _n = 0;

//  void add() {
//    setState(() {
//      _n++;
//    });
//  }
//
//  void minus() {
//    setState(() {
//      if (_n != 0) _n--;
//    });
//  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            _buildHeader(),
            _buildBody(),
            //_buildQuantity(),
            _buildOrderButton(),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      height: 300.0,
      child: Image.network(
        'https://vitafood.org/wp-content/uploads/2019/12/thit-nac-vai.jpg',
        fit: BoxFit.cover,
        height: double.infinity,
        width: double.infinity,
        alignment: Alignment.center,
      ),
    );
  }

  Widget _buildBody() {
    return Column(
      children: <Widget>[
        Container(
          height: 75.0,
          color: Colors.grey[200],
          child: Column(
            children: <Widget>[
              Container(
                padding: const EdgeInsets.only(top: 15.0),
                child: Text(
                  'Thịt vai heo 450g - 67,000đ',
                  style: TextStyle(fontSize: 25.0, fontWeight: FontWeight.bold),
                ),
              ),
              Container(
                padding: const EdgeInsets.only(top: 5.0),
                alignment: Alignment.center,
                child: Text(
                  'Số Lượng: 23',
                  style: TextStyle(
                    fontSize: 13.0,
                    color: Colors.grey,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
        Container(
          child: Row(
            children: <Widget>[
              Container(
                padding:
                    const EdgeInsets.only(left: 10.0, top: 20.0, bottom: 20.0),
                width: MediaQuery.of(context).size.width * 0.5,
                child: Text(
                  'Special Instructions',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20.0,
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.only(top: 20.0, bottom: 20.0),
                child: Text(
                  'Optional',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16.0,
                    color: Colors.grey,
                  ),
                ),
              ),
            ],
          ),
        ),
        Container(
          width: MediaQuery.of(context).size.width * 0.9,
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(width: 1.0, color: Colors.grey),
            ),
          ),
        ),
        Container(
          width: MediaQuery.of(context).size.width * 0.9,
          padding: EdgeInsets.only(bottom: 20.0),
          child: StreamBuilder<String>(
            //stream: bloc.email,
            builder: (context, snapshot) => TextFormField(
              //onChanged: bloc.emailChanged,
              style: TextStyle(
                color: Colors.black,
              ),
              //controller: searchController,
              //onSaved: (input) => search = input,
              decoration: InputDecoration(
                labelText: 'E.g. Tôi không cần túi nhựa',
                labelStyle: TextStyle(
                    color: myFocusNode.hasFocus
                        ? const Color.fromRGBO(0, 255, 0, 1)
                        : Colors.grey),
              ),
            ),
          ),
        ),
      ],
    );
  }

//  Widget _buildQuantity() {
//    return Container(
//      child: new Center(
//        child: new Row(
//          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//          children: <Widget>[
//            new FloatingActionButton(
//              onPressed: add,
//              child: new Icon(Icons.add,
//                  color: const Color.fromRGBO(0, 141, 177, 1)),
//              backgroundColor: Colors.white,
//            ),
//            new Text('$_n', style: new TextStyle(fontSize: 60.0)),
//            new FloatingActionButton(
//              onPressed: minus,
//              child: new Icon(
//                  const IconData(0xe15b, fontFamily: 'MaterialIcons'),
//                  color: const Color.fromRGBO(0, 141, 177, 1)),
//              backgroundColor: Colors.white,
//            ),
//          ],
//        ),
//      ),
//    );
//  }

  Widget _buildOrderButton() {
    return Container(
      width: MediaQuery.of(context).size.width * 0.8,
      padding: EdgeInsets.only(top: 10.0),
      height: 60.0,
      child: RaisedButton(
        onPressed: () {},
        textColor: Colors.white,
        color: const Color.fromRGBO(144, 238, 144, 1),
          child: Text(
            'Thêm Vào Giỏ Hàng',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.white,
              fontSize: 18.0,
              letterSpacing: 2.0,
              fontFamily: 'Montserrat',
            ),
          ),
        ),
    );
  }
}
