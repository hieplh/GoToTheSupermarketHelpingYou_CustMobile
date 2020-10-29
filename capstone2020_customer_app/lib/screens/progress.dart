
import 'dart:convert';

import 'package:capstone2020customerapp/api/order_api_service.dart';
import 'package:capstone2020customerapp/models/history_model.dart';
import 'package:capstone2020customerapp/api/history_api_service.dart';
import 'package:capstone2020customerapp/models/order_detail_model.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../api_url_constain.dart';

class ProgressPage extends StatefulWidget {

  @override
  _ProgressPage createState() => _ProgressPage();
}
String img = img1;
String img1 = "https://cdn1.everten.com.au/media/wysiwyg/deliveryinfoimages/deliveryTruck_5.1539672900.png";
String img2 = "https://i.pinimg.com/736x/17/45/ec/1745ec05166a6c4a3e61c5533eb6883d.jpg";
String img3 = "https://miro.medium.com/max/720/1*pCcEZ-0Hj6dp1jpCBZsJGg.jpeg";
int count = 0;
class _ProgressPage extends State<ProgressPage> {
  List<Step> steps = [
    Step(
      title: const Text('Nhận Đơn'),
      isActive: true,
      state: StepState.complete,
      content: Column(
        children: <Widget>[
          TextFormField(
            decoration: InputDecoration(labelText: 'Shipper Đã Nhận Đơn'),
          ),
        ],
      ),
    ),
    Step(
      isActive: false,
      state: StepState.editing,
      title: const Text('Đi Chợ'),
      content: Column(
        children: <Widget>[
          TextFormField(
            decoration: InputDecoration(labelText: 'Shipper Đang Đi Chợ'),
          ),
        ],
      ),
    ),
//    Step(
//      state: StepState.error,
//      title: const Text('Avatar'),
//      subtitle: const Text("Error!"),
//      content: Column(
//        children: <Widget>[
//          CircleAvatar(
//            backgroundColor: Colors.red,
//          )
//        ],
//      ),
//    ),
    Step(
      isActive: false,
      state: StepState.editing,
      title: const Text('Giao Hàng'),
      content: Column(
        children: <Widget>[
          TextFormField(
            decoration: InputDecoration(labelText: 'Shipper Đang Giao Hàng'),
          ),
        ],
      ),
    ),
  ];
  StepperType stepperType = StepperType.horizontal;

  int currentStep = 0;
  bool complete = false;

  next() {
    count++;
    if(count == 1){
      img = img2;
    }else{
      img = img3;
    }

    currentStep + 1 != steps.length
        ? goTo(currentStep + 1)
        : setState(() => complete = true);
  }

  cancel() {
    count--;
    if(count == 1){
      img = img2;
    }else{
      img = img1;
    }
    if (currentStep > 0) {
      goTo(currentStep - 1);
    }
  }

  goTo(int step) {
    setState(() => currentStep = step);
  }

  switchStepType() {
    setState(() => stepperType == StepperType.horizontal
        ? stepperType = StepperType.vertical
        : stepperType = StepperType.horizontal);
  }

  var myOrder;
  List<OrderDetail> order;
  Future<void> getMyOrder() async {
    final myService1 = OrderApiService.create();
    myOrder = await myService1.getOrderByID(ID);
    order = myOrder.body.details;
  }

  @override
  Widget build(BuildContext context) {

    // TODO: implement build
    return Scaffold(
      backgroundColor: Colors.white,
      body: FutureBuilder(
          future: getMyOrder(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else {
              return SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    _buildHeader(),
                    _buildBody(),
                  ],
                ),
              );
            }
          }
      ),
//      floatingActionButton: FloatingActionButton(
//        child: Icon(Icons.list),
//        onPressed: switchStepType,
//      ),

    );
  }
  Widget _buildHeader() {
    return Container(
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(width: 1.0, color: Colors.grey),
        ),
      ),
      child: Row(
        children: <Widget>[
          Container(
            alignment: Alignment.centerLeft,
            child: IconButton(
              icon: new Icon(
                Icons.keyboard_backspace,
                color: const Color.fromRGBO(0, 175, 82, 1),
                size: 30.0,
              ),
              //onPressed: changeThePage,
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width * 0.8,
            alignment: Alignment.center,
            child: Text(
              'Progress',
              style: TextStyle(
                fontSize: 20.0,
                fontFamily: 'Montserrat',
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
  Widget _buildBody(){
    return Column(
      children: <Widget>[
        Container(
          height: 300.0,
          alignment: Alignment.center,
          child: Image.network(
            img,
            fit: BoxFit.cover,
            height: double.infinity,
            width: double.infinity,
            alignment: Alignment.center,
          ),
        ),

        Container(
          margin: const EdgeInsets.only(bottom: 15.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(
                Radius.circular(10.0) //         <--- border radius here
            ),
            border: Border(
              bottom: BorderSide(width: 1.0, color: Colors.grey[300]),
              top: BorderSide(width: 1.0, color: Colors.grey[300]),
              left: BorderSide(width: 1.0, color: Colors.grey[300]),
              right: BorderSide(width: 1.0, color: Colors.grey[300]),
            ),
          ),
          width: MediaQuery.of(context).size.width * 0.9,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                margin: const EdgeInsets.only(left: 10.0),
                padding: const EdgeInsets.only(top: 30.0, bottom: 10.0),
                child: Text(
                  'Thời Gian Dự Kiến Giao',
                  style: TextStyle(
                    fontSize: 16.0,
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(left: 10.0),
                padding: const EdgeInsets.only(bottom: 15.0),
                child: Text(
                  '${utf8.decode(latin1.encode(myOrder.body.timeDelivery), allowMalformed: true)}',
                  style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),

              Container(
                margin: const EdgeInsets.only(left: 10.0, right: 10.0),
                decoration: BoxDecoration(
                  border: Border(
                    top: BorderSide(width: 1.0, color: Colors.grey),
                  ),
                ),
                //height: MediaQuery.of(context).size.width ,
                child: Stepper(
                  steps: steps,
                  currentStep: currentStep,
                  onStepContinue: next,
                  onStepTapped: (step) => goTo(step),
                  onStepCancel: cancel,
                ),
              ),
            ],

          ),

        ),
        Container(
          margin: const EdgeInsets.only(bottom: 15.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(
                Radius.circular(10.0) //         <--- border radius here
            ),
            border: Border(
              bottom: BorderSide(width: 1.0, color: Colors.grey[300]),
              top: BorderSide(width: 1.0, color: Colors.grey[300]),
              left: BorderSide(width: 1.0, color: Colors.grey[300]),
              right: BorderSide(width: 1.0, color: Colors.grey[300]),
            ),
          ),
          width: MediaQuery.of(context).size.width * 0.9,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              ListTile(
                leading: CircleAvatar(
                  radius: 30,
                  backgroundImage: NetworkImage("https://cdn.iconscout.com/icon/free/png-256/avatar-370-456322.png"),
                ),
                title: Text(
                  'Phan Công Bình',
                  style: TextStyle(
                    fontFamily: 'Montserrat',
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                subtitle: Text(
                  'Jupiter Yamaha - 72C1-79945',
                  style: TextStyle(
                    fontFamily: 'Montserrat',
                    fontSize: 15.0,
                  ),
                ),
                trailing: Icon(
                  Icons.star,
                  color: Colors.yellowAccent,
                  size: 40.0,
                ),
                onTap: () {
                  //Navigator.pop(context);
                },
              ),

            ],

          ),

        ),
        Container(
          margin: const EdgeInsets.only(bottom: 15.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(
                Radius.circular(10.0) //         <--- border radius here
            ),
            border: Border(
              bottom: BorderSide(width: 1.0, color: Colors.grey[300]),
              top: BorderSide(width: 1.0, color: Colors.grey[300]),
              left: BorderSide(width: 1.0, color: Colors.grey[300]),
              right: BorderSide(width: 1.0, color: Colors.grey[300]),
            ),
          ),
          width: MediaQuery.of(context).size.width * 0.9,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                margin: const EdgeInsets.only(left: 10.0, right: 10.0),
                padding: const EdgeInsets.only(top: 30.0, bottom: 10.0),
                child: Text(
                  '${utf8.decode(latin1.encode(myOrder.body.addressDelivery), allowMalformed: true)}',
                  style: TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),

              Row(
                children: <Widget>[
                  Container(
                    margin: const EdgeInsets.only(left: 10.0),
                    width: MediaQuery.of(context).size.width * 0.55,
                    padding: const EdgeInsets.only(bottom: 15.0, top: 10.0),
                    child: Text(
                      'Tổng Tiền',
                      style: TextStyle(
                        fontSize: 16.0,
                      ),
                    ),
                  ),
                  Row(
                    children: <Widget>[
                      Container(
                        child: Icon(
                          Icons.credit_card,
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.only(bottom: 15.0, top: 10.0),
                        width: MediaQuery.of(context).size.width * 0.25,
                        child: Text(
                          '${myOrder.body.totalCost}đ',
                          style: TextStyle(
                            fontSize: 17.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],

              ),

              Container(
                margin: const EdgeInsets.only(left: 10.0, right: 10.0),
                decoration: BoxDecoration(
                  border: Border(
                    top: BorderSide(width: 1.0, color: Colors.grey[400]),
                  ),
                ),
                //height: MediaQuery.of(context).size.width ,
                child: Column(
                  children: <Widget>[
                    for (var list in order)
                      Container(
                        child: ListTile(
                          leading: Text(
                            '1x',
                            style: TextStyle(
                              fontSize: 14.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          title: Text(
                            '${utf8.decode(latin1.encode(list.food), allowMalformed: true)}',
                            style: TextStyle(
                              fontFamily: 'Montserrat',
                              fontSize: 17.0,
                            ),
                          ),
//                          subtitle: Text(
//                            '${listFood.price}',
//                            style: TextStyle(
//                              fontFamily: 'Montserrat',
//                              fontSize: 13.0,
//                            ),
//                          ),
                          trailing: Text(
                            '${list.priceOriginal}đ',
                            style: TextStyle(
                              fontSize: 17.0,
                            ),
                          ),
                        ),
                      ),
                  ],

                ),
              ),
              Container(
                margin: const EdgeInsets.only(left: 10.0, right: 10.0),
                decoration: BoxDecoration(
                  border: Border(
                    top: BorderSide(
                      width: 1.0,
                      color: Colors.grey[400],
                    ),
                  ),
                ),
                child: ListTile(
                  leading: Text(
                    'Xem Chi Tiết',
                    style: TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                      color: const Color.fromRGBO(0, 175, 82, 1),
                    ),
                  ),
//                  title: Text(
//                    'Thịt Ba Chỉ Heo',
//                    style: TextStyle(
//                      fontFamily: 'Montserrat',
//                      fontSize: 17.0,
//                    ),
//                  ),
//                          subtitle: Text(
//                            '${listFood.price}',
//                            style: TextStyle(
//                              fontFamily: 'Montserrat',
//                              fontSize: 13.0,
//                            ),
//                          ),
                  trailing: Icon(
                    Icons.keyboard_arrow_right,
                    color: const Color.fromRGBO(0, 175, 82, 1),
                  ),
                ),
              ),
            ],

          ),

        ),
        Container(
          margin: const EdgeInsets.only(bottom: 15.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(
                Radius.circular(10.0) //         <--- border radius here
            ),
            border: Border(
              bottom: BorderSide(width: 1.0, color: Colors.grey[300]),
              top: BorderSide(width: 1.0, color: Colors.grey[300]),
              left: BorderSide(width: 1.0, color: Colors.grey[300]),
              right: BorderSide(width: 1.0, color: Colors.grey[300]),
            ),
          ),
          width: MediaQuery.of(context).size.width * 0.9,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                children: <Widget>[
                  Container(
                    padding: const EdgeInsets.only(top: 10.0),
                    margin: const EdgeInsets.only(left: 10.0),
                    child: Icon(
                      Icons.local_convenience_store,
                      color: const Color.fromRGBO(0, 175, 82, 1),
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.7,
                    margin: const EdgeInsets.only(left: 10.0),
                    padding: const EdgeInsets.only(top: 10.0),
                    child: Text(
                      '${utf8.decode(latin1.encode(myOrder.body.market), allowMalformed: true)}',
                      style: TextStyle(
                        fontSize: 16.0,
                      ),
                    ),
                  ),
                ],

              ),
              Container(
                margin: const EdgeInsets.only(left: 10.0),
                child: Icon(
                    Icons.more_vert,
                  color: Colors.grey[400],
                ),
              ),
              Row(
                children: <Widget>[
                  Container(
                    margin: const EdgeInsets.only(left: 10.0),
                    child: Icon(
                      Icons.location_on,
                      color: Colors.red,
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.7,
                    margin: const EdgeInsets.only(left: 10.0),
                    child: Text(
                      '${utf8.decode(latin1.encode(myOrder.body.addressDelivery), allowMalformed: true)}',
                      style: TextStyle(
                        fontSize: 16.0,
                      ),
                    ),
                  ),
                ],

              ),

            ],

          ),

        ),
      ],

    );
  }



}