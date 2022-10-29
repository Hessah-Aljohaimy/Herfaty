class Reward {
  String imagePath;
  String title;

  Reward({required this.imagePath, required this.title});

  Map<String, dynamic> toJson() => {
        'imagePath': imagePath,
        'title': title,
      };

  static Reward fromJson(Map<String, dynamic> json) => Reward(
        imagePath: json['imagePath'],
        title: json['title'],
      );
}
