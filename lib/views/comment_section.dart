import 'package:flutter/material.dart';
import '../model/comment_store.dart';
import '../model/usercomment.dart';
import '../model/userdata.dart';
import '../model/userpost.dart';

/// Displays the comments for userPost and lets the user add a new one. Connected to CommentStore to manage the comments.
class CommentSection extends StatefulWidget {
  const CommentSection({super.key, required this.userPost});

  final Userpost userPost;

  @override
  State<CommentSection> createState() => _CommentSectionState();
}

class _CommentSectionState extends State<CommentSection> {
  final TextEditingController _controller = TextEditingController();
  late final Userdata _userdata;

  @override
  void initState() {
    super.initState();
    _userdata = Userdata();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _submit() {
    final text = _controller.text.trim();
    if (text.isEmpty) return;
    CommentStore.addComment(
      widget.userPost,
      Usercomment(
        commenterImg: _userdata.myUserAccount.img,
        commenterName: _userdata.myUserAccount.name,
        commentTime: 'Just now',
        commentContent: text,
      ),
    );
    _controller.clear();
    FocusScope.of(context).unfocus();
    setState(() {});
  }

  Widget _commentTile(Usercomment comment) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 8.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CircleAvatar(
              backgroundImage: AssetImage(comment.commenterImg),
              radius: 18,
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade200,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          comment.commenterName,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(comment.commentContent),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 4.0, left: 8.0),
                    child: Row(
                      children: [
                        Text(
                          comment.commentTime,
                          style: TextStyle(
                              fontSize: 12, color: Colors.grey.shade600),
                        ),
                        const SizedBox(width: 15),
                        Text(
                          'Like',
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: Colors.grey.shade700,
                          ),
                        ),
                        const SizedBox(width: 15),
                        Text(
                          'Reply',
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: Colors.grey.shade700,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      );

  Widget _inputBar() => Padding(
        padding: const EdgeInsets.fromLTRB(15, 8, 15, 15),
        child: Row(
          children: [
            CircleAvatar(
              backgroundImage: AssetImage(_userdata.myUserAccount.img),
              radius: 18,
            ),
            const SizedBox(width: 10),
            Expanded(
              child: TextField(
                controller: _controller,
                textInputAction: TextInputAction.send,
                onSubmitted: (_) => _submit(),
                decoration: InputDecoration(
                  hintText: 'Write a comment...',
                  contentPadding: const EdgeInsets.symmetric(
                      horizontal: 14, vertical: 10),
                  filled: true,
                  fillColor: Colors.grey.shade200,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 8),
            IconButton(
              onPressed: _submit,
              icon: const Icon(Icons.send),
              color: Colors.blue,
              tooltip: 'Post comment',
            ),
          ],
        ),
      );

  @override
  Widget build(BuildContext context) {
    final comments = CommentStore.commentsFor(widget.userPost);
    return Column(
      children: [
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: comments.length,
          itemBuilder: (context, i) => _commentTile(comments[i]),
        ),
        _inputBar(),
      ],
    );
  }
}
