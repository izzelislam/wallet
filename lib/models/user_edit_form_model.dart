class UserEditFormModel {
  final String name;
  final String username;
  final String email;
  final String password;

  UserEditFormModel({
    required this.name,
    required this.username,
    required this.email,
    required this.password,
  });

  Map<String, dynamic> toJson(){
    return {
      'name' : name,
      'username' : username,
      'email' : email,
      'password': password
    };
  }

}