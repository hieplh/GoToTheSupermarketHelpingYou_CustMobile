
import 'dart:async';
import 'dart:convert';

import 'package:capstone2020customerapp/api/account_api_service.dart';
import 'package:capstone2020customerapp/api/market_detail_api_service.dart';
import 'package:capstone2020customerapp/api/order_api_service.dart';
import 'package:capstone2020customerapp/components/map_pin_pill.dart';
import 'package:capstone2020customerapp/models/history_model.dart';
import 'package:capstone2020customerapp/api/history_api_service.dart';
import 'package:capstone2020customerapp/models/order_detail_model.dart';
import 'package:capstone2020customerapp/models/pin_pill_info.dart';
import 'package:capstone2020customerapp/models/shipper_model.dart';
import 'package:capstone2020customerapp/models/store_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geocoder/geocoder.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

import '../api_url_constain.dart';
import 'home.dart';

class ProgressPage extends StatefulWidget {
  final String storeID;

  ProgressPage({Key key, @required this.storeID}) : super(key: key);

  @override
  _ProgressPage createState() => _ProgressPage(storeID);
}
String img = img0;
String img0 = "https://media.istockphoto.com/vectors/hourglass-icon-simple-flat-style-sandglass-illustration-vector-id1039032938";
String img1 = "https://cdn1.everten.com.au/media/wysiwyg/deliveryinfoimages/deliveryTruck_5.1539672900.png";
String img2 = "https://i.pinimg.com/736x/17/45/ec/1745ec05166a6c4a3e61c5533eb6883d.jpg";
String img3 = "https://miro.medium.com/max/720/1*pCcEZ-0Hj6dp1jpCBZsJGg.jpeg";
int count = 0;
TextEditingController _textFieldController = TextEditingController();

const double CAMERA_ZOOM = 11;
const LatLng SOURCE_LOCATION = LatLng(10.839358, 106.748592);
const LatLng DEST_LOCATION = LatLng(10.784523, 106.746328);

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




class _ProgressPage extends State<ProgressPage> {
  String storeID;
  _ProgressPage(this.storeID);

  int num = 12;
  var myOrder;
  String shipper = "Trần Thảo Linh";
  List<OrderDetail> order;
  StoreModel market;
  Shipper ship;
  Future<void> getMyOrder() async {
    final myService1 = OrderApiService.create();
    final mySth = await myService1.getOrderByID(ID);
    myOrder = mySth;
    order = mySth.body.details;

    final myService2 = MarketDetailApiService.create();
    final response = await myService2.getStoreByID(storeID);
    market = response.body;

//    if(num != 12){
//      print(myOrder.body.shipper);
//      final myService2 = AccountApiService.create();
//      final response2 = await myService2.getShipperByID(myOrder.body.shipper);
//      ship = response2.body;
//      shipper = "${utf8.decode(latin1.encode(ship.lastName), allowMalformed: true)}" + " " +
//          "${utf8.decode(latin1.encode(ship.middleName), allowMalformed: true)}" + " " +
//          "${utf8.decode(latin1.encode(ship.firstName), allowMalformed: true)}";
//      print(shipper);
//    }

//    final query = "${utf8.decode(latin1.encode(myOrder.body.addressDelivery), allowMalformed: true)}";
//    var addresses = await Geocoder.local.findAddressesFromQuery(query);
//    var first = addresses.first;

//    DEST_LOCATION = LatLng(first.coordinates.latitude, first.coordinates.longitude);
//    print(DEST_LOCATION);
//    print("${first.featureName} : ${first.coordinates}");

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
      showOnWayToast(context);
      setState(() {
        status = 12;
      });

      print(status);
    }
    if(status == 22){
      num = 22;
      img = img2;
      showOnShoppingToast(context);
      setState(() {
        status = 12;
      });

      print(status);
    }
    if(status == 23){
      num = 23;
      showOnDeliveryToast(context);
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

    if(status == -21 || status == -22 || status == -23 || status == -24 || status == -31){
      num = 0;
      showOnCancelFromShipperToast(context);
      setState(() {
        status = 0;
      });

      print(status);
    }
  }

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
    //if(num == 23){
    setInitialLocation();
    //}

  }


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
            title: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(bottom: 10.0),
                  child: Image.network(
                    'https://cdn.iconscout.com/icon/free/png-256/avatar-370-456322.png',
                    fit: BoxFit.cover,
                    height: 100.0,
                    width: 100.0,
                    alignment: Alignment.center,
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(top:10.0, bottom: 10.0),
                  child: Text(
                    "Giao hàng hoàn tất",
                    style: TextStyle(
                      fontSize: 19.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Container(
                  child: Text(
                    "Hãy đánh giá chất lượng",
                    style: TextStyle(
                      fontSize: 17.0,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(bottom: 10.0),
                  child: Text(
                    "dịch vụ giao hàng của shipper",
                    style: TextStyle(
                      fontSize: 17.0,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(bottom: 10.0),
                  child: RatingBar(
                    initialRating: 0,
                    minRating: 1,
                    direction: Axis.horizontal,
                    allowHalfRating: true,
                    itemCount: 5,
                    itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                    itemBuilder: (context, _) => Icon(
                      Icons.star,
                      color: Colors.amber,
                    ),
                    onRatingUpdate: (rating) {
                      print(rating);
                    },
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(width: 1.0, color: Colors.grey[300]),
                      top: BorderSide(width: 1.0, color: Colors.grey[300]),
                    ),
                  ),
                  child: Row(
                    children: <Widget>[
                      Container(
                        margin: const EdgeInsets.only(left: 10.0),
                        width: MediaQuery.of(context).size.width * 0.45,
                        padding: const EdgeInsets.only(bottom: 15.0, top: 10.0),
                        child: Text(
                          'Tổng Tiền',
                          style: TextStyle(
                            fontSize: 14.0,
                            fontWeight: FontWeight.normal,
                            color: Colors.grey[700],
                          ),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.only(bottom: 15.0, top: 10.0),
                        child: Text(
                          '${oCcy.format(myOrder.body.totalCost)}đ',
                          style: TextStyle(
                            fontSize: 14.0,
                            fontWeight: FontWeight.normal,
                            color: Colors.grey[700],
                          ),
                        ),
                      ),

                    ],

                  ),
                ),
              ],
            ),
            content: TextFormField(
              decoration: const InputDecoration(
                //icon: Icon(Icons.feedback),
                hintText: 'Feedback...',
                //labelText: 'Name *',
              ),
              onSaved: (String value) {
                // This optional block of code can be used to run
                // code when the user saves the form.
              },
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

  showOnWayToast(BuildContext context) async {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Column(
              children: <Widget>[
                Container(
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(width: 1.0, color: Colors.grey),
                    ),
                  ),
                  margin: EdgeInsets.only(bottom: 10.0),

                  child: ListTile(
                    leading: CircleAvatar(
                      radius: 20,
                      backgroundImage: NetworkImage("https://cdn.iconscout.com/icon/free/png-256/avatar-370-456322.png"),
                    ),
                    title: Text(
                      '${utf8.decode(latin1.encode(myOrder.body.shipper), allowMalformed: true)}',
                      style: TextStyle(
                        fontFamily: 'Montserrat',
                        fontSize: 15.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    subtitle: Text(
                      'Jupiter Yamaha - 72C1-79945',
                      style: TextStyle(
                        fontFamily: 'Montserrat',
                        fontSize: 14.0,
                      ),
                    ),

                  ),
                ),
                Container(
                  child: Text(
                    "Shipper đã nhận đơn và đang trên đường tới siêu thị ${utf8.decode(latin1.encode(market.name), allowMalformed: true)}",
                    style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                ),
              ],
            ),
            actions: <Widget>[
              new FlatButton(
                child: new Text('Xác Nhận'),
                onPressed: () => Navigator.pop(context),
              )
            ],
          );
        });
  }

  showOnShoppingToast(BuildContext context) async {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Column(
              children: <Widget>[
                Container(
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(width: 1.0, color: Colors.grey),
                    ),
                  ),
                  margin: EdgeInsets.only(bottom: 10.0),

                  child: ListTile(
                    leading: CircleAvatar(
                      radius: 20,
                      backgroundImage: NetworkImage("https://cdn.iconscout.com/icon/free/png-256/avatar-370-456322.png"),
                    ),
                    title: Text(
                      '${utf8.decode(latin1.encode(myOrder.body.shipper), allowMalformed: true)}',
                      style: TextStyle(
                        fontFamily: 'Montserrat',
                        fontSize: 15.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    subtitle: Text(
                      'Jupiter Yamaha - 72C1-79945',
                      style: TextStyle(
                        fontFamily: 'Montserrat',
                        fontSize: 14.0,
                      ),
                    ),

                  ),
                ),
                Container(
                  child: Text(
                    "Shipper đã tới siêu thị. Hãy luôn giữ điện thoại sẵn sàng để shipper có thể liên lạc với bạn khi cần thiết trong quá trình mua hàng nếu sản phẩm hết hàng hoặc thay đổi về số lượng.",
                    style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                ),
              ],
            ),
            actions: <Widget>[
              new FlatButton(
                child: new Text('Xác Nhận'),
                onPressed: () => Navigator.pop(context),
              )
            ],
          );
        });
  }

  showOnDeliveryToast(BuildContext context) async {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Column(
              children: <Widget>[
                Container(
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(width: 1.0, color: Colors.grey),
                    ),
                  ),
                  margin: EdgeInsets.only(bottom: 10.0),

                  child: ListTile(
                    leading: CircleAvatar(
                      radius: 20,
                      backgroundImage: NetworkImage("https://cdn.iconscout.com/icon/free/png-256/avatar-370-456322.png"),
                    ),
                    title: Text(
                      '${utf8.decode(latin1.encode(myOrder.body.shipper), allowMalformed: true)}',
                      style: TextStyle(
                        fontFamily: 'Montserrat',
                        fontSize: 15.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    subtitle: Text(
                      'Jupiter Yamaha - 72C1-79945',
                      style: TextStyle(
                        fontFamily: 'Montserrat',
                        fontSize: 14.0,
                      ),
                    ),

                  ),
                ),
                Container(
                  child: Text(
                    "Shipper đã mua hàng hoàn tất và sắp giao đơn hàng từ ${utf8.decode(latin1.encode(market.name), allowMalformed: true)} đến cho bạn. Hãy luôn giữ điện thoại sẵn sàng liên lạc nhé!",
                    style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                ),
              ],
            ),
            actions: <Widget>[
              new FlatButton(
                child: new Text('Xác Nhận'),
                onPressed: () => Navigator.pop(context),
              )
            ],
          );
        });
  }

  showOnCancelFromShipperToast(BuildContext context) async {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Column(
              children: <Widget>[
                Container(

                  margin: EdgeInsets.only(bottom: 10.0),

                  child: Container(
                    height: 70.0,
                    width: 70.0,
                    child: Image.network("https://st2.depositphotos.com/5266903/8456/v/950/depositphotos_84568968-stock-illustration-cancel-flat-red-color-icon.jpg",
                      fit: BoxFit.cover,
                      height: double.infinity,
                      width: double.infinity,
                      alignment: Alignment.center,),
                  ),
                ),
                Container(
                  child: Text(
                    "Opps đơn hàng của bạn tại ${utf8.decode(latin1.encode(market.name), allowMalformed: true)} đã bị hủy. Số tiền sẽ được hoàn lại vào tài khoản của bạn, vui lòng đặt lại đơn khác. Chúng tôi rất xin lỗi vì sự bất tiện này",
                    style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                ),
              ],
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
              padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
              width: MediaQuery.of(context).size.width * 0.9,
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
                          "Shipper đã nhận đơn",
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
                          "Shipper đang mua hàng",
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
                          "Shipper đang giao hàng",
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
                          "Shipper đã nhận đơn",
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
                          "Shipper đang mua hàng",
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
                          "Shipper đang giao hàng",
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
                          "Shipper đã nhận đơn",
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
                          "Shipper đang mua hàng",
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
                          "Shipper đang giao hàng",
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
        if(num != 12)
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
                  '${utf8.decode(latin1.encode(myOrder.body.shipper), allowMalformed: true)}',
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
                  "${utf8.decode(latin1.encode(market.addr1), allowMalformed: true)}" + " "
                  + "${utf8.decode(latin1.encode(market.addr2), allowMalformed: true)}" + " "
                  + "${utf8.decode(latin1.encode(market.addr3), allowMalformed: true)}" + " "
                  + "${utf8.decode(latin1.encode(market.addr4), allowMalformed: true)}",
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
                      '${utf8.decode(latin1.encode(market.name), allowMalformed: true)}',
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