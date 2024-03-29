import 'package:flutter/material.dart';

class CommentCard extends StatefulWidget {
  final snap;
  const CommentCard({Key? key, required this.snap}) : super(key: key);

  @override
  _CommentCardState createState() => _CommentCardState();
}

class _CommentCardState extends State<CommentCard> {
  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: Colors.grey.shade800, // Dark grey color
        border: Border(
          bottom: BorderSide(
            color:
                Colors.white.withOpacity(0.5), // White color with 0.5 opacity
            width: 1.0, // Border width
          ),
        ),
      ),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 12),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CircleAvatar(
              backgroundImage: NetworkImage(
                widget.snap["profilePic"],
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: '${widget.snap["name"]}  ',
                            style: const TextStyle(
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          TextSpan(
                            text: '${widget.snap["commentText"]}',
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.favorite_border),
            )
          ],
        ),
      ),
    );
  }
}
