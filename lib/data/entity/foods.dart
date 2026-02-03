class Foods {
  int id;
  String name;
  String imageUrl;
  int price;

  Foods({
    required this.id,
    required this.name,
    required this.imageUrl,
    required this.price,
  });

  factory Foods.fromJson(Map<String, dynamic> json) {
    return Foods(
      id: int.parse(json["yemek_id"]),
      name: json["yemek_adi"],
      imageUrl: json["yemek_resim_adi"],
      price: int.parse(json["yemek_fiyat"]),
    );
  }
}
