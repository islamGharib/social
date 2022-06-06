class PostModel{
  String uId ;
  String name;
  String image;
  String text;
  String postImage;
  String dateTime;

  PostModel(
      this.uId,
      this.name,
      this.image,
      this.text,
      this.postImage,
      this.dateTime,
      );

  PostModel.fromJson(Map<String, dynamic> json)
      : uId = json['uId'],
        name = json['name'],
        image = json['image'],
        text = json['text'],
        postImage = json['postImage'],
        dateTime = json['dateTime'];

  Map <String, dynamic> toMap(){
    return {
      'uId':uId,
      'name':name,
      'image':image,
      'text':text,
      'postImage':postImage,
      'dateTime':dateTime,
    };
  }
}

