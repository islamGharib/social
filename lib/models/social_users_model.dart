class SocialUsersModel{
  String uId ;
  String name;
  String email;
  String phone;
  String image;
  String cover;
  String bio;

  SocialUsersModel(
    this.uId,
    this.name,
    this.email,
    this.phone,
      this.image,
      this.cover,
      this.bio
  );

  SocialUsersModel.fromJson(Map<String, dynamic> json)
  : uId = json['uId'],
    name = json['name'],
    email = json['email'],
    phone = json['phone'],
        image = json['image'],
        cover = json['cover'],
        bio = json['bio'];

  Map <String, dynamic> toMap(){
    return {
      'uId':uId,
      'name':name,
      'email':email,
      'phone':phone,
      'image':image,
      'cover':cover,
      'bio':bio
    };
  }
}

