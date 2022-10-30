class Reward {
  String imagePath;
  String title;
  num order;

  Reward({required this.order, required this.imagePath, required this.title});

  Map<String, dynamic> toJson() => {
        'imagePath': imagePath,
        'title': title,
        'order': order,
      };

  static Reward fromJson(Map<String, dynamic> json) => Reward(
        imagePath: json['imagePath'],
        title: json['title'],
        order: json['order'],
      );
}
