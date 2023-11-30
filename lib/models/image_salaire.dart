class ImageSalaire {
  int im_sal_id;
  int id_debouche;
  String image_link, salaire;
  ImageSalaire(
      {required this.id_debouche,
      required this.im_sal_id,
      required this.image_link,
      required this.salaire});

  factory ImageSalaire.fromJson(dynamic data) {
    return ImageSalaire(
        id_debouche: data['id_debouche'],
        im_sal_id: data['image_id'],
        image_link: data['link'],
        salaire: data['salaire']);
  }
}
