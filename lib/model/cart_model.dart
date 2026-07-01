class CartModel {
  String id;
  String productId;
  String name;
  String price;
  String image;
  int quantity;

  CartModel({
    required this.id,
    required this.productId,
    required this.name,
    required this.price,
    required this.image,
    required this.quantity,
  });

  CartModel copyWith({
    String? id,
    String? productId,
    String? name,
    String? price,
    String? image,
    int? quantity,
  }) =>
      CartModel(
        id: id ?? this.id,
        productId: productId ?? this.productId,
        name: name ?? this.name,
        price: price ?? this.price,
        image: image ?? this.image,
        quantity: quantity ?? this.quantity,
      );

  factory CartModel.fromJson(Map<String, dynamic> json) => CartModel(
    id: json["id"],
    productId: json["productId"],
    name: json["name"],
    price: json["price"],
    image: json["image"],
    quantity: json["quantity"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "productId": productId,
    "name": name,
    "price": price,
    "image": image,
    "quantity": quantity,
  };
}
