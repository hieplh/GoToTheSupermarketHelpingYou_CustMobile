import 'package:capstone2020customerapp/screens/foodDetail.dart';
import 'package:flutter/material.dart';

class FoodTypePage extends StatefulWidget {
  @override
  _FoodTypePage createState() => _FoodTypePage();
}

class _FoodTypePage extends State<FoodTypePage> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            _buildHeader(),
            _buildBody(),
          ],
        ),
      ),
    );
  }
  Widget _buildHeader() {
    return Container(
      height: 300.0,
      child: Image.network(
          'https://cdnmedia.eurofins.com/apac/media/603979/kiem-nghiem-chat-luong-thit-tuoi.jpg?width=480.5764411027569&height=500',
        fit: BoxFit.cover,
        height: double.infinity,
        width: double.infinity,
        alignment: Alignment.center,),

    );
  }
  Widget _buildBody(){
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
                  'Thịt Heo',
                  style: TextStyle(
                      fontSize: 25.0,
                      fontWeight: FontWeight.bold
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.only(top: 5.0),
                alignment: Alignment.center,
                child: Text(
                  '53 loại',
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
        for (var i = 0; i < 8; i++)
          Container(
            padding: EdgeInsets.only(bottom: 10.0),
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  width: 0.0,
                  color: Colors.black,
                ),
              ),
            ),
            child: ListTile(
              leading: Image.network(
                  'https://vitafood.org/wp-content/uploads/2019/12/thit-nac-vai.jpg'),
              title: Text(
                'Thịt vai heo - 450g',
                style: TextStyle(
                  fontFamily: 'Montserrat',
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              subtitle: Text(
                'Số Lượng: 23\n\n'
                    '67,000đ',
                style: TextStyle(
                  fontFamily: 'Montserrat',
                  fontSize: 13.0,
                ),
              ),
              trailing: Icon(
                Icons.add_circle_outline,
                color: const Color.fromRGBO(0, 175, 82, 1),
                size: 30.0,
              ),
              onTap: (){
                Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                  return FoodDetailPage();
                }));
              },
            ),
          ),
      ],


    );
  }

}