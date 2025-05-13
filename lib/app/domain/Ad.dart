class Ad{
  final int id;
  final String image;
  final String url;
  final String title;

  Ad({
    required this.id,
    required this.image,
    required this.url,
    required this.title,
  });

  // Método para convertir un JSON en un objeto Ad
  factory Ad.fromJson(Map<String, dynamic> json) {
    return Ad(
      id: json['id'] as int,
      image: json['image'] as String,
      url: json['url'] as String,
      title: json['title'] as String,
    );
  }

  // Método para convertir un objeto Ad en JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'image': image,
      'url': url,
      'title': title,
    };
  }
}