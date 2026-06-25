class UserModel {
  String image;
  String email;
  String pinCode;
  String address;
  String city;
  String state;
  String country;
  String bankNumber;
  String accountName;
  String ific;

  UserModel({
    required this.image,
    required this.email,
    required this.pinCode,
    required this.address,
    required this.city,
    required this.state,
    required this.country,
    required this.bankNumber,
    required this.accountName,
    required this.ific,
  });

  factory UserModel.empty(String email) {
    return UserModel(
      image: "",
      email: email,
      pinCode: "",
      address: "",
      city: "",
      state: "",
      country: "",
      bankNumber: "",
      accountName: "",
      ific: "",
    );
  }

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
    image: json['image'] ?? '',
    email: json['email'] ?? '',
    pinCode: json['pinCode'] ?? '',
    address: json['address'] ?? '',
    city: json['city'] ?? '',
    state: json['state'] ?? '',
    country: json['country'] ?? '',
    bankNumber: json['bankNumber'] ?? '',
    accountName: json['accountName'] ?? '',
    ific: json['ific'] ?? '',
  );

  UserModel copyWith({
    String? image,
    String? email,
    String? pinCode,
    String? address,
    String? city,
    String? state,
    String? country,
    String? bankNumber,
    String? accountName,
    String? ific,
  }) {
    return UserModel(
      image: image ?? this.image,
      email: email ?? this.email,
      pinCode: pinCode ?? this.pinCode,
      address: address ?? this.address,
      city: city ?? this.city,
      state: state ?? this.state,
      country: country ?? this.country,
      bankNumber: bankNumber ?? this.bankNumber,
      accountName: accountName ?? this.accountName,
      ific: ific ?? this.ific,
    );
  }

  Map<String, dynamic> toJson() => {
    "image": image,
    "email": email,
    "pinCode": pinCode,
    "address": address,
    "city": city,
    "state": state,
    "country": country,
    "bankNumber": bankNumber,
    "accountName": accountName,
    "ific": ific,
  };
}
