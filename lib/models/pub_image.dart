class PubImage {
  String imageUrl;
  String id_pub;
  PubImage({required this.imageUrl, required this.id_pub});

  factory PubImage.fromjson(dynamic json) {
    return PubImage(imageUrl: json['image'], id_pub: json['id_pub']);
  }
}
