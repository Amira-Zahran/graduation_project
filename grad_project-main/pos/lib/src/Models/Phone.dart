class Phone {
    int? id;
    String? phone_number;

    Phone({this.id, this.phone_number});

    factory Phone.fromJson(Map<String, dynamic> json) {
        return Phone(
            id: json['id'], 
            phone_number: json['phone_number'], 
        );
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['id'] = this.id;
        data['phone_number'] = this.phone_number;
        return data;
    }
}