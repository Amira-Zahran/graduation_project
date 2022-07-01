class Category {
    String? category_icon;
    String? category_title;
    int? id;

    Category({this.category_icon, this.category_title, this.id});

    factory Category.fromJson(Map<String, dynamic> json) {
        return Category(
            category_icon: json['category_icon'], 
            category_title: json['category_title'], 
            id: json['id'], 
        );
    }


    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['category_icon'] = this.category_icon;
        data['category_title'] = this.category_title;
        data['id'] = this.id;
        return data;
    }
}