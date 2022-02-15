class SocialUsersModel{
  String uId;
  String name;
  String email;
  String phone;

  SocialUsersModel(
    this.uId,
    this.name,
    this.email,
    this.phone
  );

  SocialUsersModel.fromJson(Map<String, dynamic> json)
  : uId = json['uId'],
    name = json['name'],
    email = json['email'],
    phone = json['phone'];

  Map <String, dynamic> toMap(){
    return {
      'uId':uId,
      'name':name,
      'email':email,
      'phone':phone
    };
  }
}

