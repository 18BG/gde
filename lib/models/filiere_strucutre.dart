class FiliereStrucuture {
  int structure_id;
  int filiere_id;

  FiliereStrucuture({required this.filiere_id, required this.structure_id});

  factory FiliereStrucuture.fromJson(dynamic json) {
    return FiliereStrucuture(
        filiere_id: json["filiere_id"], structure_id: json["structure_id"]);
  }
}
