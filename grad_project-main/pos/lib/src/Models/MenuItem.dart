import 'package:pos/src/Models/Category.dart';

class MenuItem {
    int? active;
    Category? category;
    int? id;
    String? inventory_ingredients;
    String? item_name;
    String? item_photo;
    String? item_price;
    int? readyState;

    MenuItem({this.active, this.category, this.id, this.inventory_ingredients, this.item_name, this.item_photo, this.item_price, this.readyState});

    factory MenuItem.fromJson(Map<String, dynamic> json) {
        return MenuItem(
            active: json['active'], 
            category: Category.fromJson(json['category']),
            id: json['id'], 
            inventory_ingredients: json['inventory_ingredients'], 
            item_name: json['item_name'], 
            item_photo: json['item_photo'], 
            item_price: json['item_price'], 
            readyState: json['readyState'], 
        );
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['active'] = this.active;
        data['id'] = this.id;
        data['inventory_ingredients'] = this.inventory_ingredients;
        data['item_name'] = this.item_name;
        data['item_photo'] = this.item_photo;
        data['item_price'] = this.item_price;
        data['readyState'] = this.readyState;
        if (this.category != null) {
            data['category'] = this.category!.toJson();
        }
        return data;
    }
}