class OrderItem {
    int? id;
    String? item_name;
    String? item_photo;
    double? item_price;
    int? item_quantity;
    double? item_total_price;
    String? comment;
    int? item_id;

    OrderItem({this.id,this.item_name, this.item_photo, this.item_price, this.item_quantity, this.item_total_price,this.comment,this.item_id});

    factory OrderItem.fromJson(Map<String, dynamic> json) {
        print(double.parse((double.parse(json['total_price'].toString()) / int.parse(json['quantity'].toString())).toString()));
        return OrderItem(
            id: json['id'],
            item_id: json['item_id'],
            item_name: json['item_name'],
            item_photo: json['item_photo'],
            item_price: double.parse((double.parse(json['total_price'].toString()) / int.parse(json['quantity'].toString())).toString()),
            item_quantity: json['quantity'],
            item_total_price: double.parse(json['total_price']),
            comment: json['comment'],
        );
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['id'] = this.id;
        data['item_name'] = this.item_name;
        data['item_photo'] = this.item_photo;
        data['item_price'] = this.item_price;
        data['item_quantity'] = this.item_quantity;
        data['item_total_price'] = this.item_total_price;
        data['item_id'] = this.item_id;
        data['comment'] = this.comment;
        return data;
    }
}