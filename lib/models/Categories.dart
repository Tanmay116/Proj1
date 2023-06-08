class Category {
  final int numOfProducts;
  final String id, title, image;
  Category({
    required this.id,
    required this.title,
    required this.image,
    required this.numOfProducts,
  });
// It creates a category in JSON
  factory Category.formJson(Map<String, dynamic> json) {
    return Category(
      id: json["id"],
      title: json["title"],
      image: json["image"],
      numOfProducts: json["numOfProducts"]
    );
  }
  
  static fromJson(data) {}

}

Category category = Category(
    id: "1",
    title: "Armchair",
    image: "https://i.imgur.com/JqKDdxj.png" ,
    numOfProducts: 100
  );
  