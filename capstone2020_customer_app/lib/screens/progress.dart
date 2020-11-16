
import 'dart:async';
import 'dart:convert';

import 'package:capstone2020customerapp/api/order_api_service.dart';
import 'package:capstone2020customerapp/components/map_pin_pill.dart';
import 'package:capstone2020customerapp/models/history_model.dart';
import 'package:capstone2020customerapp/api/history_api_service.dart';
import 'package:capstone2020customerapp/models/order_detail_model.dart';
import 'package:capstone2020customerapp/models/pin_pill_info.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

import '../api_url_constain.dart';
import 'home.dart';

class ProgressPage extends StatefulWidget {

  @override
  _ProgressPage createState() => _ProgressPage();
}
String img = img0;
String img0 = "https://media.istockphoto.com/vectors/hourglass-icon-simple-flat-style-sandglass-illustration-vector-id1039032938";
String img1 = "https://cdn1.everten.com.au/media/wysiwyg/deliveryinfoimages/deliveryTruck_5.1539672900.png";
String img2 = "https://i.pinimg.com/736x/17/45/ec/1745ec05166a6c4a3e61c5533eb6883d.jpg";
String img3 = "https://miro.medium.com/max/720/1*pCcEZ-0Hj6dp1jpCBZsJGg.jpeg";
int count = 0;
TextEditingController _textFieldController = TextEditingController();

const double CAMERA_ZOOM = 11;
const LatLng SOURCE_LOCATION = LatLng(10.850519, 106.751692);
const LatLng DEST_LOCATION = LatLng(10.786785, 106.746027);

Completer<GoogleMapController> _controller = Completer();
Set<Marker> _markers = Set<Marker>();
// for my drawn routes on the map
Set<Polyline> _polylines = Set<Polyline>();
List<LatLng> polylineCoordinates = [];
PolylinePoints polylinePoints;
String googleAPIKey = 'AIzaSyDl3HXWngkUA1yFkSXDeXSzu_3KyPkH810';
// for my custom marker pins
BitmapDescriptor sourceIcon;
BitmapDescriptor destinationIcon;
// the user's initial location and current location
// as it moves
LocationData currentLocation;
// a reference to the destination location
LocationData destinationLocation;
// wrapper around the location API
Location location;
double pinPillPosition = -100;
PinInformation currentlySelectedPin = PinInformation(
    pinPath: '',
    avatarPath: '',
    location: LatLng(0, 0),
    locationName: '',
    labelColor: Colors.grey);
PinInformation sourcePinInfo;
PinInformation destinationPinInfo;



void setSourceAndDestinationIcons() async {
  BitmapDescriptor.fromAssetImage(
      ImageConfiguration(devicePixelRatio: 2.0), 'assets/driving_pin.png')
      .then((onValue) {
    sourceIcon = onValue;
  });

  BitmapDescriptor.fromAssetImage(ImageConfiguration(devicePixelRatio: 2.0),
      'assets/destination_map_marker.png')
      .then((onValue) {
    destinationIcon = onValue;
  });
}

void setInitialLocation() async {
  // set the initial location by pulling the user's
  // current location from the location's getLocation()
  currentLocation = await location.getLocation();

  // hard-coded destination for this example
  destinationLocation = LocationData.fromMap({
    "latitude": DEST_LOCATION.latitude,
    "longitude": DEST_LOCATION.longitude
  });
}

_displayDialog(BuildContext context) async {
  return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Đơn Hàng giao thành công\nFeedback cho shipper(nếu cần)'),
          content: TextField(
            controller: _textFieldController,
            decoration: InputDecoration(hintText: "FeedBack..."),
          ),
          actions: <Widget>[
            new FlatButton(
              child: new Text('Xác Nhận'),
              onPressed: () {
                img = img0;
                ID = null;
                Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(builder: (context) {
                      return HomePage(storeID: idStore,);
                    }), ModalRoute.withName('/'));
              },
            )
          ],
        );
      });
}

class _ProgressPage extends State<ProgressPage> {

  int num = 12;
  var myOrder;
  List<OrderDetail> order;
  @override
  void initState() {
    super.initState();

    // create an instance of Location
    location = new Location();
    polylinePoints = PolylinePoints();

    // subscribe to changes in the user's location
    // by "listening" to the location's onLocationChanged event
//    location.onLocationChanged().listen((LocationData cLoc) {
//      // cLoc contains the lat and long of the
//      // current user's position in real time,
//      // so we're holding on to it
//      currentLocation = cLoc;
//      updatePinOnMap();
//    });
    // set custom marker pins
    setSourceAndDestinationIcons();
    // set the initial location
    setInitialLocation();
  }

  Future<void> getMyOrder() async {

    final myService1 = OrderApiService.create();
    final mySth = await myService1.getOrderByID(ID);
    myOrder = mySth;
    order = mySth.body.details;

    if(status == 12){
      Timer(const Duration(seconds: 10), () => getMyOrder());
      status = mySth.body.status;
      print(status);
      if(status == num){
        status = 12;
      }
    }
    if(status == 21){
      num = 21;
      img = img1;
      setState(() {
        status = 12;
      });

      print(status);
    }
    if(status == 22){
      num = 22;
      img = img2;
      setState(() {
        status = 12;
      });

      print(status);
    }
    if(status == 23){
      num = 23;
      setState(() {
        status = 12;
      });

      print(status);
    }
    if(status == 24){
      num = 24;
      _displayDialog(context);
      setState(() {
        status = 0;
      });

      print(status);
    }
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

  Widget _buildMap(){
    CameraPosition initialCameraPosition = CameraPosition(
        zoom: CAMERA_ZOOM,
        target: SOURCE_LOCATION);
    if (currentLocation != null) {
      initialCameraPosition = CameraPosition(
        target: LatLng(currentLocation.latitude, currentLocation.longitude),
        zoom: CAMERA_ZOOM,
      );
    }
    return Stack(
        children: <Widget>[
          Container(
            height: 300.0,
            child: GoogleMap(
                myLocationEnabled: true,
                compassEnabled: true,
                tiltGesturesEnabled: false,
                markers: _markers,
                polylines: _polylines,
                mapType: MapType.normal,
                initialCameraPosition: initialCameraPosition,
                onTap: (LatLng loc) {
                  pinPillPosition = -100;
                },
                onMapCreated: (GoogleMapController controller) {
                  _controller.complete(controller);
                  // my map has completed being created;
                  // i'm ready to show the pins on the map
                  showPinsOnMap();
                }
                ),
          ),
          MapPinPillComponent(
              pinPillPosition: pinPillPosition,
              currentlySelectedPin: currentlySelectedPin)
        ],
    );
  }

  Widget _buildProgress(){
    return Container(
      margin: const EdgeInsets.only(left: 10.0, right: 10.0),
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(width: 1.0, color: Colors.grey),
        ),
      ),
      child: Column(
        children: <Widget>[
          if(num == 12)
            Container(
              child: Text(
                'Processing...',
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          if(num == 21)
            Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Container(
                        child: Icon(
                          Icons.brightness_1,
                          color: const Color.fromRGBO(0, 175, 82, 1),
                        ),
                      ),
                      Container(
                        child: Text(
                          "Người giao hàng đã nhận đơn",
                          style: TextStyle(
                              fontSize: 18.0,
                              color: Colors.black
                          ),
                        ),
                      ),
                    ],
                  ),
                  Container(
                    width: 3.0,
                    height: 15.0,
                    color: Colors.grey,
                    margin: EdgeInsets.only(left: 10.0),
                  ),
                  Row(
                    children: <Widget>[
                      Container(
                        child: Icon(
                          Icons.brightness_1,
                          color: Colors.grey,
                        ),
                      ),
                      Container(
                        child: Text(
                          "Người giao hàng đã tới siêu thị",
                          style: TextStyle(
                              fontSize: 18.0,
                              color: Colors.grey
                          ),
                        ),
                      ),
                    ],
                  ),
                  Container(
                    width: 3.0,
                    height: 15.0,
                    color: Colors.grey,
                    margin: EdgeInsets.only(left: 10.0),
                  ),
                  Row(
                    children: <Widget>[
                      Container(
                        child: Icon(
                          Icons.brightness_1,
                          color: Colors.grey,
                        ),
                      ),
                      Container(
                        child: Text(
                          "Người giao hàng đang giao hàng",
                          style: TextStyle(
                              fontSize: 18.0,
                              color: Colors.grey
                          ),
                        ),
                      ),
                    ],
                  ),
                ],

              ),
            ),
          if(num == 22)
            Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Container(
                        child: Icon(
                          Icons.brightness_1,
                          color: const Color.fromRGBO(0, 175, 82, 1),
                        ),
                      ),
                      Container(
                        child: Text(
                          "Người giao hàng đã nhận đơn",
                          style: TextStyle(
                              fontSize: 18.0,
                              color: Colors.grey
                          ),
                        ),
                      ),
                    ],
                  ),
                  Container(
                    width: 3.0,
                    height: 15.0,
                    color: const Color.fromRGBO(0, 175, 82, 1),
                    margin: EdgeInsets.only(left: 10.0),
                  ),
                  Row(
                    children: <Widget>[
                      Container(
                        child: Icon(
                          Icons.brightness_1,
                          color: const Color.fromRGBO(0, 175, 82, 1),
                        ),
                      ),
                      Container(
                        child: Text(
                          "Người giao hàng đã tới siêu thị",
                          style: TextStyle(
                              fontSize: 18.0,
                              color: Colors.black
                          ),
                        ),
                      ),
                    ],
                  ),
                  Container(
                    width: 3.0,
                    height: 15.0,
                    color: Colors.grey,
                    margin: EdgeInsets.only(left: 10.0),
                  ),
                  Row(
                    children: <Widget>[
                      Container(
                        child: Icon(
                          Icons.brightness_1,
                          color: Colors.grey,
                        ),
                      ),
                      Container(
                        child: Text(
                          "Người giao hàng đang giao hàng",
                          style: TextStyle(
                              fontSize: 18.0,
                              color: Colors.grey
                          ),
                        ),
                      ),
                    ],
                  ),
                ],

              ),
            ),
          if(num == 23)
            Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Container(
                        child: Icon(
                          Icons.brightness_1,
                          color: const Color.fromRGBO(0, 175, 82, 1),
                        ),
                      ),
                      Container(
                        child: Text(
                          "Người giao hàng đã nhận đơn",
                          style: TextStyle(
                              fontSize: 18.0,
                              color: Colors.grey
                          ),
                        ),
                      ),
                    ],
                  ),
                  Container(
                    width: 3.0,
                    height: 15.0,
                    color: const Color.fromRGBO(0, 175, 82, 1),
                    margin: EdgeInsets.only(left: 10.0),
                  ),
                  Row(
                    children: <Widget>[
                      Container(
                        child: Icon(
                          Icons.brightness_1,
                          color: const Color.fromRGBO(0, 175, 82, 1),
                        ),
                      ),
                      Container(
                        child: Text(
                          "Người giao hàng đã tới siêu thị",
                          style: TextStyle(
                              fontSize: 18.0,
                              color: Colors.grey
                          ),
                        ),
                      ),
                    ],
                  ),
                  Container(
                    width: 3.0,
                    height: 15.0,
                    color: const Color.fromRGBO(0, 175, 82, 1),
                    margin: EdgeInsets.only(left: 10.0),
                  ),
                  Row(
                    children: <Widget>[
                      Container(
                        child: Icon(
                          Icons.brightness_1,
                          color: const Color.fromRGBO(0, 175, 82, 1),
                        ),
                      ),
                      Container(
                        child: Text(
                          "Người giao hàng đang giao hàng",
                          style: TextStyle(
                              fontSize: 18.0,
                              color: Colors.black,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],

              ),
            ),

        ],
      ),
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
        if(num == 23)
          _buildMap(),
        if(num != 23)
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
              _buildProgress()
            ],

          ),

        ),
        if(num == 21)
          Container(
          margin: const EdgeInsets.only(bottom: 5.0),
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
        if(num == 21)
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
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Container(
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
                    height: 40.0,
                    width: 100.0,
                    padding: EdgeInsets.only(top: 5.0),
                    margin: EdgeInsets.only(top: 10.0, bottom: 10.0),
                    child: Text(
                      '10,000đ+',
                      style: TextStyle(
                        fontSize: 20.0,
                        color: Colors.grey[800],
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Container(
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
                    height: 40.0,
                    width: 100.0,
                    padding: EdgeInsets.only(top: 5.0),
                    margin: EdgeInsets.only(top: 10.0, bottom: 10.0),
                    child: Text(
                      '20,000đ+',
                      style: TextStyle(
                        fontSize: 20.0,
                        color: Colors.grey[800],
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Container(
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
                    height: 40.0,
                    width: 100.0,
                    padding: EdgeInsets.only(top: 5.0),
                    margin: EdgeInsets.only(top: 10.0, bottom: 10.0),
                    child: Text(
                      '30,000đ+',
                      style: TextStyle(
                        fontSize: 20.0,
                        color: Colors.grey[800],
                      ),
                      textAlign: TextAlign.center,
                    ),
                  )

                ],

              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Container(
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
                    height: 40.0,
                    width: 100.0,
                    padding: EdgeInsets.only(top: 5.0),
                    margin: EdgeInsets.only(bottom: 10.0),
                    child: Text(
                      '40,000đ+',
                      style: TextStyle(
                        fontSize: 20.0,
                        color: Colors.grey[800],
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Container(
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
                    height: 40.0,
                    width: 100.0,
                    padding: EdgeInsets.only(top: 5.0),
                    margin: EdgeInsets.only(bottom: 10.0),
                    child: Text(
                      '50,000đ+',
                      style: TextStyle(
                        fontSize: 20.0,
                        color: Colors.grey[800],
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Container(
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
                    height: 40.0,
                    width: 100.0,
                    padding: EdgeInsets.only(top: 5.0),
                    margin: EdgeInsets.only(bottom: 10.0),
                    child: Text(
                      '60,000đ+',
                      style: TextStyle(
                        fontSize: 20.0,
                        color: Colors.grey[800],
                      ),
                      textAlign: TextAlign.center,
                    ),
                  )

                ],

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
                          '${oCcy.format(myOrder.body.totalCost)}đ',
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
                            '${utf8.decode(latin1.encode(list.foodId), allowMalformed: true)}',
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
                            '${oCcy.format(list.priceOriginal)}đ',
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

  void showPinsOnMap() {
    // get a LatLng for the source location
    // from the LocationData currentLocation object
    var pinPosition =
    LatLng(currentLocation.latitude, currentLocation.longitude);
    // get a LatLng out of the LocationData object
    var destPosition =
    LatLng(destinationLocation.latitude, destinationLocation.longitude);

    sourcePinInfo = PinInformation(
        locationName: "Start Location",
        location: SOURCE_LOCATION,
        pinPath: "assets/driving_pin.png",
        avatarPath: "assets/friend1.jpg",
        labelColor: Colors.blueAccent);

    destinationPinInfo = PinInformation(
        locationName: "End Location",
        location: DEST_LOCATION,
        pinPath: "assets/destination_map_marker.png",
        avatarPath: "assets/friend2.jpg",
        labelColor: Colors.purple);

    // add the initial source location pin
    _markers.add(Marker(
        markerId: MarkerId('sourcePin'),
        position: pinPosition,
        onTap: () {
          setState(() {
            currentlySelectedPin = sourcePinInfo;
            pinPillPosition = 0;
          });
        },
        icon: sourceIcon));
    // destination pin
    _markers.add(Marker(
        markerId: MarkerId('destPin'),
        position: destPosition,
        onTap: () {
          setState(() {
            currentlySelectedPin = destinationPinInfo;
            pinPillPosition = 0;
          });
        },
        icon: destinationIcon));
    // set the route lines on the map from source to destination
    // for more info follow this tutorial
    setPolylines();
  }

  void setPolylines() async {
    List<PointLatLng> result = await polylinePoints.getRouteBetweenCoordinates(
        googleAPIKey,
        currentLocation.latitude,
        currentLocation.longitude,
        destinationLocation.latitude,
        destinationLocation.longitude);

    if (result.isNotEmpty) {
      result.forEach((PointLatLng point) {
        polylineCoordinates.add(LatLng(point.latitude, point.longitude));
      });

      setState(() {
        _polylines.add(Polyline(
            width: 2, // set the width of the polylines
            polylineId: PolylineId("poly"),
            color: Color.fromARGB(255, 40, 122, 198),
            points: polylineCoordinates));
      });
    }
  }

  void updatePinOnMap() async {
    // create a new CameraPosition instance
    // every time the location changes, so the camera
    // follows the pin as it moves with an animation
    CameraPosition cPosition = CameraPosition(
      zoom: CAMERA_ZOOM,
      target: LatLng(currentLocation.latitude, currentLocation.longitude),
    );
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(cPosition));
    // do this inside the setState() so Flutter gets notified
    // that a widget update is due
    setState(() {
      // updated position
      var pinPosition =
      LatLng(currentLocation.latitude, currentLocation.longitude);

      sourcePinInfo.location = pinPosition;

      // the trick is to remove the marker (by id)
      // and add it again at the updated location
      _markers.removeWhere((m) => m.markerId.value == 'sourcePin');
      _markers.add(Marker(
          markerId: MarkerId('sourcePin'),
          onTap: () {
            setState(() {
              currentlySelectedPin = sourcePinInfo;
              pinPillPosition = 0;
            });
          },
          position: pinPosition, // updated position
          icon: sourceIcon));
    });
  }

}