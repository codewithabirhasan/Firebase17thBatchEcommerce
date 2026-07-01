import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_class_seventeen_batch/model/cart_model.dart';
import 'package:firebase_class_seventeen_batch/model/order_model.dart';

class OrderServioce {
  final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  String get uid => firebaseAuth.currentUser!.uid;

  CollectionReference<Map<String, dynamic>> get orderCollection =>
      firebaseFirestore.collection("users").doc(uid).collection("orders");

  Future checkoutFunction(List<CartModel> cartItems) async {
    int total = 0;

    List<Map<String, dynamic>> items = [];

    for (var item in cartItems) {
      total += int.parse(item.price) * item.quantity;

      items.add(item.toJson());
    }

    final documets = orderCollection.doc();

    OrderModel orderModel = OrderModel(
      id: documets.id,
      total: total,
      items: items,
    );

    await documets.set(orderModel.toJson());

  }

  Stream<List<OrderModel>> getOrderList() {
    return orderCollection.snapshots().map((snapshot) {
      return snapshot.docs
          .map((value) => OrderModel.fromJson(value.data()))
          .toList();
    });
  }
}
