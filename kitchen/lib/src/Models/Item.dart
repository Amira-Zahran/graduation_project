class Item {
    String? comment;
    int? id;
    String? item_name;
    int? quantity;
    String? status;
    String? photo;
    int? category;

    Item({this.comment, this.id, this.item_name, this.quantity, this.status,this.photo,this.category});

    factory Item.fromJson(Map<String, dynamic> json) {
        return Item(
            comment: json['comment'], 
            id: json['id'], 
            item_name: json['item_name'], 
            quantity: json['quantity'], 
            status: json['status'], 
            photo: json['photo'],
            category: json['category'],
        );
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['comment'] = this.comment;
        data['id'] = this.id;
        data['item_name'] = this.item_name;
        data['quantity'] = this.quantity;
        data['status'] = this.status;
        return data;
    }
}