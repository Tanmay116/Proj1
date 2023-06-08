class Product {
  final int price;
  final String id, title, category, image, subTitle, description;
  Product({
    required this.id,
    required this.price,
    required this.title,
    required this.category,
    required this.image,
    required this.subTitle,
    required this.description,
  });

  factory Product.formJson(Map<String, dynamic> json) {
    return Product(
      id: json["id"],
      title: json["title"],
      image: json["image"],
      price: json["price"],
      category: json["category"],
      subTitle: json["subTitle"],
      description: json["description"],
    );
  }

  static fromJson(data) {}

}

Product product = Product(
    id: "1",
    price: 1600,
    title: "Wood Frame",
    image: "https://i.imgur.com/sI4GvE6.png",
    category: "Chair",
    subTitle: "Tieton Armchair",
    description: description,
  );

String description = "This armchair is an elegant and functional piece of furniture. It is suitable for families";