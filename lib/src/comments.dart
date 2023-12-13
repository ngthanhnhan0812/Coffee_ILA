// ignore: file_names
import 'package:comment_tree/comment_tree.dart';

import 'package:flutter/material.dart';

class Comments extends StatefulWidget {
  final List<Comment> commentList;

  const Comments({super.key, required this.commentList});

  @override
  State<Comments> createState() => _CommentsState();
}

class _CommentsState extends State<Comments> {
  bool reply = false;

  final List<Comment> commentLi = [
    Comment(
      avatar: 'nukkll',
      userName: 'thanhh nhan',
      content: 'abcyxz',
    ),
    Comment(
      avatar: 'aksldjaklsdj',
      userName: 'nyann',
      content: 'muop oi muopp',
    ),
    Comment(
      avatar: 'zxczxc',
      userName: 'trung viet',
      content: 'kakaka',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
          child: CommentTreeWidget<Comment, Comment>(
            commentLi[0],
            [
              commentLi[0],
              commentLi[1],
            ],
            treeThemeData: const TreeThemeData(
                lineColor: Color.fromARGB(255, 233, 229, 229), lineWidth: 2),
            avatarRoot: (context, data) => const PreferredSize(
              preferredSize: Size.fromRadius(18),
              child: CircleAvatar(
                  radius: 20,
                  backgroundColor: Colors.grey,
                  backgroundImage: NetworkImage(
                      "https://i.pinimg.com/736x/6f/de/85/6fde85b86c86526af5e99ce85f57432e.jpg")),
            ),
            avatarChild: (context, data) => const PreferredSize(
              preferredSize: Size.fromRadius(12),
              child: CircleAvatar(
                  radius: 14,
                  backgroundColor: Colors.grey,
                  backgroundImage: NetworkImage(
                      "https://i.pinimg.com/736x/6f/de/85/6fde85b86c86526af5e99ce85f57432e.jpg")),
            ),
            contentRoot: (context, data) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding:
                        const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                    decoration: BoxDecoration(
                        color: Colors.grey[100],
                        borderRadius: BorderRadius.circular(12)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Nguyễn Thành Nhân',
                          style:
                              Theme.of(context).textTheme.bodySmall!.copyWith(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                  ),
                        ),
                        const SizedBox(
                          height: 4,
                        ),
                        Text(
                          '${data.content}',
                          style: Theme.of(context)
                              .textTheme
                              .bodySmall!
                              .copyWith(fontSize: 14, color: Colors.black),
                        ),
                      ],
                    ),
                  ),
                  DefaultTextStyle(
                    style: Theme.of(context).textTheme.bodySmall!.copyWith(
                        color: Colors.grey[700], fontWeight: FontWeight.bold),
                    child: const Padding(
                      padding: EdgeInsets.only(top: 4),
                      child: Row(
                        children: [
                          SizedBox(
                            width: 8,
                          ),
                          Text('5d'),
                          SizedBox(
                            width: 24,
                          ),
                          Text('Reply'),
                        ],
                      ),
                    ),
                  )
                ],
              );
            },
            contentChild: (context, data) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding:
                        const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                    decoration: BoxDecoration(
                        color: Colors.grey[100],
                        borderRadius: BorderRadius.circular(12)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '${data.userName}',
                          style: Theme.of(context)
                              .textTheme
                              .bodySmall
                              ?.copyWith(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black),
                        ),
                        const SizedBox(
                          height: 4,
                        ),
                        Text(
                          '${data.content}',
                          style:
                              Theme.of(context).textTheme.bodySmall?.copyWith(
                                  fontSize: 14,
                                  // fontWeight: FontWeight.w300,
                                  color: Colors.black),
                        ),
                      ],
                    ),
                  ),
                  DefaultTextStyle(
                    style: Theme.of(context).textTheme.bodySmall!.copyWith(
                        color: Colors.grey[700], fontWeight: FontWeight.bold),
                    child: const Padding(
                      padding: EdgeInsets.only(top: 4),
                      child: Row(
                        children: [
                          SizedBox(
                            width: 8,
                          ),
                          Text('5d'),
                          SizedBox(
                            width: 24,
                          ),
                          Text('Reply'),
                        ],
                      ),
                    ),
                  )
                ],
              );
            },
          ),
        ),
      ],
    );
  }
}
