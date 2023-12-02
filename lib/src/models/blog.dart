// ignore_for_file: public_member_api_docs, sort_constructors_first
class Blog {
  final int id;
  final int userCreate;
  final String title;
  final String image;
  final String description;
  final String createDate;
  final int isStatus;

  const Blog({
    required this.id,
    required this.userCreate,
    required this.title,
    required this.image,
    required this.description,
    required this.createDate,
    required this.isStatus,
  });

  factory Blog.fromJson(Map<String, dynamic> json) {
    return Blog(
        id: json['id'],
        userCreate: json['userCreate'],
        title: json['title'],
        image: json['image'],
        description: json['description'],
        createDate: json['createDate'],
        isStatus: json['isStatus']);
  }
}
