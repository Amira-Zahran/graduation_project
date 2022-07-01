class Category{
  int? id;
  String? category_title;
  String? category_icon;

  Category({this.id, this.category_title, this.category_icon});

  factory Category.fromJson(Map<String, dynamic> json){
    return Category(
      id: json['id'],
      category_title: json['category_title'],
      category_icon: json['category_icon']
    );
  }
}