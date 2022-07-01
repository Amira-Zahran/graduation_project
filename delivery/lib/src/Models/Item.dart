class Item {
    String? comment;
    String? created_at;
    int? id;
    int? item_id;
    String? item_name;
    int? order_id;
    int? quantity;
    int? shift;
    String? status;
    String? total_price;
    String? updated_at;

    Item({this.comment, this.created_at, this.id, this.item_id, this.item_name, this.order_id, this.quantity, this.shift, this.status, this.total_price, this.updated_at});

    factory Item.fromJson(Map<String, dynamic> json) {
        return Item(
            comment: json['comment'], 
            created_at: json['created_at'], 
            id: json['id'], 
            item_id: json['item_id'], 
            item_name: json['item_name'], 
            order_id: json['order_id'], 
            quantity: json['quantity'], 
            shift: json['shift'], 
            status: json['status'], 
            total_price: json['total_price'], 
            updated_at: json['updated_at'], 
        );
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['comment'] = this.comment;
        data['created_at'] = this.created_at;
        data['id'] = this.id;
        data['item_id'] = this.item_id;
        data['item_name'] = this.item_name;
        data['order_id'] = this.order_id;
        data['quantity'] = this.quantity;
        data['shift'] = this.shift;
        data['status'] = this.status;
        data['total_price'] = this.total_price;
        data['updated_at'] = this.updated_at;
        return data;
    }
}