/// The [dart:async] is necessary for using streams
import 'dart:async';

class CartItemsBloc {
  /// The [cartStreamController] is an object of the StreamController class
  /// .broadcast enables the stream to be read in multiple screens of our app
  final cartStreamController = StreamController.broadcast();

  /// The [getStream] getter would be used to expose our stream to other classes
  Stream get getStream => cartStreamController.stream;

  /// The [allItems] Map would hold all the data this bloc provides
  Map addItems = {
    'shop items': [
//      {'name': 'App dev kit', 'price': 20, 'id': 1},
//      {'name': 'App consultation', 'price': 100, 'id': 2},
//      {'name': 'Logo Design', 'price': 10, 'id': 3},
//      {'name': 'Code review', 'price': 90, 'id': 4},
    ],
//    'cart items': []
  };

  /// [addToCart] adds items from the shop to the cart
  void addToCart(item) {
    addItems['shop items'].add(item);
//    addItems['cart items'].add(item);
    cartStreamController.sink.add(addItems);
  }

  /// [removeFromCart] removes items from the cart, back to the shop
  void removeFromCart(item) {
    addItems['cart items'].remove(item);
    addItems['shop items'].add(item);
    cartStreamController.sink.add(addItems);
  }

  /// The [dispose] method is used
  /// to automatically close the stream when the widget is removed from the widget tree
  void dispose() {
    cartStreamController.close(); // close our StreamController
  }
}

final bloc = CartItemsBloc();