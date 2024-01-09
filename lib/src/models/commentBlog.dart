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
  List<SubCommentBlog>? lsSubComment;

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
      this.userReply,
      this.lsSubComment});

  factory commentBlog.fromJson(Map<String, dynamic> json) => commentBlog(
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
      userReply: json['userReply'],
      lsSubComment: List<SubCommentBlog>.from(
          json["lsSubComment"].map((x) => SubCommentBlog.fromJson(x))));
  Map<String, dynamic> toJson() => {
        "id": id,
        "idAccount": idAccount,
        "idBlog": idBlog,
        "indC": indC,
        "comment": comment,
        "status": status,
        "dateCreate": dateCreate,
        "mnC": mnC,
        "userType": userType,
        "idReply": idReply,
        "userAvatar": userAvatar,
        "userName": userName,
        "userReply": userReply,
        "lsSubComment": List<dynamic>.from(lsSubComment!.map((x) => x.toJson())),
      };
  List<SubCommentBlog> getSubComments() => lsSubComment!;
}

class SubCommentBlog {
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

  SubCommentBlog({
    this.id,
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
    this.userReply,
  });

  factory SubCommentBlog.fromJson(Map<String, dynamic> json) => SubCommentBlog(
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
  Map<String, dynamic> toJson() => {
        "id": id,
        "idAccount": idAccount,
        "idBlog": idBlog,
        "indC": indC,
        "comment": comment,
        "status": status,
        "dateCreate": dateCreate,
        "mnC": mnC,
        "userType": userType,
        "idReply": idReply,
        "userAvatar": userAvatar,
        "userName": userName,
        "userReply": userReply,
      };
}
