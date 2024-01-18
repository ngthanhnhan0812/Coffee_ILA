class commentBlog {
  int? id;
  String? comment;
  int? timeSpace;
  String? dateCreate;
  int? idAccount;
  String? userName;
  String? userAvatar;
  int? countSubC;
  List<SubCommentBlog>? lsSubComment;

  commentBlog(
      {this.id,
      this.idAccount,
      this.comment,
      this.dateCreate,
      this.userAvatar,
      this.userName,
      this.lsSubComment,
      this.countSubC,
      this.timeSpace});

  factory commentBlog.fromJson(Map<String, dynamic> json) => commentBlog(
      id: json['id'],
      idAccount: json['idAccount'],
      comment: json['comment'],
      dateCreate: json['dateCreate'],
      userAvatar: json['userAvatar'],
      userName: json['userName'],
      countSubC: json['countSubC'],
      timeSpace: json['timeSpace'],
      lsSubComment: List<SubCommentBlog>.from(
          json["lsSubComment"].map((x) => SubCommentBlog.fromJson(x))));
  Map<String, dynamic> toJson() => {
        "id": id,
        "idAccount": idAccount,
        "comment": comment,
        "dateCreate": dateCreate,
        "userAvatar": userAvatar,
        "userName": userName,
        "countSubC": countSubC,
        "timeSpace": timeSpace,
        "lsSubComment":
            List<dynamic>.from(lsSubComment!.map((x) => x.toJson())),
      };
  List<SubCommentBlog> getSubComments() => lsSubComment!;
}

class SubCommentBlog {
  int? id;
  String? comment;
  int? timeSpace;
  String? dateCreate;
  int? idAccount;
  String? userAvatar;
  String? userName;
  String? userReply;
  int? idMainC;
  int? idBlog;
  int? idReply;

  SubCommentBlog({
    this.id,
    this.idBlog,
    this.idAccount,
    this.comment,
    this.dateCreate,
    this.idMainC,
    this.idReply,
    this.userAvatar,
    this.userName,
    this.userReply,
    this.timeSpace,
  });

  factory SubCommentBlog.fromJson(Map<String, dynamic> json) => SubCommentBlog(
      id: json['id'],
      idAccount: json['idAccount'],
      idBlog: json['idBlog'],
      idMainC: json['idMainC'],
      comment: json['comment'],
      dateCreate: json['dateCreate'],
      idReply: json['idReply'],
      userAvatar: json['userAvatar'],
      userName: json['userName'],
      userReply: json['userReply'],
      timeSpace: json['timeSpace']);
  Map<String, dynamic> toJson() => {
        "id": id,
        "idAccount": idAccount,
        "idBlog": idBlog,
        "idMainC": idMainC,
        "comment": comment,
        "dateCreate": dateCreate,
        "idReply": idReply,
        "userAvatar": userAvatar,
        "userName": userName,
        "userReply": userReply,
      };
}
