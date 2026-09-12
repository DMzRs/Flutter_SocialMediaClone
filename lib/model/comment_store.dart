import 'usercomment.dart';
import 'userdata.dart';
import 'userpost.dart';

/// Store Comment
class CommentStore {
  CommentStore._();

  static final Map<String, List<Usercomment>> _byPostId = {};

  static String postId(Userpost post) =>
      '${post.username}|${post.time}|${post.postcontent}';

  static List<Usercomment> commentsFor(Userpost post) {
    final id = postId(post);
    return _byPostId.putIfAbsent(id, () => List<Usercomment>.from(
          Userdata().commentList,
        ));
  }

  static void addComment(Userpost post, Usercomment comment) {
    commentsFor(post).insert(0, comment);
  }
}
