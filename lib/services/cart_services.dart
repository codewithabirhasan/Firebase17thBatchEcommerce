import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_class_seventeen_batch/model/cart_model.dart';
import 'package:firebase_class_seventeen_batch/model/product_model.dart';

class CartServices {
  final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  String get uid => firebaseAuth.currentUser!.uid;

  CollectionReference<Map<String, dynamic>> get cartCollection =>
      firebaseFirestore.collection("users").doc(uid).collection("cart");

  Future addtoCard(ProductModel productModel) async {
    final exitingCart = await cartCollection
        .where("productId", isEqualTo: productModel.id)
        .get();

    if (exitingCart.docs.isNotEmpty) {
      final document = exitingCart.docs.first;

      int qnty = document["quantity"];

      await document.reference.update({"quantity": qnty + 1});

      return;
    }

    final cartDoc = cartCollection.doc();

    CartModel cartModel = CartModel(
      id: cartDoc.id,
      productId: productModel.id,
      name: productModel.name,
      image: productModel.image,
      price: productModel.price,
      quantity: 1,
    );

    await cartDoc.set(cartModel.toJson());
  }

  Stream<List<CartModel>> getCartList() {
    return cartCollection.snapshots().map((snapshot) {
      return snapshot.docs
          .map((value) => CartModel.fromJson(value.data()))
          .toList();
    });
  }

  Future incrementQuanity(CartModel cartModel) async {
    await cartCollection.doc(cartModel.id).update({
      "quantity": cartModel.quantity + 1,
    });
  }

  Future decrementQuanity(CartModel cartModel) async {
    await cartCollection.doc(cartModel.id).update({
      "quantity": cartModel.quantity - 1,
    });
  }

  Future removeCartItem(String id) async {
    await cartCollection.doc(id).delete();
  }

  Future clearCart() async {
    final data = await cartCollection.get();

    for (var documets in data.docs) {
      await documets.reference.delete();
    }
  }

  Stream<int> cartCount() {
    return cartCollection.snapshots().map((data) {
      int total = 0;

      for (var e in data.docs) {
        total += (e["quantity"] as int);
      }

      return total;
    });
  }
}
