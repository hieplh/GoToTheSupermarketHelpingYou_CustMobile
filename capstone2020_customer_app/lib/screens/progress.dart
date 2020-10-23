
import 'dart:convert';

import 'package:capstone2020customerapp/models/history_model.dart';
import 'package:capstone2020customerapp/api/history_api_service.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ProgressPage extends StatefulWidget {

  @override
  _ProgressPage createState() => _ProgressPage();
}

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
    currentStep + 1 != steps.length
        ? goTo(currentStep + 1)
        : setState(() => complete = true);
  }

  cancel() {
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
    return Container(
      height: MediaQuery.of(context).size.width ,
      child: Stepper(
        steps: steps,
        currentStep: currentStep,
        onStepContinue: next,
        onStepTapped: (step) => goTo(step),
        onStepCancel: cancel,
      ),
    );
  }



}