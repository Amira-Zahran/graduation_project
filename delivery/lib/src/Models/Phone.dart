class Phone {
    String? phone_number;

    Phone({this.phone_number});

    factory Phone.fromJson(Map<String, dynamic> json) {
        return Phone(
            phone_number: json['phone_number'], 
        );
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['phone_number'] = this.phone_number;
        return data;
    }
}