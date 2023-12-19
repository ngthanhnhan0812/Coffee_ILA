class commentBlog {
  int? id;
  int? idBlog;
  int? idAccount;
  String? comment;
  String? dateCreate;
  int? indC;
  int? mnC;
  int? status;
  int? userType;
  String? userName;
  String? userAvatar;
  String? userReply;
  int? idReply;

  commentBlog(
      {this.id,
      this.idBlog,
      this.idAccount,
      this.comment,
      this.dateCreate,
      this.indC,
      this.mnC,
      this.status,
      this.userType,
      this.idReply,
      this.userAvatar,
      this.userName,
      this.userReply});

  factory commentBlog.fromJson(Map<String, dynamic> json) {
    return commentBlog(
        id: json['id'],
        idAccount: json['idAccount'],
        idBlog: json['idBlog'],
        indC: json['indC'],
        comment: json['comment'],
        status: json['status'],
        dateCreate: json['dateCreate'],
        mnC: json['mnC'],
        userType: json['userType'],
        idReply: json['idReply'],
        userAvatar: json['userAvatar'],
        userName: json['userName'],
        userReply: json['userReply']);
  }
}
