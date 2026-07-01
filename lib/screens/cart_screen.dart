import 'package:firebase_class_seventeen_batch/model/cart_model.dart';
import 'package:firebase_class_seventeen_batch/model/product_model.dart';
import 'package:firebase_class_seventeen_batch/screens/order_screens.dart';
import 'package:firebase_class_seventeen_batch/services/cart_services.dart';
import 'package:firebase_class_seventeen_batch/services/order_servioce.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  final CartServices cartServices = CartServices();
  final OrderServioce orderServioce = OrderServioce();

  List<CartModel> cartItems = [];
  var subtotal = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Cart Screen")),
      body: StreamBuilder<List<CartModel>>(
        stream: cartServices.getCartList(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          cartItems = snapshot.data ?? [];

          // for (var item in cartItems) {
          //   subtotal += int.parse(item.price) * item.quantity;
          //
          // }


          subtotal = cartItems.fold(
            0,
                (total, item) => total + (int.parse(item.price) * item.quantity),
          );




          print("Cart Items Length : ${cartItems.length}");

          return Column(
            children: [
              Expanded(
                child: ListView.builder(
                  shrinkWrap: true,
                  primary: false,
                  itemCount: cartItems.length,
                  itemBuilder: (_, index) {
                    var cartModel = cartItems[index];

                    return Card(
                      elevation: 3,
                      child: ListTile(
                        title: Text("${cartItems[index].name}"),
                        subtitle: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,

                          children: [
                            Image.network(
                              "${cartItems[index].image}",
                              height: 200,
                              width: double.infinity,
                              fit: BoxFit.fill,
                            ),

                            Text(
                              "Qunatity : ${cartItems[index].quantity}",
                              style: TextStyle(color: Colors.red, fontSize: 20),
                            ),
                            Text(
                              "Price : ${cartItems[index].quantity * int.parse(cartItems[index].price)}",
                              style: TextStyle(color: Colors.red),
                            ),

                            SizedBox(height: 10),

                            Row(
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                    color: Colors.red,
                                    borderRadius: BorderRadius.circular(10),
                                  ),

                                  child: IconButton(
                                    onPressed: () async {
                                      await cartServices.incrementQuanity(
                                        cartModel,
                                      );
                                    },
                                    icon: Icon(Icons.add, color: Colors.white),
                                  ),
                                ),

                                SizedBox(width: 15),
                                Container(
                                  decoration: BoxDecoration(
                                    color: Colors.red,
                                    borderRadius: BorderRadius.circular(10),
                                  ),

                                  child: IconButton(
                                    onPressed: () async {
                                      await cartServices.decrementQuanity(
                                        cartModel,
                                      );
                                    },
                                    icon: Icon(
                                      Icons.minimize,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),

              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 28.0, bottom: 20),
                    child: Text(
                      "Subtotal :   ${subtotal}",
                      style: TextStyle(fontSize: 22, color: Colors.black),
                    ),
                  ),
                ],
              ),

              Padding(
                padding: const EdgeInsets.only(bottom: 38.0, left: 20, right: 20),
                child: GestureDetector(
                  onTap: () async {
                    await orderServioce.checkoutFunction(cartItems);
                    await cartServices.clearCart();

                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => OrderScreens()),
                    );
                  },
                  child: Container(
                    alignment: Alignment.center,
                    height: 50,
                    width: double.infinity,
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text(
                      "Order Place ",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
