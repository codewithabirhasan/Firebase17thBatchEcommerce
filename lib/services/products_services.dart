import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_class_seventeen_batch/model/product_model.dart';

import 'cloudniary_service.dart';

class ProductsServices {
  final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

  final CloudniaryService cloudniaryService = CloudniaryService();

  CollectionReference<Map<String, dynamic>> get productCollection =>
      firebaseFirestore.collection("products");

  Future addProduct(ProductModel productModel, File imagefile) async {
    final imageurl = await cloudniaryService.uploadImage(imagefile!);

    final document = productCollection.doc();

    final newProduct = productModel.copyWith(id: document.id, image: imageurl);

    await document.set(newProduct.toJson());
  }

  Stream<List<ProductModel>> getProducts() {
    return productCollection
        .snapshots()
        .map((snapshot) {
          return snapshot.docs
              .map((data) {
                print("data  ${data.data()}");
                return ProductModel.fromJson(data.data());
              })
              .toList();
        });

    // return productCollection.snapshots().map((data) {
    //   return data.docs.map((e) => ProductModel.fromJson(e.data())).toList();
    // });
  }

  Future updateproducts(ProductModel productModel, File? imagefile) async {
    var updatedData = productModel;

    if (imagefile != null) {
      final image = await cloudniaryService.uploadImage(imagefile!);

      updatedData = productModel.copyWith(image: image);
    }

    await productCollection.doc(productModel.id).update(updatedData.toJson());
  }

  Future delete(String docId) async {
    await productCollection.doc(docId).delete();
  }
}
