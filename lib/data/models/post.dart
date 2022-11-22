class Post {
  int id;
  String? title;
  String? avatar;

  Post({required this.id, this.title, this.avatar});

  Post.fromJSON(Map<String, dynamic> json)
      : this(
            id: json["id"],
            title: json["title"],
            avatar:
                "https://w7.pngwing.com/pngs/503/185/png-transparent-online-quiz-general-knowledge-test-question-test-game-text-trademark-thumbnail.png");
}
