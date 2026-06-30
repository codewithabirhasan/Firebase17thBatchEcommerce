import 'package:firebase_class_seventeen_batch/model/product_model.dart';
import 'package:firebase_class_seventeen_batch/services/products_services.dart';
import 'package:flutter/material.dart';

class ProductScreen extends StatefulWidget {
  const ProductScreen({super.key});

  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  final ProductsServices productsServices = ProductsServices();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Product Screen")),
      body: StreamBuilder<List<ProductModel>>(
        stream: productsServices.getProducts(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          final produts = snapshot.data ?? [];

          print(" Length ${produts.length}");
          return ListView.builder(
            shrinkWrap: true,
            primary: false,
            itemCount: produts.length,
            itemBuilder: (_, index) {
              return Card(
                elevation: 3,
                child: ListTile(
                  title: Text("${produts[index].name}"),
                  subtitle: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,

                    children: [
                      Text(
                        "${produts[index].description}",
                        style: TextStyle(color: Colors.red),
                      ),
                      Text(
                        "${produts[index].price}",
                        style: TextStyle(color: Colors.red),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
