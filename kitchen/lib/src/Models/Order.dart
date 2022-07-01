import 'package:untitled6/src/Models/Item.dart';

class Order {
    String? created_at;
    int? id;
    List<Item>? items;
    int? order_id;
    String? status;
    String? type;

    Order({this.created_at, this.id, this.items, this.order_id, this.status,this.type});

    factory Order.fromJson(Map<String, dynamic> json) {
        return Order(
            created_at: json['created_at'],
            id: json['id'],
            items: (json['items'] as List).map((i) => Item.fromJson(i)).toList(),
            order_id: json['order_id'],
            status: json['status'],
            type: json['type'],
        );
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['created_at'] = this.created_at;
        data['id'] = this.id;
        data['order_id'] = this.order_id;
        data['status'] = this.status;
        if (this.items != null) {
            data['items'] = this.items?.map((v) => v.toJson()).toList();
        }
        return data;
    }
}