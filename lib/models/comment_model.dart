class CommentModel{
  String postId;
  String uId ;
  String name;
  String image;
  String dateTime;
  String text;

  CommentModel(
      this.postId,
      this.uId,
      this.name,
      this.image,
      this.dateTime,
      this.text,
      );

  CommentModel.fromJson(Map<String, dynamic> json)
      : postId = json['postId'],
        uId = json['uId'],
        name = json['name'],
        image = json['image'],
        dateTime = json['dateTime'],
        text = json['text'];

  Map <String, dynamic> toMap(){
    return {
      'postId' : postId,
      'uId':uId,
      'name':name,
      'image':image,
      'dateTime':dateTime,
      'text':text,
    };
  }
}

