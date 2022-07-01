import 'package:delivery/src/Models/Address.dart';
import 'package:delivery/src/Models/Customer.dart';
import 'package:delivery/src/Models/Item.dart';

class Order {
    Address? address;
    String? created_at;
    Customer? customer;
    int? id;
    int? is_updated;
    int? op_id;
    List<Item>? items;
    int? order_id;
    String? status;
    String? subtotal;
    String? total;
    String? type;
    String? updated_at;

    Order({this.address, this.op_id, this.created_at, this.customer, this.id, this.is_updated, this.items, this.order_id, this.status, this.subtotal, this.total, this.type, this.updated_at});

    factory Order.fromJson(Map<String, dynamic> json) {
        return Order(
            address: json['address'] != null ? Address.fromJson(json['address']) : null, 
            created_at: json['created_at'], 
            customer: json['customer'] != null ? Customer.fromJson(json['customer']) : null, 
            id: json['id'],
            op_id: json['op_id'],
            is_updated: json['is_updated'],
            items: json['items'] != null ? (json['items'] as List).map((i) => Item.fromJson(i)).toList() : null, 
            order_id: json['order_id'], 
            status: json['status'], 
            subtotal: json['subtotal'], 
            total: json['total'], 
            type: json['type'], 
            updated_at: json['updated_at'], 
        );
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['created_at'] = this.created_at;
        data['id'] = this.id;
        data['is_updated'] = this.is_updated;
        data['order_id'] = this.order_id;
        data['status'] = this.status;
        data['subtotal'] = this.subtotal;
        data['total'] = this.total;
        data['type'] = this.type;
        data['updated_at'] = this.updated_at;
        return data;
    }
}