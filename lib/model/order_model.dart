class OrderModel {
  final String id;
  final int total;
  final List<Map<String, dynamic>> items;

  OrderModel({required this.id, required this.total, required this.items});

  factory OrderModel.fromJson(Map<String, dynamic> json) {
    return OrderModel(
      id: json["id"],
      total: json["total"],
      items: List<Map<String, dynamic>>.from(json["items"]),
    );
  }

  Map<String, dynamic> toJson() {
    return {"id": id, "total": total, "items": items};
  }
}
