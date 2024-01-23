class UserModel {
  int? id;
  String? name;
  String? email;
  String? username;
  int? verivied;
  String? profilePicture;
  int? balance;
  String? cardNumber;
  String? pin;
  String? token;
  String? password;

  UserModel({
    this.id,
    this.name,
    this.email,
    this.username,
    this.verivied,
    this.profilePicture,
    this.balance,
    this.cardNumber,
    this.pin,
    this.token,
    this.password,
  });

  factory UserModel.fromjson(Map<String, dynamic> json) => UserModel(
    id: json["id"],
    name: json["name"],
    email: json["email"],
    username: json["username"],
    verivied: json["verified"],
    profilePicture: json["profile_picture"],
    balance: json["balance"],
    cardNumber: json["card_number"],
    pin: json["pin"],
    token: json["token"],
  );

  UserModel copyWith({
    String? username,
    String? name,
    String? email,
    String? pin,
    String? password,
    int? balance,
  }){
    return UserModel(
      id: id,
      username: username ?? this.username,
      name: name ?? this.name,
      email: email ?? this.email,
      pin: pin ?? this.pin,
      password: password ?? this.password,
      balance: balance ?? this.balance,
      verivied: verivied,
      profilePicture: profilePicture,
      cardNumber: cardNumber,
      token: token
    );
  }
}